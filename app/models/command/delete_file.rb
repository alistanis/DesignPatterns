module DesignPatterns

  class DeleteFile < DesignPatterns::Command

    def initialize(path)
      super("Delete File: #{path}")
      @path = path
    end

    def execute
      function = Proc.new do
        if File.exist?(@path)
          @data = File.read(@path)
        end
        File.delete(@path)
      end
      execute_command(function)
    end

    def undo
      function = Proc.new do
        f = File.open(@path, 'w')
        f.write @data
        f.close
      end
      undo_command(function)
    end

  end

end