module Patterns
  # Surgeon -> Doctor
  #
  # Surgeon object - can handle internal bleeding
  class Surgeon < Doctor

    # Sees a patient, cures them if they have internal bleeding, sends them up the chain otherwise
    def see_patient(patient)
      super(patient)
      if patient.has_illness? && patient.illness == INTERNAL_BLEEDING
        patient.set_illness(NONE)
      else
        send_up_chain(patient)
      end
    end

    # Description of the suregon
    def description
      'Can handle life threatening injuries.'
    end

  end
end