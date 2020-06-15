class Gene
  attr_accessor :code, :cost

  def initialize(code = '')
    if(code)
      @code = code
    end
      @cost = 9999
  end

  def randomize(goal_length)

    # (0..goal_length.length).each do
      # @code += rand(0..255).floor.chr("UTF-8")
      # @code +=
    # end
    @code = rng(goal_length.length)
    return Gene.new(@code)
  end

  def rng(length = 10, complexity = 4)
    # subsets = [("a".."z"), ("A".."Z"), (0..9), ("!".."?"), ("µ".."ö")]
    subsets = [("a".."z"), ("A".."Z")]
    chars = subsets[0..complexity].map { |subset| subset.to_a }.flatten
    chars.sample(length).join
  end

  def mutate(chance = 0.5)

    chars = [65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122]
    # return if (rand() > chance)

    index = (rand() * @code.length).floor()
    return if @code.empty?|| @code.chars[index].ord == 0

    up_or_down = rand() <= 0.5 ? -1 : 1
    newChar = (@code.chars[index].ord + up_or_down).chr("UTF-8")
    newString = ''

    @code.chars.each_with_index do |_, i|

      if (i == index)
        newString += newChar # troca a letra
      else
        newString += @code[i] # Se não, monta com os mesmos chars
      end
    end

    @code = newString
  end

  def mate(gene)

   if @code.length.to_f % 2 == 0
    pivot = ((@code.length.to_f / 2)).round()
     else
    pivot = ((@code.length.to_f / 2).round()) - 1
   end

    child1 = ""
    0..pivot.times {|i| child1 += @code[i]}
    for i in (pivot)..@code.length - 1 do
      child1 += gene.code[i]
    end

    child2 = ""
    0..pivot.times {|i| child2 += gene.code[i]}
    for i in (pivot)..gene.code.length - 1 do
      child2 += @code[i]
    end

    [Gene.new(child1), Gene.new(child2)]
  end

  def calc_cost(compare_to)
    total = 0
    begin
      (0..@code.length - 1).each_with_index do |_, i|
        total += (@code[i].ord - compare_to[i].ord) * (@code[i].ord - compare_to[i].ord)
      end
      @cost = total

    rescue NoMethodError => exception
      binding.pry
    end
  end
end

