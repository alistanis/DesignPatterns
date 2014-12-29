module Patterns
  class ChainNode
    attr_accessor :next_node

    def initialize(next_node = nil)
      @next_node = next_node
    end

    def send_up_chain(patient)
      if @next_node != nil
      @next_node.see_patient(patient)
      else
        'We found patient zero! AHHHH ZOMBIES!!!'
      end
    end

  end
end