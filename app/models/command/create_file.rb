module Patterns

  # CreateFile -> Command
  #
  # Creates a file and writes data to it, and provides a command for undoing that operation
  class CreateFile < Patterns::Command

    # Initializes the CreateFile Class
    #
    # * +path+ - The file path to write the file
    # * +data+ - The data to write to the file
    #
    # Examples
    #
    #   => create_file_cmd = CreateFile.new(file_path, data_to_write)
    def initialize(path, data)
      super("Create File: #{path}")
      @path = path
      @data = data
    end

    # Creates a file and writes data to it; will overwrite data if the file already exists.
    # This function should probably be called write to file, with optional append instead of overwrite.
    #
    # Examples
    #
    #   => create_file_cmd.execute
    def execute
      function = Proc.new do
        f = File.open(@path, 'w')
        f.write @data
        f.close
      end
      super(function)
    end

    # Undoes file creation; to be more useful, this should probably only remove data if it was appended, and only remove the file if it was created.
    #
    # Examples
    #
    #   => create_file_cmd.undo
    def undo
      function = Proc.new do
        File.delete(@path)
      end
      super(function)
    end

  end
end
