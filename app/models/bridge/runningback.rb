require File.dirname(__FILE__) + '/football_player.rb'

module Patterns
  # Runningback -> FootballPlayer
  #
  # Overrides required methods from the FootballPlayer class
  class Runningback < FootballPlayer

    # Initializes the Runningback Class
    def initialize
      super()
    end

    # Overrides FootballPlayer run_ball method
    def run_ball
      'The runningback runs the ball!'
    end

    # Overrides FootballPlayer kick_ball method
    def kick_ball
      'The running back kicks the ball, and it lands 10 yards away.'
    end

    # Overrides FootballPlayer position method
    def position
      'Runningback'
    end

    # Overrides FootballPlayer salary method
    def salary
      '70 Million over 4 years.'
    end

  end
end