require './gene.rb'
require './population.rb'
require 'pry'

class Main
  puts "Digite Algo"
  algo = gets.chomp()
  population = Population.new(algo, 10)

  loop do
    break if population.generation == true
  end
end