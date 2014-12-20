require 'singleton'
module Patterns

  # The default log path to write data to
  DEFAULT_LOG_PATH = File.dirname(__FILE__) + '/log/game_log.log'

  # Logger -> Object
  #
  # The standard singleton pattern example - a logger to handle writing to a log file.
  class Logger

    # The output that will be written to a log file
    attr_reader :output

    # Includes Ruby's built in Singleton support for this example
    include Singleton

    # Initializes the Logger, the Singleton include will ensure it is only initialized once, and only when it needs to be called
    #
    # Examples
    #
    #   => logger = Logger.instance
    def initialize
      @output = ''
    end

    # Sets the format of our log message to error and writes data to the log file
    #
    # Examples
    #
    #   => logger.error 'File not found'
    def error(message)
      @output = format(message, 'ERROR')
      write
    end

    # Sets the format of our log message to info and writes data to the log file
    #
    # Examples
    #
    #   => logger.info 'This is some useful info'
    def info(message)
      @output = format(message, 'INFO')
      write
    end

    private

    # Performs the actual write operation
    def write
      File.open(DEFAULT_LOG_PATH, 'a') { |f| f << output }
    end

    # Sets the format style for the log message
    def format(message, message_type)
      "#{Time.now} | #{message_type}: #{message}\n"
    end

  end
end