require './gene.rb'
require './population.rb'
require 'pry'
require "timeout"



class Main



  puts "Digite o objetivo:"
  objective = gets.chomp

  puts "Digite a quantidade de genes:"
  gene_limit = gets.chomp.to_i
  puts "Digite a chance de mutação, exemplo: 0.5, significa 50%:"
  mutate_chance = gets.chomp.to_f
  mutate_chance = 0.5 if mutate_chance == 0.0
  gene_limit = 4 if gene_limit < 4


  population = Population.new(objective, gene_limit, mutate_chance)
  print objective


  t = Thread.new do
while population.objective != "exit"
  break if population.min_cost == 0
    begin
      Timeout::timeout 0.1 do
        STDOUT.print "Altere  "
        population.objective = gets.chomp
      end
    rescue => exception

    end
  end
end

  t2 = Thread.new do
    loop do
      break if population.generation == true
    end
  end
  t.join
  t2.join
end