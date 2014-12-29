require 'rspec'
require 'Patterns/version'

require File.expand_path('../../test', __FILE__) +'/test_env.rb'

include Patterns
include Patterns::Illness


describe 'ChainOfResponsibilityTests' do

  it 'Can delegate a patient all the way up the chain' do
    doctors = Doctors.new
    patient = Patient.new(27, ZOMBIE_VIRUS)

    doctors.see_patient(patient)

    expect(patient.has_illness?).to eql(true)

    doctors.doctors_list.each do |doctor|
      expect(doctor.saw_patient?).to eql(true)
    end
  end

  it 'Will not continue to delegate if the patient is cured' do
    doctors = Doctors.new
    patient = Patient.new(12, SORE_THROAT)

    doctors.see_patient(patient)

    expect(patient.has_illness?).to eql(false)

    doctors.doctors_list.delete(doctors.pediatrician)

    doctors.doctors_list.each do |doctor|
      expect(doctor.saw_patient?).to eql(false)
    end
  end

  it 'Can cure all illnesses except zombie virus' do
    doctors = Doctors.new

    young_patient = Patient.new(12, SORE_THROAT)
    adult_patient = Patient.new(24, SORE_THROAT)
    cancer_patient = Patient.new(20, CANCER)
    gunshot_patient = Patient.new(25, INTERNAL_BLEEDING)

    patients = []
    patients << young_patient
    patients << adult_patient
    patients << cancer_patient
    patients << gunshot_patient

    patients.each do |patient|
      doctors.see_patient(patient)
    end

    patients.each do |patient|
      expect(patient.has_illness?).to eql(false)
    end

  end
end