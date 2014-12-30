module Patterns
  # Patient -> Object
  class Patient
    # The illness the patient has
    attr_accessor :illness
    # The age of the patient
    attr_accessor :age

    # Initializes the patient class with an age and an illness/no illness
    def initialize(age, illness = nil)
      @age = age
      @illness = illness
    end

    # Sets the patient's illness
    def set_illness(illness)
      @illness = illness
    end

    # Returns false if patient illness is NONE or nil, true otherwise
    def has_illness?
      if @illness == NONE || @illness == nil
        false
      else
        true
      end
    end

  end
end