module Patterns

  # Module that defines behavior for raising an exception if a class is expected to implement a function and does not.
  # Gives detailed information about the method that must be implemented
  module AbstractInterface
    # InterfaceNotImplemented error class
    class InterfaceNotImplemented < StandardError
    end

    #
    def self.included(klass)
      klass.send(:include, AbstractInterface::Methods)
      klass.send(:extend, AbstractInterface::Methods)
    end

    module Methods

      def api_not_implemented(klass)
        caller.first.match(/in `(.+)'/)
        method_name = $1
        raise InterfaceNotImplemented, ("#{klass.class.name} needs to implement '#{method_name}' for interface #{self.name}!")
      end

    end

  end
end
