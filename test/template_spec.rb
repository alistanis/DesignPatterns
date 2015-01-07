require 'rspec'
require 'Patterns/version'
include Patterns
require File.expand_path('../../test', __FILE__) +'/test_env.rb'

describe 'TemplateTests' do
  context 'RunInspections' do
    it 'Can run an inspection successfully for both an automatic and manual transmission' do

      automatic_inspection = AutomaticInspection.new

      manual_inspection = ManualInspection.new


      automatic_inspection.run_inspection

      manual_inspection.run_inspection

    end
  end
end