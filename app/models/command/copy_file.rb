module Patterns

  class CopyFile < Patterns::Command

    def initialize(source, target)
      super("Copy File: #{source} to file: #{target}")
      @source = source
      @target = target
    end

    def execute
      function = Proc.new do
        if File.exists?(@target)
          @data = File.read(@target)
        end
        FileUtils.copy(@source, @target)
      end
      execute_command(function)
    end

    def undo
      function = Proc.new do
        if @data
          f = File.open(@target,'w')
          f.write(@data)
          f.close
        else
          File.delete(@data)
        end
      end
      undo_command(function)
    end

  end

end