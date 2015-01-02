require 'rspec'
require 'Patterns/version'
require File.expand_path('../../test', __FILE__) + '/test_env.rb'
include Patterns
require 'CIO'
include CIO

describe 'CIO C Extension Tests' do

  # The path of a test file that can be reused throughout these tests
  READ_FILE_PATH = File.expand_path('../../static', __FILE__) + '/cio_test_readfile.txt'
  # The data contained within the test file
  TEST_DATA = 'TESTING!!'

  context 'ReadFile Testing' do
    it 'Can read a file calling the C API and return that file to ruby' do

      file_data = CIO.read_file(READ_FILE_PATH)
      expect(file_data).to eql(TEST_DATA)
    end

    it 'Can read a file with a read_size parameter' do
      file_data = CIO.read_file(READ_FILE_PATH, 1)
      expect(file_data).to eql(TEST_DATA)
    end
  end

  context 'WriteFile Testing' do
    it 'Can write data to a new file' do

    end
  end
end