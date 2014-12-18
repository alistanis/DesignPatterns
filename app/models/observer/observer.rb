module Patterns

  # Observer -> Object
  #
  # An Observer class that receives notifications about events from subjects it is observing
  # Ruby has an Observer module built in to the language, but we will build one to demonstrate how it works and to give it flexibility that we want for this application
  # This implementation can be inherited or used by itself. For example, it could be an Admin class watching a User class, or it could just be a class called UserObserver
  # We would simply add this class to whatever subject list we want to observe
  class Observer
    attr_reader :last_notification, :last_event, :custom_function

    # Initializes the observer class
    #
    # Examples
    #
    # => observer = Observer.new
    def initialize
      @last_notification = 'No notifications received'
      @last_event = 'No events received'
      @custom_function = nil
    end

    # Is called when this function is invoked by a subject
    #
    # Note: in a real implementation, the event would likely be a complete object or hash, and would contain much more useful information
    #
    # Examples
    #
    # => def notify(notification, event)
    # =>   @observers.each do |observer|
    # =>     observer.on_notify(notification, event)
    # =>   end
    # => end
    #
    def on_notify(notification, event)
      @last_notification = notification
      @last_event = event
      puts "Notification: #{notification}, Event: #{event}"
    end


  end

end