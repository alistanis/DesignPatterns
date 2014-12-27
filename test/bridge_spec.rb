require 'rspec'
require 'Patterns/version'
include Patterns
require File.expand_path('../../test', __FILE__) +'/test_env.rb'

describe 'BridgeTests' do
  context 'AbstractInterfaceTesting' do
    it 'Throws an InterfaceNotImplemented exception when a method that has not been implemented is called in a child class' do
      running_back = Runningback.new
      expect{running_back.throw_ball}.to raise_exception(AbstractInterface::InterfaceNotImplemented)
    end

    it 'Does not throw an InterfaceNotImplemented exception after the method has been defined for the child class' do
      running_back = Runningback.new
      # Example of decorator pattern, modifying instance variable at runtime
      class << running_back
        def throw_ball
          'If the running back is Arian Foster, he throws a touchdown. Otherwise, this is probably a bad idea.'
        end
      end
      expect{puts running_back.throw_ball}.to output.to_stdout
    end
  end
end