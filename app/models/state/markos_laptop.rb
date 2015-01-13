module Patterns

  module MarkosLaptopStates
    NIL = 0
    ON = 1
    OFF = 2
    DEAD = 3
    FALLING = 4
    DROWNING = 5
    REPAIR = 6
  end

  module MarkosLaptopCondition
    NIL = 0
    VERY_BAD = 1
    BAD = 2
    FAIR = 3
    GOOD = 4
    EXCELLENT = 5
    NEW = 6
  end

  class MarkosLaptop
    attr_accessor :current_states, :warranty, :current_condition

    def initialize
      @current_states = []
      @warranty = false
      @current_condition = FAIR
    end

    def add_state(state)
      @current_states << state
    end

    def remove_state(state)
      @current_states.delete(state)
    end

    def turn_on
      unless @current_states.include?(DEAD) || @current_states.include?(ON)
        if @current_states.include?(OFF)
          remove_state(OFF)
          add_state(ON)
        end
      end
    end

    def turn_off
      unless @current_states.include?(OFF)
        if @current_states.include?(ON)
          remove_state(ON)
          add_state(OFF)
        end
      end
    end

    def throw_laptop
      unless @current_states.include?(FALLING) || @current_states.include?(DROWNING)
        if @current_states.include?(REPAIR)
          remove_state(REPAIR)
        end
        add_state(FALLING)
        degrade_condition
        kill_laptop
      end
    end

    def laptop_hits_ground
      kill_laptop
    end

    def kill_laptop
      @current_states = [DEAD, OFF]
      @current_condition = VERY_BAD
    end

    def degrade_condition
      if @current_condition > 1
        @current_condition -= 1
      end
    end

    def spill_seltzer
      unless @current_states.include?(DROWNING)
        add_state(DROWNING)
        degrade_condition
        kill_laptop
      end
    end

    def enter_repair
      if @warranty
        unless @current_states.include?(REPAIR)
          if @current_states.include?(DEAD)
            add_state(REPAIR)
          end
        end
      else
        'Too bad'
      end
    end

    def repair_laptop
      if @current_states.include?(REPAIR)
        remove_state(DEAD)
        remove_state(REPAIR)
        add_state(OFF)
        @current_condition = FAIR
      end
    end

  end
end