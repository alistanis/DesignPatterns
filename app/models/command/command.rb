require 'Patterns/version'

module Patterns

  # Command -> Object
  #
  # Base Class that acts as a receiver and allows execution for a command, and stores status and description
  #
  # Public
  #
  # - @description - stores the description that is passed to the initializer upon object instantiation
  # - @status - the most recent status of the command
  class Command
    attr_accessor :description, :status

    #Initializes the Command Class
    def initialize(description)
      @description = description
      @status = 'initialized'
    end

    #Executes the child class' execute function.
    def execute(function)
      @status = "Command began: #{@description}"
      function.call
      @status = "Execution completed: #{@description}"
    end

    #Undoes the child class' execute function.
    def undo(function)
      @status = "Undo began: #{@description}"
      function.call
      @status = "Undo completed: #{@description}"
    end

  end
end
