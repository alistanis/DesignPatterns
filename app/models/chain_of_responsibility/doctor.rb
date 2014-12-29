module Patterns
  class Doctor < ChainNode
    attr_accessor :saw_patient
    attr_accessor :patients_seen

    def initialize(next_node = nil)
      super(next_node)
      @patients_seen = 0
    end

    def see_patient(patient)
      @saw_patient = true
      @patients_seen += 1
    end

    def saw_patient?
      if @saw_patient
        true
      else
        false
      end
    end

  end
end