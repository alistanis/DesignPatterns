module DesignPatterns

  class CommandList < Command
    def initialize
      @commands = []
    end

    def add_command(cmd)
      @commands << cmd
    end

    def add_commands(cmds)
      @commands = @commands + cmds
    end

    def execute
      @commands.each { |cmd| cmd.execute }
    end

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