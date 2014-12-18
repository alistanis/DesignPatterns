module Patterns

  # User -> Subject
  #
  # An example class to show how the Subject functions in the Observer pattern
  class User < Patterns::Subject

    attr_accessor :user_name, :email, :password

    # Initializes the User class and the Subject superclass
    #
    # Examples
    #
    # => user = User.new('test_user', 'test@sessionm.com', 'test_password')
    def initialize(user_name, email, password)
      super()
      @user_name = user_name
      @email = email
      @password = password
    end

    # Changes a user password and notifies all of its observers
    #
    # Examples
    #
    # => user.change_password('new_password')
    def change_password(new_password)
      @password = new_password
      notify("Password changed for user: #{user_name}.", 'PasswordChange')
    end

    # Notifies the superclass of an event, which in turn notifies all of its observers
    #
    # Examples
    #
    # => notify('User password changed', 'PasswordChange')
    def notify(notification, event)
      super(notification, event)
    end

  end
end