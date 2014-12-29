module Patterns
  class Oncologist < Doctor

    def see_patient(patient)
      super(patient)
      if patient.has_illness? && patient.illness == CANCER
          patient.set_illness(NONE)
      else
        send_up_chain(patient)
      end
    end

    def description
      'Can handle all types of cancer.'
    end

  end
end