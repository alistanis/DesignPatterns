module Patterns
  class Patient
    attr_accessor :illness
    attr_accessor :age

    def initialize(age, illness = nil)
      @age = age
      @illness = illness
    end

    def set_illness(illness)
      @illness = illness
    end

    def has_illness?
      if @illness == NONE || @illness == nil
        false
      else
        true
      end
    end

  end
end