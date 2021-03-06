module Patterns
  # ChainNode -> Object
  #
  # Will likely be refactored to be more abstract, currently this class has a reliance on the "see_patient" method existing in our node, which isn't a great thing
  class ChainNode
    # The next node in the list, or nil if it does not exist
    attr_accessor :next_node

    # Initializes the ChainNode and sets the next node to another chain object or nil
    def initialize(next_node = nil)
      @next_node = next_node
    end

    # Delegates the responsibility to the next node in the chain
    def send_up_chain(argument)
      if @next_node != nil
      @next_node.process(argument)
      else
        'We found patient zero! AHHHH ZOMBIES!!!'
      end
    end

    def process(argument)
      puts "#{self} received argument: #{argument}, this should be overloaded in a subclass."
    end

  end
end