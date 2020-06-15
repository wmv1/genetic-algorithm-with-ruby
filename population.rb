class Population
  attr_accessor :members
  # @goal is string that AI go to find
  def initialize(goal, size)
    @members = []
    @goal = goal
    @generation_number = 0
    @min_cost = 9999

    (0..size).each do
      gene = Gene.new().randomize(@goal)
      @members << gene
    end
  end

  def display

    result = ""
    # (0..@members.length - 1).each_with_index do |_, i|
    #   result += "\r#{@members[i].code} " " + #{@members[i].cost.to_s}"
    # end
    # binding.pry
    STDOUT.write "\r#{@members.first.code} #{@members.first.cost} GOAL = #{@goal}  MIN COST #{@min_cost} GEN #{@generation_number}   \r"

  end

  def generation
    @members.each do |member|
      member.calc_cost(@goal)
    end

    @members = @members.sort_by &:cost

    if @members[0].cost < @min_cost
      @min_cost = @members[0].cost
    end

    self.display()

    childrens = @members[0].mate(@members[1])
    childrens2 = @members[2].mate(@members[3])

    # childrens[0].calc_cost(@goal)
    # childrens[1].calc_cost(@goal)
    # childrens2[0].calc_cost(@goal)
    # childrens2[1].calc_cost(@goal)

    @members[-2..-1] = [childrens[0], childrens[1]]
    @members[-4..-3] = [childrens2[0], childrens2[1]]

    @members.each_with_index do |_, i|
      @members[i].mutate(0.5)
      @members[i].calc_cost(@goal)

      if (@members[i].code == @goal)
          self.display()
          puts @members[i].code
          puts @members[i].cost

          return true
      end
    end
    @generation_number += 1
    sleep 0.01
  end
end

