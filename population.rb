class Population
  attr_accessor :members

  def initialize(objective, size, mutation_chance = 0.5)
    @mutation_chance = mutation_chance.to_f || 0.5
    @members = []
    @objective = objective
    @generation_number = 0
    @min_cost = 9999

    (0..size).each do
      gene = Gene.new().randomized(@objective)
      @members << gene
    end
  end

  def display
    puts"\r#{@members.first.code}\
     #{@members.first.cost} OBJECTIVE = #{@objective}\
     MIN COST #{@min_cost} GENERATIONS #{@generation_number} ---\r"
     STDOUT.write "\r"
  end

  def generation
    calc_cost_and_sort_members
    set_min_cost
    display
    crossover

    try_mutate
    return true if members[0].cost == 0
    @generation_number += 1
    # sleep 0.001
  end

  private

  def try_mutate
    @members.each_with_index do |_, i|
      @members[i].mutate(@mutation_chance)
      @members[i].calc_cost(@objective)

      next if @members[i].code != @objective
      display
      puts @members[i].code
      puts @members[i].cost
      puts @generation_number

      return true
    end
    return false
  end

  def crossover
    childrens = @members[0].mate(@members[1])
    childrens2 = @members[2].mate(@members[3])

    @members[-2..-1] = [childrens[0], childrens[1]]
    @members[-4..-3] = [childrens2[0], childrens2[1]]
  end

  def calc_cost_and_sort_members
    @members.each do |member|
      member.calc_cost(@objective)
    end

    @members = @members.sort_by &:cost
  end

  def set_min_cost
    return unless @members[0].cost < @min_cost

    @min_cost = @members[0].cost
  end
end
