module Patterns

  class CommandList < Patterns::Command
    def initialize
      @commands = []
    end

    def add_command(cmd)
      @commands << cmd
    end

    def add_commands(cmds)
      @commands = @commands + cmds
    end

    #not practical unless you want to run every command in the list; for demonstration only
    def execute
      @commands.each { |cmd| cmd.execute }
    end
    #also only practical if you want to reverse every command in the list
    def undo
      @commands.reverse.each { |cmd| cmd.undo }
    end

    def description
      description = ''
      @commands.each { |cmd| description += cmd.description + "\n" }
      description
    end

    def status
      status = ''
      @commands.each { |cmd| status += cmd.status + "\n"}
      status
    end
  end

end