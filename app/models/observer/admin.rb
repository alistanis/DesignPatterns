require "#{File.dirname(__FILE__)}/observer.rb"

module Patterns

  # Admin -> Observer
  #
  # An example class to show how the observer pattern can be practically applied
  # This example uses Inheritance but could also use Object Composition.
  class Admin < Patterns::Observer

    # Initializes the Admin class and the Observer superclass
    #
    # Examples
    #
    #   => admin = Admin.new('Chris', 'ccooper@sessionm.com')
    def initialize(name, email)
      super()
      @name = name
      @email = email
    end

  end
end