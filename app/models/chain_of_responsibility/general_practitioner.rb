module Patterns
  class GeneralPractitioner < Doctor

    def see_patient(patient)
      super(patient)
      if patient.has_illness? && patient.illness == SORE_THROAT
          patient.set_illness(NONE)
      else
        send_up_chain(patient)
      end
    end

    def description
      'Can handle general practice and non life threatening illnesses.'
    end

  end
end