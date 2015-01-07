module Patterns
  class CarInspection

    attr_accessor :horn_test, :headlights_test, :all_tests

    def initialize
      @horn_test = false
      @headlights_test = false
    end

    def run_inspection
      start_inspection
      end_inspection
    end

    def start_inspection
      start_engine
      test_horn
      test_headlights
      door_test
    end

    # manual transmission difference
    def start_engine
    end

    def test_horn
      @horn_test = true
    end

    def test_headlights
      @headlights_test = false
    end

    # door test different for different cars
    def door_test
    end

    def end_inspection
      if pass?
        pass_inspection
      else
        fail_inspection
      end
    end

    def pass?

      @all_tests = []

      @all_tests << @engine_test
      @all_tests << @door_test
      @all_tests << @horn_test
      @all_tests << @headlights_test

      num_passed = 0
      @all_tests.each do |test|
        if test
          num_passed += 1
        end
      end
      if num_passed >= 3
        true
      else
        false
      end
    end

    def pass_inspection
      apply_sticker
    end

    def apply_sticker
      puts 'Yay!'
    end

    def fail_inspection
      give_rejection_sticker
    end

    def give_rejection_sticker
      puts 'Your name must be Kevin'
    end

  end
end