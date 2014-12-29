module Patterns
  class Pediatrician < Doctor

    def see_patient(patient)
      super(patient)
      if patient.age < 18 && patient.has_illness? && patient.illness == SORE_THROAT
        patient.set_illness(NONE)
      else
        send_up_chain(patient)
      end
    end

    def description
      'Can handle non life threatening illnesses in children under the age of 18.'
    end

  end
end