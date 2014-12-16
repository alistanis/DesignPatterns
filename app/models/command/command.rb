require 'Patterns/version'

module Patterns

  class Command
    attr_accessor :description, :status

    def initialize(description)
      @description = description
      @status = 'initialized'
    end

    def execute(function)
      @status = "Command began: #{@description}"
      function.call
      @status = "Execution completed: #{@description}"
    end

    def undo(function)
      @status = "Undo began: #{@description}"
      function.call
      @status = "Undo completed: #{@description}"
    end

  end
end
