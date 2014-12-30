module Patterns
  # GeneralPractitioner -> Doctor
  #
  # General practitioner object - Can handle adults (or children) with a sore throat.
  class GeneralPractitioner < Doctor

    # Sees a patient and either cures the patient or sends the patient up the chain
    def see_patient(patient)
      super(patient)
      if patient.has_illness? && patient.illness == SORE_THROAT
          patient.set_illness(NONE)
      else
        send_up_chain(patient)
      end
    end

    # Description of the general practitioner
    def description
      'Can handle general practice and non life threatening illnesses.'
    end

  end
end