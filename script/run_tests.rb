#!/usr/bin/env ruby

require 'rspec'
require 'rspec/core/formatters/json_formatter'
require 'Patterns/version'

test_files = []

Dir["#{File.expand_path('../../test', __FILE__)}/**/*.rb"].each { |f| test_files << f }

config = RSpec.configuration

#formatter = RSpec::Core::Formatters::JsonFormatter.new(config.output_stream)


formatter = RSpec::Core::Formatters::DocumentationFormatter.new(config.output_stream)

reporter =  RSpec::Core::Reporter.new(config)
config.instance_variable_set(:@reporter, reporter)

# internal hack
# api may not be stable, make sure lock down Rspec version
loader = config.send(:formatter_loader)
notifications = loader.send(:notifications_for, RSpec::Core::Formatters::DocumentationFormatter)

reporter.register_listener(formatter, *notifications)

RSpec::Core::Runner.run(test_files)

# here's your json hash
p formatter.output