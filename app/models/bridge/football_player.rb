require File.dirname(__FILE__) + '/abstract_interface.rb'

module Patterns
  class FootballPlayer
    include Patterns::AbstractInterface

    def initialize

    end

    # Some documentation on the change_gear method
    def throw_ball
      FootballPlayer.api_not_implemented(self)
    end

    # Some documentation on the speed_up method
    def run_ball
      FootballPlayer.api_not_implemented(self)
    end

    def kick_ball
      FootballPlayer.api_not_implemented(self)
    end

    def position
      FootballPlayer.api_not_implemented(self)
    end

    def salary
      FootballPlayer.api_not_implemented(self)
    end

  end

end
