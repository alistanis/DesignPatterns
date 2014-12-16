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
      super(function)
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
      super(function)
    end

  end

end