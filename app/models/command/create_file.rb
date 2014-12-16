require 'Patterns/version'
module Patterns
  class CreateFile < Patterns::Command

    def initialize(path, data)
      super("Create File: #{path}")
      @path = path
      @data = data
    end

    def execute
      function = Proc.new do
        f = File.open(@path, 'w')
        f.write @data
        f.close
      end
      super(function)
    end

    def undo
      function = Proc.new do
        File.delete(@path)
      end
      super(function)
    end

  end
end
