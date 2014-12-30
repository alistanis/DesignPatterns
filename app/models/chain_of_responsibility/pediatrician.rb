module Patterns
  # Pediatrician -> Doctor
  class Pediatrician < Doctor
    # The pediatrician sees a patient, cures the patient if they are a child and have a sore throat, passes up the chain otherwise
    def see_patient(patient)
      super(patient)
      if patient.age < 18 && patient.has_illness? && patient.illness == SORE_THROAT
        patient.set_illness(NONE)
      else
        send_up_chain(patient)
      end
    end

    # Description of the pediatrician
    def description
      'Can handle non life threatening illnesses in children under the age of 18.'
    end

  end
end