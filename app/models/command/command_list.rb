module Patterns

  # CommandList -> Patterns::Command
  #
  # Class that stores a list of commands and provides a way to add and remove them, get status and description, and execute and undo them.
  #
  # Private
  #
  # - +@next+ - stores the next node in the list. The only necessary
  # - +@commands+ - the list of commands
  class CommandList < Patterns::Command

    # public: Initializes the command list
    #
    # Examples
    #
    # => command_list = CommandList.new
    def initialize
      @commands = []
      @next = 0
    end

    # public: Adds a command to the list
    #
    # * +cmd+ - The command to be added to the list
    #
    # Examples
    #   => command = Command.new('A new base command')
    #   => command_list.add_command(command)
    def add_command(cmd)
      @commands << cmd
      if @current == nil
        @current = cmd
      end
    end

    # public: Adds a list of commands to the list
    #
    # * +cmds+ - The list of commands to add to the command list
    #
    # Examples
    #   => list_of_commands = [Command.new('A new base command'), Command.new('Another new base command')]
    #   => command_list.add_command(list_of_commands)
    def add_commands(cmds)
      @commands = @commands + cmds
    end

    # public: Executes the next command in the list
    #
    # Examples
    #   => command = Command.new('A new base command')
    #   => command_list.add_command(command)
    #   => command_list.execute_next
    def execute_next
      if @next == 0
        @commands[@next].execute
        @next = @next + 1
      else
        if @commands[@next] != nil
          @commands[@next].execute
          @next = @next + 1
        else
          raise CommandList, 'No next command in list; index out of bounds'
        end
      end
    end

    # public: Undoes the last command executed
    #
    # Examples
    #   => command = Command.new('A new base command')
    #   => command_list.add_command(command)
    #   => command_list.execute_next
    #   => command_list.undo_last
    def undo_last
      if @next > 0
        @commands[@next - 1].undo
        @next = @next - 1
      end
    end

    # public: Returns the description of the next command in the list
    #
    # Examples
    #   => command = Command.new('A new base command')
    #   => command_list.add_command(command)
    #   => puts command_list.next_description
    def next_description
      if @commands[@next] != nil
        @commands[@next].description
      else
        'No more commands in list'
      end
    end

    # public: Returns the description of the last command executed
    #
    # Examples
    #   => command = Command.new('A new base command')
    #   => command_list.add_command(command)
    #   => puts command_list.last_description
    def last_description
      if @next != 0
        @commands[@next - 1].description
      else
        'No commands have been executed yet'
      end
    end

    # public: Returns the status of the next command in the list
    #
    # Examples
    #   => command = Command.new('A new base command')
    #   => command_list.add_command(command)
    #   => puts command_list.next_status
    def next_status
      if @commands[@next] != nil
        @commands[@next].status
      else
        'No more commands in list'
      end
    end

    # public: Returns the status of the last command executed
    #
    # Examples
    #   => command = Command.new('A new base command')
    #   => command_list.add_command(command)
    #   => puts command_list.last_status
    def last_status
      if @next != 0
        @commands[@next - 1].status
      else
        'No commands have been executed yet'
      end
    end

    #not practical unless you want to run every command in the list; for demonstration only
    def execute
      @commands.each { |cmd| cmd.execute }
    end
    #also only practical if you want to reverse every command in the list
    def undo
      @commands.reverse.each { |cmd| cmd.undo }
    end

    # public: Returns the string of the descriptions of all commands in the list
    #
    # Examples
    #   => command_list.description
    def description
      description = ''
      @commands.each { |cmd| description += cmd.description + "\n" }
      description
    end

    # public: Returns the string of the status of all commands in the list
    #
    # Examples
    #   => command_list.status
    def status
      status = ''
      @commands.each { |cmd| status += cmd.status + "\n"}
      status
    end
  end

end