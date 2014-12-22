# Loads all of the required files for the rspec tests
Dir["#{File.expand_path('../../app/models/', __FILE__)}/**/*.rb"].each { |f| load(f) }
