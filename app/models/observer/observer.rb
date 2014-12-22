module Patterns

  # Observer -> Object
  #
  #
  # An Observer class that receives notifications about events from subjects it is observing.
  # Ruby has an Observer module built in to the language, but we will build one to demonstrate how it works and to give it flexibility that we want for this application.
  # This implementation can be inherited or used by itself. For example, it could be an Admin class watching a User class, or it could just be a class called UserObserver.
  # We would simply add this class to whatever subject list we want to observe.
  class Observer
    # * +@last_notification+ - The last notification this observer received
    # * +@last_event+ - The last event this observer received
    attr_reader :last_notification, :last_event

    # Initializes the observer class
    #
    # Examples
    #
    #   => observer = Observer.new
    def initialize
      @last_notification = 'No notifications received'
      @last_event = 'No events received'
    end

    # Is called when this function is invoked by a subject
    #
    # Note: in a real implementation, the event would likely be a complete object or hash, and would contain much more useful information.
    # It would also likely contain a call to a function to do something, like log the event, or execute an event callback.
    # If it does execute an event callback and the callback could possibly block while your main application waits for it to return,
    # it would be a reasonable choice to use asynchronous scheduling, threads, fork a child process,
    # or some other means of asynchronous processing to complete the callback.
    #
    # * +notification+ - The notification received from the subclass
    # * +event+ - The event received from the subclass
    #
    # Examples
    #
    #   => def notify(notification, event)
    #   =>   @observers.each do |observer|
    #   =>     observer.on_notify(notification, event)
    #   =>   end
    #   => end
    def on_notify(notification, event)
      @last_notification = notification
      @last_event = event
      puts "Notification: #{notification}, Event: #{event}"
    end


  end

end