module Patterns
  class Surgeon < Doctor

    def see_patient(patient)
      super(patient)
      if patient.has_illness? && patient.illness == INTERNAL_BLEEDING
        patient.set_illness(NONE)
      else
        send_up_chain(patient)
      end
    end

    def description
      'Can handle life threatening injuries.'
    end

  end
end