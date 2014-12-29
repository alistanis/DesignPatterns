#!/usr/bin/env ruby
require 'Patterns/version'
require 'open3'
test_files = []
# Load test environment file
require File.expand_path('../../test', __FILE__) + '/test_env.rb'
# Load test files (they must contain the string 'spec')
Dir["#{File.expand_path('../../test', __FILE__)}/**/*.rb"].each { |f|
  if f.include?('spec')
    test_files << f
  end
}

include Patterns

# Extends the String class
class String
  # Wraps the ansi standard color code around a string
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end
  # Wraps the ansi standard color code 1 around a string
  def light_colorize(color_code)
    "\e[1;#{color_code}m#{self}\e[0m"
  end
  # Prints red text
  def red
    colorize(31)
  end
  # Prints green text
  def green
    colorize(32)
  end

end

# captures the output using script, so ansi colors are kept and will output correctly
test_files.each do |file|
  out_file = File.expand_path('../../test', __FILE__) + '/logs/' + File.basename(file, '.rb') + '.log'
  cmd = "script -q /dev/null rspec #{file} --format documentation --color"
  output_log = []

  Open3.popen3(cmd) { |stdin, stdout, stderr|
    begin
      ready = IO.select([stdout, stderr])
      readable = ready[0]

      readable.each do |io|
        until (str = io.gets).nil? do
          printf str
          output_log << str
        end
      end
    rescue Exception => e
      puts e.backtrace
    end
  }
  Logger.instance.info output_log.join('').gsub('[32m', '').gsub('[0m', ''), out_file
end