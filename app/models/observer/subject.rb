module Patterns

  # Subject -> Object
  #
  # * +@observers+ - The list of observers this subject stores
  #
  # Contains a list of observers that are watching this subject
  class Subject
    #list of observers to notify about changes to this subject
    attr_reader :observers

    # Initializes the subject class
    #
    # Examples
    #
    # => subject = Subject.new
    def initialize
      @observers = Array.new
    end

    # Adds an observer to the list of observers
    #
    # * +observer+ - The observer to add to the list
    #
    # Examples
    #
    # => subject_observer = Observer.new
    # => subject.add_observer(subject_observer)
    def add_observer(observer)
      @observers << observer
    end

    # Removes an observer from the list of observers
    #
    # * +observer+ - The observer to remove from the list
    #
    # Examples
    #
    # => subject.remove_observer(subject_observer)
    def remove_observer(observer)
      @observers.delete(observer)
    end

    # Notifies the observer of some change
    #
    # * +notification+ - The notification to send to the observers
    # * +event+ - The event to send to the observers
    #
    # Examples
    #
    # => subject.notify('An event just happened!', the_event)
    def notify(notification, event)
      @observers.each do |observer|
        observer.on_notify(notification, event)
      end
    end

  end
end