require 'rspec'
require 'Patterns/version'
include Patterns
require File.expand_path('../../test', __FILE__) +'/test_env.rb'
include HeroStates

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

    it '' do
      
    end

  end

end