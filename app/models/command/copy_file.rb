module Patterns

  # CopyFile -> Command
  #
  # Class that implements a command to Copy a file from one location to another, and to undo that copy
  class CopyFile < Patterns::Command

    # Initializes the CopyFile Class
    #
    # * +source+ - The source path for the file to be copied
    # * +target+ - The target destination for the copied file
    #
    # Examples
    #
    #   => copy_file_cmd = CopyFile.new(file_to_copy, destination)
    def initialize(source, target)
      super("Copy File: #{source} to file: #{target}")
      @source = source
      @target = target
    end

    # Copies a file from a source location to a target destination
    #
    # Examples
    #
    #   => copy_file_cmd.execute
    def execute
      function = Proc.new do
        if File.exists?(@target)
          @data = File.read(@target)
        end
        FileUtils.copy(@source, @target)
      end
      super(function)
    end

    # Undoes a copy operation
    #
    # Examples
    #
    #   => copy_file_cmd.undo
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