require "#{File.dirname(__FILE__)}/observer.rb"

module Patterns

  # Admin -> Observer
  #
  # * +@name+ - The administrator's name
  # * +@email+ - The administrator's email
  #
  # An example class to show how the observer pattern can be practically applied
  class Admin < Patterns::Observer

    attr_accessor :name, :email

    # Initializes the Admin class and the Observer superclass
    #
    # Examples
    #
    # => admin = Admin.new('Chris', 'ccooper@sessionm.com')
    def initialize(name, email)
      super()
      @name = name
      @email = email
    end

  end
end