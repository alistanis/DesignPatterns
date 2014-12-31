module Patterns

  # Module that defines behavior for raising an exception if a class is expected to implement a function and does not.
  # Gives detailed information about the method that must be implemented
  module AbstractInterface
    # InterfaceNotImplemented error class
    class InterfaceNotImplemented < StandardError
    end

    # Tells the class to include and extend AbstractInterface::Methods
    def self.included(klass)
      klass.send(:include, AbstractInterface::Methods)
      klass.send(:extend, AbstractInterface::Methods)
    end

    # Specifies the api_not_implemented method
    module Methods
      # Raises an InterfaceNotImplemented exception if the class does not implement the function it is calling
      def api_not_implemented(klass)
        caller.first.match(/in `(.+)'/)
        method_name = $1
        raise InterfaceNotImplemented, ("#{klass.class.name} needs to implement '#{method_name}' for interface #{self.name}!")
      end

    end
  end

end