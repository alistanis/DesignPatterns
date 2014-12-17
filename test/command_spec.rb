require 'rspec'
require 'Patterns/version'
require 'pp'

Dir["#{File.expand_path('../../app/', __FILE__)}/**/*.rb"].each { |f| load(f) }

include Patterns


describe 'CommandTests' do

  it 'should create a file, verify it exists, and then delete a file' do

    path = '/tmp/test.txt'
    create_file = Patterns::CreateFile.new(path, 'Testing create file.')
    create_file.execute
    expect File.exists?(path) == true
    create_file.undo
    expect File.exists?(path) == false

  end

  it 'should delete a file, store its data, and then undo the operation' do

    path = '/tmp/test.txt'
    `touch #{path}`
    delete_file = Patterns::DeleteFile.new(path)
    delete_file.execute
    expect File.exists?(path) == false

    delete_file.undo
    expect File.exists?(path) == true

  end

  it 'should copy a file from a source path to a target path' do
    source = '/tmp/test.txt'
    target = '/tmp/test2.txt'

    f = File.open(source, 'w')
    data = 'Testing copy file command'
    f.write(data)
    f.close

    copy_file = Patterns::CopyFile.new(source, target)
    copy_file.execute
    source_data = File.read(source)
    target_data = File.read(target)

    expect source_data == target_data

    copy_file.undo

    expect File.exists?(target) == false || source_data != File.read(target)

  end

  it 'should be able to take a list of commands, and execute the next command in the list and undo the last command in the list, in any order' do
    path = '/tmp/test.txt'
    target = '/tmp/test2.txt'
    create_file = Patterns::CreateFile.new(path, 'Testing create file.')
    target = '/tmp/test2.txt'
    copy_file = Patterns::CopyFile.new(path, target)
    delete_file = Patterns::DeleteFile.new(path)

    command_list = Patterns::CommandList.new
    command_list.add_commands([create_file, copy_file, delete_file])

    puts command_list.next_status
    puts command_list.next_description

    command_list.execute_next

    puts command_list.last_status
    puts command_list.last_description
    puts command_list.next_status
    puts command_list.next_description

    expect File.exists?(path) == true
    command_list.undo_last

    puts command_list.last_status
    puts command_list.last_description
    puts command_list.next_status
    puts command_list.next_description

    expect File.exists?(path) == false
    command_list.execute_next

    puts command_list.last_status
    puts command_list.last_description
    puts command_list.next_status
    puts command_list.next_description
    expect File.exists?(path) == true
    command_list.execute_next

    puts command_list.last_status
    puts command_list.last_description
    puts command_list.next_status
    puts command_list.next_description
    command_list.execute_next

    puts command_list.last_status
    puts command_list.last_description
    puts command_list.next_status
    puts command_list.next_description
    expect File.exists?(path) == false

  end



  command_list_output = ''
  it 'should take a list of commands and execute all of them, report their description and status, then undo them' do

    path = '/tmp/test.txt'
    create_file = Patterns::CreateFile.new(path, 'Testing create file.')
    target = '/tmp/test2.txt'
    copy_file = Patterns::CopyFile.new(path, target)
    delete_file = Patterns::DeleteFile.new(path)

    command_list = Patterns::CommandList.new
    command_list.add_commands([create_file, copy_file, delete_file])

    command_list_output << command_list.description
    command_list.execute
    command_list_output << command_list.status
    command_list.undo
    command_list_output << command_list.status

  end

  it 'should print the descriptions and status of the command list test' do
    puts command_list_output
  end


end