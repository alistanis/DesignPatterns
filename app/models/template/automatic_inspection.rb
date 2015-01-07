require File.dirname(__FILE__) + '/car_inspection.rb'
module Patterns
  class AutomaticInspection < CarInspection

    def initialize
      @engine_test = false
      @door_test = false
      super
    end

    def start_engine
      @engine_test = true
    end


    def door_test
      @door_test = true
    end

  end
end