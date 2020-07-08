# README
### Overview
This code is an example of how the genetic algorithm works.
In the class mainis where everything starts, passing by steps functions:

- Initial population
  Creates the population of individuals randomizing the genes of each chromosome, based on size of objective
- Fitness function
  Each individuals have a propertie that inform yours capability of to reach objective, in this example the cost is calculated by the distance from chars em ASCII code.
   Simple example 1:
  Given the goal is A

  A in ASCII is 65
  B in ASCII is 66

  The cost between A and B is 1, in the ASCII table

  This would be a good candidate, because he it's close of objective A

Simple example 2:
  A in ASCII is 65
  Z in ASCII is 92

  The cost between A and Z is 27

  This would not be a good candidate, because he is far from goal A

  In short, the fitness function calculate the cost
- Selection

- Crossover
- Mutation

### Below, I describe the flow:

