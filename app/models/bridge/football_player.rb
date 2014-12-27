require File.dirname(__FILE__) + '/abstract_interface.rb'

module Patterns
  # FootballPlayer -> Object
  #
  # Modules: Patterns::AbstractInterface
  #
  # An interface class that represents a football player and some of the activities a player might perform
  class FootballPlayer
    include Patterns::AbstractInterface

    #initializes the FootballPlayer class
    def initialize

    end

    # Raises an exception if the function is not overridden in a child class
    # Returns a string that represents a description of the action that occurs when the player throws the ball
    def throw_ball
      FootballPlayer.api_not_implemented(self)
    end

    # Raises an exception if the function is not overridden in a child class
    # Returns a string that represents a description of the action that occurs when the player runs the ball
    def run_ball
      FootballPlayer.api_not_implemented(self)
    end

    # Raises an exception if the function is not overridden in a child class
    # Returns a string that represents a description of the action that occurs when the player kicks the ball
    def kick_ball
      FootballPlayer.api_not_implemented(self)
    end

    # Raises an exception if the function is not overridden in a child class
    # Returns a string that represents the player's position
    def position
      FootballPlayer.api_not_implemented(self)
    end

    # Raises an exception if the function is not overridden in a child class
    # Returns a string representing a description of the player's salary
    def salary
      FootballPlayer.api_not_implemented(self)
    end

  end

end
