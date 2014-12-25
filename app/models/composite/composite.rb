require File.dirname(__FILE__) + '/node.rb'

module Patterns
  # Composite -> Node
  #
  # Acts as a root or branch for a composite structure
  class Composite < Node

    # Initializes the Composite class
    def initialize(name)
      super(name)
    end

    # Displays this composite and each of its children up to their proper depth
    def display(depth)
      str = ''
      depth.times do
        str << '-'
      end
      puts str + @name
      @children.each do |child|
          child.display(depth + 2)
        end
    end

  end
end