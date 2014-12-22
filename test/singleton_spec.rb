require 'rspec'
require 'Patterns/version'
include Patterns
require File.expand_path('../../test', __FILE__) +'/test_env.rb'

describe 'SingletonTests' do

  it 'should verify that a game manager can not be instantiated' do
    expect { GameManager.new }.to raise_exception
  end

  it 'should verify that a logger can not be instantiated' do
    expect {Patterns::Logger.new}.to raise_exception
  end

  it 'should be able to get an instance of Patterns::Logger' do
    expect(Logger.instance).to be_a(Patterns::Logger)
  end

  it 'should be able to initialize a game world and print it' do
    GameManager.init_world
    expect { print(GameManager.print_world) }.to output.to_stdout
  end

  it 'should be able to print the game state to the game log and verify it logged correctly' do

    GameManager.init_world
    player_position = GameManager.get_player_position
    world_data = GameManager.get_world_string

    Logger.instance.info "Player position x: #{player_position.x}, Player position y: #{player_position.y}"
    GameManager.log_world
    log_data = `tail -n 21 #{File.expand_path('../../app/models/singleton/log/', __FILE__) + '/game_log.log'}`

    expect(world_data + "\n").to eql(log_data)

  end

  it 'should verify that the logger is thread safe' do
    mutex       = Mutex.new
    threads     = []
    thread_count = 4
    thread_number = 0
    thread_count.times do |i|
      threads[i] = Thread.new {
          thread_number += 1
          Thread.current[:fileno] = thread_number

        Logger.instance.info "Thread #[#{Thread.current[:fileno]}/#{thread_count}] Logging began at #{Time.now}"
      }
    end
    threads.each { |t| t.join }
  end

  it 'should verify that the game manager is NOT thread safe' do
    # note that this will not throw an exception, it will simply cause inconsistent sets of data
    threads = []
    thread_count = 10
    thread_number = 0
    GameManager.init_world
    stored_world_data = []
   thread_count.times do |i|
      threads[i] = Thread.new {
        thread_number += 1
        world_data = GameManager.get_world
        stored_world_data[i] = world_data
      }
   end
    threads.each { |t| t.join }
    difference_found = false
    previous = nil
    output = ''
      stored_world_data.each do |data|
        if previous != nil
          if output != previous
            puts 'true'
            difference_found = true
          end
        end
        output = ''

        data.each_index do |row|
        data[0].each_index do |column|
          output << data[row][column]
        end
        output << "\n"
        end
        previous = output
      end
  end

end