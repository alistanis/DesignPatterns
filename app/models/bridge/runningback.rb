require File.dirname(__FILE__) + '/football_player.rb'

module Patterns
  class Runningback < FootballPlayer

    def initialize
      super()
    end

    def run_ball
      'The runningback runs the ball!'
    end

    def kick_ball
      'The running back kicks the ball, and it lands 10 yards away.'
    end

    def position
      'Runningback'
    end

    def salary
      '70 Million over 4 years.'
    end

  end
end