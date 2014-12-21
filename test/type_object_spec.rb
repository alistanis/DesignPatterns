require 'rspec'
require 'Patterns/version'

Dir["#{File.expand_path('../../app/', __FILE__)}/**/*.rb"].each { |f| load(f) }

include Patterns

describe 'TypeObjectTests' do
  it 'should be able to load prototype and base type data if it exists for all monster types, or just base type if it does not have a prototype' do

    dragon = Monster.new('dragon')
    high_dragon = Monster.new('high_dragon')

    orc = Monster.new('orc')
    orc_wizard = Monster.new('orc_wizard')

    expect dragon.health == 100
    expect high_dragon.health == 150
    expect orc.health == 30
    expect orc_wizard.health == 30

  end

  it 'should raise an exception if the monster type does not exist' do
    expect {Monster.new('zombie')}.to raise_exception
  end

  it 'should be able to get a prototype name if it exists' do
    high_dragon = Monster.new('high_dragon')
    expect high_dragon.prototype_name == 'dragon'

    dragon = Monster.new('dragon')
    expect dragon.prototype_name == 'none'
  end
end