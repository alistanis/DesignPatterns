require 'Patterns/version'

module Patterns

  # Command -> Object
  #
  # Base Class that acts as a receiver and allows execution for a command while also storing status and description
  # All of this class' subclasses may optionally implement undo, which is an example of the Memento Pattern.
  # Memento will be covered more fully in the Abstract State Machine/Finite State Machine pattern.
  #
  # From Design Patterns (Gang of Four)
  #   - • Command – declares an interface for executing an operation.
  class Command

    # * - +@description+ - stores the description that is passed to the initializer upon object instantiation \n * - +@status+ - the most recent status of the command
    attr_accessor :description, :status

    # Initializes the Command Class
    # Designed to be called by a child class in its initialize method
    #
    # * +description+ - The description of the sub class
    #
    # Examples
    #   => #inside child class
    #   => def initialize
    #   =>  desc = 'A new child class of Command'
    #   =>  super(desc) # (calls the super class' initialize function defined below)
    #   => end
    def initialize(description)
      @description = description
      @status = 'initialized'
    end

    # Called by the child class' execute function
    #
    # * +function+ - The actual command that will be executed, passed in from the sub class
    #
    # Examples
    #
    #   => #inside child class, look at create_file.rb, copy_file.rb, or delete_file.rb for a complete example
    #   => def execute
    #   =>  function = Proc.new do # or Proc.new {}
    #   =>    #code to be executed
    #   =>  end
    #   =>  super(function) # (calls the super class' execute function defined below)
    #   => end
    def execute(function)
      @status = "Command began: #{@description}"
      function.call
      @status = "Execution completed: #{@description}"
    end

    # Called by the child class' undo function.
    #
    # * +function+ - The command that will perform the undo operation
    #
    # Examples
    #
    #   => #inside child class
    #   => def undo
    #   =>  function = Proc.new do
    #   =>    #code to undo execute function
    #   =>  end
    #   => super(function) # (calls the super class' undo function defined below)
    #   => end
    def undo(function)
      @status = "Undo began: #{@description}"
      function.call
      @status = "Undo completed: #{@description}"
    end

  end
end
