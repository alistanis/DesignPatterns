module Patterns
  class ManualInspection < CarInspection
    attr_accessor :engine_test, :door_test
    def initialize
      @engine_test = false
      @door_test = false
      super
    end

    def start_engine
      @engine_test = true
    end


    def door_test
      @door_test = false
    end


  end
end