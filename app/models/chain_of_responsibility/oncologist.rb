module Patterns
  # Oncologist -> Doctor
  class Oncologist < Doctor

    # Sees a patient, if they have cancer the patient is cured, otherwise they are sent up the chain
    def see_patient(patient)
      super(patient)
      if patient.has_illness? && patient.illness == CANCER
          patient.set_illness(NONE)
      else
        send_up_chain(patient)
      end
    end

    # Description of the oncologist
    def description
      'Can handle all types of cancer.'
    end

  end
end