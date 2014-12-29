module Patterns
  class Doctors
    attr_accessor :surgeon
    attr_accessor :oncologist
    attr_accessor :general_practitioner
    attr_accessor :pediatrician
    attr_accessor :doctors_list

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

    def see_patient(patient)
      @pediatrician.see_patient(patient)
    end
  end
end