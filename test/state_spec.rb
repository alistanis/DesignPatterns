require 'rspec'
require 'Patterns/version'
include Patterns
require File.expand_path('../../test', __FILE__) +'/test_env.rb'
include HeroStates
include MarkosLaptopStates
include MarkosLaptopCondition

describe 'StateTests' do

  context 'HeroState' do

    it 'Shows that the hero can switch and contain multiple states' do
      hero = Hero.new

      hero.add_state(MOVING)
      hero.add_state(IS_BEING_HIT)

      expect(hero.current_states.include?(MOVING)).to eql(true)
      expect(hero.current_states.include?(IS_BEING_HIT)).to eql(true)
    end

  end

  context 'MarkosLaptopState' do

    it 'Turns on' do
      laptop = MarkosLaptop.new

      laptop.turn_on
      expect(laptop.current_states.include?(ON)).to eql(true)
    end

    it 'Turns off' do
      laptop = MarkosLaptop.new

      laptop.turn_on
      laptop.turn_off
      expect(laptop.current_states.include?(OFF)).to eql(true)
    end

    it 'When thrown, the laptop dies and is in very bad condition' do
      laptop = MarkosLaptop.new

      laptop.throw_laptop
      expect(laptop.current_states.include?(DEAD)).to eql(true)
      expect(laptop.current_condition).to eql(VERY_BAD)
    end

    it 'When seltzer is spilled on the laptop, it drowns and is in very bad condition' do
      laptop = MarkosLaptop.new

      laptop.spill_seltzer
      expect(laptop.current_states.include?(DEAD)).to eql(true)
      expect(laptop.current_condition).to eql(VERY_BAD)
    end

    it 'When laptop is repaired, it can turn on, turn off, and is in fair condition' do
      laptop = MarkosLaptop.new
      laptop.warranty = true

      laptop.kill_laptop

      laptop.enter_repair
      laptop.repair_laptop

      expect(laptop.current_states.include?(OFF)).to eql(true)
      expect(laptop.current_condition).to eql(FAIR)

      laptop.turn_on
      expect(laptop.current_states.include?(ON)).to eql(true)
      expect(laptop.current_states.include?(OFF)).to eql(false)

      laptop.turn_off
      expect(laptop.current_states.include?(ON)).to eql(false)
      expect(laptop.current_states.include?(OFF)).to eql(true)
    end

  end

end