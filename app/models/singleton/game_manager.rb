module Patterns

  # Constant declaration of GameManager as an Object
  GameManager = Object.new

  # GameManager -> Object
  #
  # A different type of singleton that acts as a global constant object. Methods are added to the GameManager object.
  class << GameManager

    WIDTH = 40
    HEIGHT = 20
    WALL = '#'
    FLOOR = '.'
    PLAYER = '@'

    # Initializes the game world, builds a game map, and sets the player's location
    #
    # Examples
    #
    #   => GameManager.init_world
    def init_world
      @game_map = Array.new(HEIGHT){Array.new(WIDTH){0}}
      @player = Player.new(0, 0)
      generate_map
      place_player
    end

    # Prints the game world
    #
    # Examples
    #
    #   => GameManager.print_world
    def print_world
      output = ''
      @game_map.each_index do |row|
        @game_map[0].each_index do |column|
          output << @game_map[row][column]
        end
        output << "\n"
      end
      puts "Current Game State: \n#{output}"
    end

    # Logs the current world state
    #
    # Examples
    #
    #   => GameManager.log_world
    def log_world
      output = ''
      @game_map.each_index do |row|
        @game_map[0].each_index do |column|
          output << @game_map[row][column]
        end
        output << "\n"
      end
      Logger.instance.info "Current Game State: \n#{output}"
    end

    # Returns the current world state
    #
    # Examples
    #
    #   => GameManager.get_world
    def get_world
      @game_map
    end

    # Returns the player's position
    #
    # Examples
    #
    #   => GameManager.get_player_position
    def get_player_position
      @player.position
    end

    # Returns the world size as a Vector2D Object
    #
    # Examples
    #
    #   => GameManager.get_world_size
    def get_world_size
      Vector2D.new(WIDTH, HEIGHT)
    end
    private

    # Generates the game_map
    def generate_map
      @game_map.each_index do |row|
        @game_map[0].each_index do |column|
          @game_map[row][column] = FLOOR
          if row == 0
            @game_map[row][column] = WALL
          end
          if column == 0
            @game_map[row][column] = WALL
          end
          if row == @game_map.length - 1
            @game_map[row][column] = WALL
          end
          if column == @game_map[0].length - 1
            @game_map[row][column] = WALL
          end
        end
      end
    end

    # Places the player on the game map in a random location
    def place_player
      @player.position.y = rand(1..HEIGHT-2)
      @player.position.x = rand(1..WIDTH-2)
      @game_map[@player.position.y][@player.position.x] = PLAYER
    end

  end
end