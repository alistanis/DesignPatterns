module Patterns

  # Player -> Object
  #
  # A quick data representation of a player's position
  class Player
    # The Vector2D of the player's location
    attr_accessor :position

    # Initializes the Player object
    #
    # Examples
    #
    #   => player = Player.new(3, 5)
    def initialize(x, y)
      @position = Vector2D.new(x, y)
    end

  end

  # Vector2D -> Object
  #
  # A quick data representation of a location in 2D space
  class Vector2D
    # The x and y values of the vector
    attr_accessor :x, :y

    # Initializes the Vector2D object
    #
    # Examples
    #
    #   => position = Vector2D.new(0, 5)
    def initialize(x, y)
      @x = x
      @y = y
    end
  end

end

