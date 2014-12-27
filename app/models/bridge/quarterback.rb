require File.dirname(__FILE__) + '/football_player.rb'

module Patterns
  # Quarterback -> FootballPlayer
  #
  # Overrides required methods from the FootballPlayer class
  class Quarterback < FootballPlayer

    # Initializes the Quarterback class
    def initialize
      super()
    end

    # Overrides FootballPlayer throw_ball method
    def throw_ball
      puts 'The quarterback throws the ball!'
    end

    # Overrides FootballPlayer run_ball method
    def run_ball
      puts 'The quarterback runs the ball! Hopefully he is a young Michael Vick.'
    end

    # Overrides FootballPlayer kick_ball method
    def kick_ball
      puts 'The quarterback kicks the ball! If it is Tom Brady, he drop kicks it.'
    end

    # Overrides FootballPlayer position method
    def position
      'Quarterback'
    end

    # Overrides FootballPlayer salary method
    def salary
      '100 Million over 5 years.'
    end

  end
end