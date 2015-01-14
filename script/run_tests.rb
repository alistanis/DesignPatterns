#!/usr/bin/env ruby
require 'Patterns/version'
require 'open3'

start_time = Time.now

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
include Patterns::Illness

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

example_lines = []
map = {'[32m' => '', '[0m' => '', '[31m' => '', '[36m#' => '', "\e" => ''}
re = Regexp.union(map.keys)

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
          if str.include?('examples')
            example_lines << str
          end
          output_log << str
        end
      end
    rescue Exception => e
      puts e.backtrace
    end
  }
  # the next few lines remove ansi colors from text so the log doesn't look weird

  output = output_log.join('').gsub(re, map)
  Logger.instance.info output, out_file
  total_run_time = Time.now - start_time
  puts "\nTotal test run time: #{total_run_time} seconds"
end

total_examples = 0
total_failures = 0

example_lines.map!{|line| line.gsub!(re, map)}

example_lines.each do |line|
  split_lines = line.split(', ')
  split_lines.each do |split_line|
    if split_line.include?('examples')
      total_examples += split_line.split(' ')[0].to_i
    elsif split_line.include?('failures')
      total_failures += split_line.split(' ')[0].to_i
    end
  end
end

out_file = File.expand_path('../../test', __FILE__) + '/logs/aggregate.log'
if total_failures == 0
  output = "#{total_examples} examples run, with 0 failures!"
  puts output.green
  Logger.instance.info output, out_file
else
  output = "#{total_examples} examples run, with #{total_failures} failures."
  puts output.red
  Logger.instance.info output, out_file
end


