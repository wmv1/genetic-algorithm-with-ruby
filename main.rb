require './chromosome.rb'
require './population.rb'
require 'pry'
require "timeout"

class Main
  puts "Digite o objetivo:"
  objective = gets.chomp

  puts "Digite a quantidade de individuos:"
  chromosome_limit = gets.chomp.to_i
  puts "Digite a chance de mutação, exemplo: 0.5, significa 50%:"
  mutate_chance = gets.chomp.to_f
  mutate_chance = 0.5 if mutate_chance == 0.0
  chromosome_limit = 4 if chromosome_limit < 4


  population = Population.new(objective, chromosome_limit, mutate_chance)
  print objective

  t = Thread.new do
    while population.generation != true
      break if population.min_cost == 0
      begin
        Timeout::timeout 0.001 do
          STDOUT.print " "
          population.objective = gets.chomp
        end
      rescue => exception

      end
    end

    puts ""
    puts "Objetivo:  #{population.objective}"
    puts "Resultado: #{population.members.select {|member| member.cost == 0}}"
    puts "Números de gerações: #{population.generation_number}"
    pp puts "Resultado: #{population.members}";0
  end

  t.join
end