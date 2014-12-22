#!/usr/bin/env ruby

test_files = []
require File.expand_path('../../test', __FILE__) + '/test_env.rb'
Dir["#{File.expand_path('../../test', __FILE__)}/**/*.rb"].each { |f| test_files << f }

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
failures = ''
test_files.each do |file|
  output = `rspec #{file} --format documentation --color`

  color = 'green'
  output.lines.each do |line|
    #rspec adds an additional output formatter
    line = line.gsub("\n", '')
    if line.include?('Failures:')
      color = 'red'
    end
    if line.include?('Finished')
      color = 'green'
    end
    if color == 'green'
      puts line.green
    else
      failures << line
      puts line.red
    end
  end
end

if failures != ''
  puts failures.red
end
