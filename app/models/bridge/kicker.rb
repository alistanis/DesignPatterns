require File.dirname(__FILE__) + '/football_player.rb'

module Patterns
  # Kicker -> FootballPlayer
  #
  # Overrides required methods from the FootballPlayer class
  class Kicker < FootballPlayer

    # Initializes the kicker class
    def initialize
      super()
    end

    # Overrides FootballPlayer throw_ball method
    def throw_ball
      'The kicker tries to throw the ball, and it is an hilarious failure.'
    end

    # Overrides FootballPlayer run_ball method
    def run_ball
      'The kicker tries to run the ball and will likely be fired before the next game.'
    end

    # Overrides FootballPlayer kick_ball method
    def kick_ball
      'The kicker kicks the ball!'
    end

    # Overrides FootballPlayer position method
    def position
      'Kicker'
    end

    # Overrides FootballPlayer salary method
    def salary
      '30 Million over 10 years.'
    end

  end
end