module Patterns

  # DeleteFile -> Command
  #
  # Deletes a file, and provides the ability to undo that operation
  class DeleteFile < Patterns::Command

    # Initializes the DeleteFile Class
    #
    # * +path+ - The path of the file to delete
    #
    # Examples
    #
    #   => delete_file_cmd = DeleteFile.new(file_path)
    def initialize(path)
      super("Delete File: #{path}")
      @path = path
      @data = nil
    end

    # Deletes a file if it exists
    #
    # Examples
    #
    #   => delete_file_cmd.execute
    def execute
      function = Proc.new do
        if File.exist?(@path)
          @data = File.read(@path)
        end
        File.delete(@path)
      end
      super(function)
    end

    # Replaces a file that was deleted
    #
    # Examples
    #
    #   => delete_file_cmd.undo
    def undo
      function = Proc.new do
        if @data != nil
          f = File.open(@path, 'w')
          f.write @data
          f.close
        end
      end
      super(function)
    end

  end

end