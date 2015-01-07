require 'rspec'
require 'Patterns/version'
require File.expand_path('../../test', __FILE__) + '/test_env.rb'
include Patterns
require 'CIO'
include CIO

describe 'CIO C Extension Tests' do

  # The path of a test file that can be reused throughout these tests
  READ_FILE_PATH = File.expand_path('../../static', __FILE__) + '/cio_test_readfile.txt'
  # The path of a test file we can write to/delete throughout these tests
  WRITE_FILE_PATH = File.expand_path('../../static', __FILE__) + '/cio_test_writefile.txt'
  # The data contained within the test file
  TEST_DATA = 'TESTING!!'
  # The entire first sherlock holmes novel
  SHERLOCK_HOLMES_NOVEL = File.expand_path('../../static', __FILE__) + '/sherlock.txt'

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
    it 'Can write data to a new file and verify that data is correct' do
      if File.exists?(WRITE_FILE_PATH)
        File.delete(WRITE_FILE_PATH)
      end
      CIO.write_new_file(WRITE_FILE_PATH, TEST_DATA)
      file_data = CIO.read_file(WRITE_FILE_PATH)
      expect(File.exists?(WRITE_FILE_PATH)).to eql(true)
      expect(file_data).to eql(TEST_DATA)
      File.delete(WRITE_FILE_PATH)
      expect(File.exists?(WRITE_FILE_PATH)).to eql(false)
    end
  end

end