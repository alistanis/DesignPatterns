#!/usr/bin/env ruby

test_files = []

Dir["#{File.expand_path('../../test', __FILE__)}/**/*.rb"].each { |f| test_files << f }

class String
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def light_colorize(color_code)
    "\e[1;#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end
end

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
      puts line.red
    end
  end
end

