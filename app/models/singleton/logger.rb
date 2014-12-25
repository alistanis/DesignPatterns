require 'singleton'
module Patterns

  # The default log path to write data to
  DEFAULT_LOG_PATH = File.dirname(__FILE__) + '/log/game_log.log'

  # Logger -> Object
  #
  # The standard singleton pattern example - a logger to handle writing to a log file.
  class Logger
    # Includes Ruby's built in Singleton support for this example
    include Singleton
    # The output that will be written to a log file
    attr_reader :output

    # Initializes the Logger, the Singleton include will ensure it is only initialized once, and only when it needs to be called
    #
    # * +log_file+ - The path of the log file
    #
    # Examples
    #
    #   => logger = Logger.instance
    def initialize
      @output = ''
    end

    # Sets the format of our log message to error and writes data to the log file
    #
    # * +message+ - The message to log
    #
    # Examples
    #
    #   => logger.error 'File not found'
    def error(message, log_file = DEFAULT_LOG_PATH)
      @output = format(message, 'ERROR')
      write(log_file)
    end

    # Sets the format of our log message to info and writes data to the log file
    #
    # * +message+ - The message to log
    #
    # Examples
    #
    #   => logger.info 'This is some useful info'
    def info(message, log_file = DEFAULT_LOG_PATH)
      @output = format(message, 'INFO')
      write(log_file)
    end

    private

    # Performs the actual write operation
    def write(log_file)
      File.open(log_file, 'a') { |f| f << output }
    end

    # Sets the format style for the log message
    #
    # * +message+ - The message to log
    # * +message_type+ - The type of message being passed; error, info, warning
    def format(message, message_type)
      "#{Time.now} | #{message_type}: #{message}\n"
    end

  end
end