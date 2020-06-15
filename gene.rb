class Gene
  attr_accessor :code, :cost

  def initialize(code = '')
    @code = code
    @cost = 9999
  end

  def randomized(goal_length)
    @code = random_string(goal_length.length)
    return Gene.new(@code)
  end

  def random_string(length = 10, complexity = 4)
    subsets = [("a".."z"), ("A".."Z")]
    chars = subsets[0..complexity].map { |subset| subset.to_a }.flatten
    chars.sample(length).join
  end

  def mutate(chance = 0.5)
    return if rand() > chance

    index = (rand() * @code.length).floor()
    return if @code.empty?|| @code.chars[index].ord == 0

    up_or_down = rand() <= 0.5 ? -1 : 1
    new_char = (@code.chars[index].ord + up_or_down).chr("UTF-8")
    newString = ''

    @code.chars.each_with_index do |_, i|

      if i == index
        newString += new_char # troca a letra
      else
        newString += @code[i] # Se não, vai montando com os mesmos chars
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
    (0..@code.length - 1).each_with_index do |_, i|
      total += (@code[i].ord - compare_to[i].ord) * (@code[i].ord - compare_to[i].ord)
    end
    @cost = total
  end
end

