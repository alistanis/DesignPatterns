require File.dirname(__FILE__) + '/football_player.rb'

module Patterns
  class Kicker < FootballPlayer

    def initialize
      super()
    end

    def throw_ball
      'The kicker tries to throw the ball, and it is an hilarious failure.'
    end

    def run_ball
      'The kicker tries to run the ball and will likely be fired before the next game.'
    end

    def kick_ball
      'The kicker kicks the ball!'
    end

    def position
      'Kicker'
    end

    def salary
      '30 Million over 10 years.'
    end

  end
end