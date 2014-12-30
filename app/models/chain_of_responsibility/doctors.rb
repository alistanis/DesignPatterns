module Patterns
  # Doctors -> Object
  #
  # Acts as a single object containing multiple other objects that it manages.
  class Doctors
    # The surgeon object
    attr_accessor :surgeon
    # The oncologist object
    attr_accessor :oncologist
    # The general practitioner object
    attr_accessor :general_practitioner
    # The pediatrician object
    attr_accessor :pediatrician
    # The list of all of the doctors
    attr_accessor :doctors_list

    # Initializes the Doctors object and all of its members, then adds those members to the list.
    def initialize
      @doctors_list = []

      @surgeon = Surgeon.new
      @oncologist = Oncologist.new(surgeon)
      @general_practitioner = GeneralPractitioner.new(oncologist)
      @pediatrician = Pediatrician.new(general_practitioner)

      @doctors_list << @surgeon
      @doctors_list << @oncologist
      @doctors_list << @general_practitioner
      @doctors_list << pediatrician
    end

    # Starts the chain of responsibility by having the pediatrician see the first patient
    def see_patient(patient)
      @pediatrician.see_patient(patient)
    end
  end
end