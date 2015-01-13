module Patterns

  module HeroStates
    NIL = 0
    ALIVE = 1
    DEAD = 2
    MOVING = 3
    STANDING_STILL = 4
    IS_BEING_HIT = 5
    IS_RECOVERING = 6
  end

  class Hero
    attr_accessor :current_states, :hp
    
    def initialize
      @current_states = []
      @hp = 100
    end

    def add_state(state)
      @current_states << state
    end

    def remove_state(state)
      @current_states.delete(state)
    end

    def move
      if is_alive?
        add_state(MOVING)
      end
    end

    def stop_moving
      remove_state(MOVING)
    end

    def is_alive?
      @current_states.include?(ALIVE)
    end

    def kill_player
      if is_alive?
        remove_state(ALIVE)
        add_state(DEAD)
      else
        raise PlayerIsAlreadyDead, 'Player is already dead.'
      end
    end

    def revive_player
      unless is_alive?
        remove_state(ALIVE)
        add_state(DEAD)
      end
    end

    def take_damage(damage)
      if is_alive?
        unless @current_states.include?(IS_BEING_HIT) || @current_states.include?(IS_RECOVERING)
          @hp -= damage
          if @hp <= 0
            kill_player
          end
        end
      end
    end

  end

  class PlayerIsAlreadyDead < StandardError
  end

end