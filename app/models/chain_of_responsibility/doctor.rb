module Patterns
  # Doctor -> ChainNode
  #
  # Doctor class that contains shared functions for all Doctor child classes
  class Doctor < ChainNode
    # Boolean: has the doctor seen a patient?
    attr_accessor :saw_patient
    # Number: Number of patients seen
    attr_accessor :patients_seen

    # Calls the ChainNode initialize function and sets patients seen = 0
    def initialize(next_node = nil)
      super(next_node)
      @patients_seen = 0
    end

    # Sets saw patient = true and adds 1 to patients seen
    def see_patient(patient)
      @saw_patient = true
      @patients_seen += 1
    end

    # Returns true or false if the doctor has seen a patient
    def saw_patient?
      if @saw_patient
        true
      else
        false
      end
    end

  end
end