module Patterns

  # User -> Subject
  #
  # * +@user_name+ - The user's user name
  # * +@email+ - The user's email
  # * +password+ - The user's password
  #
  # An example class to show how the Subject functions in the Observer pattern
  class User < Patterns::Subject
    # stores information about the User class
    attr_accessor :user_name, :email, :password

    # Initializes the User class and the Subject superclass
    #
    # * +user_name+ - The user's username
    # * +email+ - The user's email
    # * +password+ - The user's password
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
    # * +new_password+ - The new password to change the user's password to
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
    # * +notification+ - The notification to send to the superclass
    # * +event+ - The event to send to the superclass
    #
    # Examples
    #
    # => notify('User password changed', 'PasswordChange')
    def notify(notification, event)
      super(notification, event)
    end

  end
end