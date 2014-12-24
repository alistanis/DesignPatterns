require 'rspec'
require 'Patterns/version'
include Patterns
require File.expand_path('../../test', __FILE__) +'/test_env.rb'

describe 'TypeObjectTests' do
  context 'TypeObject assignment' do
    it 'Loads prototype and base type data if it exists for all monster types, or just base type if it does not have a prototype' do

      dragon = Monster.new('dragon')
      high_dragon = Monster.new('high_dragon')

      orc = Monster.new('orc')
      orc_wizard = Monster.new('orc_wizard')

      expect(dragon.health).to eql(100)
      expect(high_dragon.health).to eql(150)
      expect(orc.health).to eql(30)
      expect(orc_wizard.health).to eql(30)

    end

    it 'Raises an exception if the monster type does not exist' do
      expect {Monster.new('zombie')}.to raise_exception(MonsterNotFound)
    end

    it 'Gets a prototype name if it exists, and returns "none" if it does not' do
      high_dragon = Monster.new('high_dragon')
      expect(high_dragon.prototype_name).to eql('dragon')

      dragon = Monster.new('dragon')
      expect(dragon.prototype_name).to eql('none')
    end

    it 'Gives detailed exception information for MonsterNotFound' do
      begin
        Monster.new('zombie')
      rescue Exception => e
        expect {puts e.inspect}.to output.to_stdout
      end
    end
  end

  context 'TypeObject Marshal and Deep Clone Tests' do
    it 'Loads all monster prototypes into memory, clones them, and verifies that their object_id\'s are different' do
      monsters = MonsterPrototypes.new

      dragon = monsters.clone_type('dragon')
      dragon2 = monsters.clone_type('dragon')

      orc = monsters.clone_type('orc_wizard')
      orc2 = monsters.clone_type('orc_wizard')

      expect(dragon.object_id).not_to eql(dragon2.object_id)
      expect(orc.object_id).not_to eql(orc2.object_id)

    end

    it 'Loads all monster prototypes into memory, deep clones them(marshal/unmarshal), and verifies that their prototype object_id\'s are different' do
      monsters = MonsterPrototypes.new

      orc = monsters.clone_type('orc')
      orc2 = monsters.clone_type('orc')

      expect(orc.monster_type.object_id).not_to eql(orc2.monster_type.object_id)
    end

    it 'Demonstrates that a shallow clone is not sufficient for prototyping by showing that the object id\'s for clones are different, but the underlying prototype id\'s are the same' do
      monsters = MonsterPrototypes.new

      orc = monsters.clone_type('orc')
      orc2 = orc.clone

      expect(orc.object_id).not_to eql(orc2.object_id)
      expect(orc.monster_type.object_id).to eql(orc2.monster_type.object_id)
    end

    it 'Demonstrates a better clone method (on the monster class) by showing that all object id\'s are different' do
      orc = Monster.new('orc')
      orc2 = orc.deep_clone

      expect(orc.monster_type.object_id).not_to eql(orc2.monster_type.object_id)
    end

    it 'Raises an UnsupportedType exception if something other than a String or MonsterType is passed to Monster.new' do
      expect {Monster.new(0)}.to raise_exception(UnsupportedType)
      expect {Monster.new(:symbol)}.to raise_exception(UnsupportedType)
      expect {Monster.new('werewolf')}.to raise_exception(MonsterNotFound)
    end

    it 'Create n number of orcs using threads and demonstrates the ruby threadwall' do
      start_time = Time.now
      orcs = []
      threads = []
      thread_count = 10000
      thread_count.times do |i|
        threads[i] = Thread.new {
          orcs[i] = Monster.new('orc')
        }
      end
      threads.each {|t| t.join}
      end_time = Time.now
      total_run_time = end_time - start_time
      expect(total_run_time).to be_between(5, 15)
    end


    $total_marshal_run_time = 0
    it 'Take longer than n / (n * 0.1) seconds to marshal and then unmarshal objects' do
      monsters = MonsterPrototypes.new
      start_time = Time.now
      orcs = []
      num = 100000
      orc_clones = []
      for i in 0..num
        orcs[i] = Monster.new('orc')
      end

      count = 0
      orcs.each do |orc|
        orc_clones[count] = monsters.clone_type('orc')
        count += 1
      end
      end_time = Time.now
      $total_marshal_run_time = end_time - start_time
      expect($total_marshal_run_time).not_to be_between(0, num / (num * 0.1))
    end

    it 'Completes n number of efficient clones in n / (n * 0.1) seconds' do
      start_time = Time.now
      orcs = []
      num = 100000
      orc_clones = []
      for i in 0..num
        orcs[i] = Monster.new('orc')
      end

      count = 0
      orcs.each do |orc|
        orc_clones[count] = orc.deep_clone
        count += 1
      end
      end_time = Time.now
      total_run_time = end_time - start_time
      expect(total_run_time).to be_between(0, $total_marshal_run_time)
    end
  end
end