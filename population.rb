class Population
  attr_accessor :members, :objective, :min_cost, :generation_number

  def initialize(objective, size, mutation_chance = 0.5)
    @size = size
    @mutation_chance = mutation_chance.to_f || 0.5
    @members = []
    @objective = objective
    @generation_number = 0
    @min_cost = 9999

    generate_chromosome
  end

  def generate_chromosome
    (0..@size).each do
      chromosome = Chromosome.new().randomized(@objective)
      @members << chromosome
    end
  end

  def display
    puts"#{@members.first.code}\
      OBJECTIVE = #{@objective}\
     MIN COST #{@min_cost} GENERATIONS #{@generation_number} ---"
     STDOUT.write "\r"
  end

  def generation
    calc_cost_and_sort_members
    set_min_cost
    display
    crossover

    try_mutate
    return true if members[0].cost == 0 || @objective == 'exit'
    @generation_number += 1
    sleep 0.01
  end

  private

  def try_mutate
    @members.each_with_index do |_, i|
      @members[i].mutate(@mutation_chance)
      @members[i].calc_cost(@objective)

      next if @members[i].code != @objective
      display


      return true
    end
    return false
  end

  def crossover
    childrens = @members[0].mate(@members[1])
    childrens2 = @members[2].mate(@members[3])

     # In this block, there is an ordering of the best and the exclusion of the worst members, copying the best result to the others
    #  @members = @members.sort_by &:cost
    #  for i in 1..@members.length - 1
    #   if @members.first.cost < @members[i].cost
    #    @members[i] = @members.first
    #   end
    #  end
    @members[-2..-1] = [childrens[0], childrens[1]]
    @members[-4..-3] = [childrens2[0], childrens2[1]]


  end

  def calc_cost_and_sort_members
    if @members[0].code.length != @objective.length
      @members = []
      generate_chromosome
    end

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
