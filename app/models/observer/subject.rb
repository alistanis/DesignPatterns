module Patterns

  # Subject -> Object
  #
  # Contains a list of observers that are watching this subject
  class Subject
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
    # Examples
    #
    # => subject_observer = Observer.new
    # => subject.add_observer(subject_observer)
    def add_observer(observer)
      @observers << observer
    end

    # Removes an observer from the list of observers
    #
    # Examples
    #
    # => subject.remove_observer(subject_observer)
    def remove_observer(observer)
      @observers.delete(observer)
    end

    # Notifies the observer of some change
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