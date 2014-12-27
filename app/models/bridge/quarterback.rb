require File.dirname(__FILE__) + '/football_player.rb'

module Patterns
  class Quarterback < FootballPlayer

    def initialize
      super()
    end

    def throw_ball
      puts 'The quarterback throws the ball!'
    end

    def run_ball
      puts 'The quarterback runs the ball! Hopefully he is a young Michael Vick.'
    end

    def kick_ball
      puts 'The quarterback kicks the ball! If it is Tom Brady, he drop kicks it.'
    end

    def position
      'Quarterback'
    end

    def salary
      '100 Million over 5 years.'
    end

  end
end