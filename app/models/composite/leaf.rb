require File.dirname(__FILE__) + '/node.rb'

module Patterns
  # Leaf -> Node
  #
  # Acts as a leaf branch to a Composite structure; as a leaf, it may not have children
  class Leaf < Node

    # Initializes the Leaf class
    def initialize(name)
      super(name)
    end

    # Raises an error, since a leaf may not have a child node
    def add(component)
      raise AddChildToLeafError, 'Cannot add children to a leaf'
    end

    # Raises an error, since a leaf can not remove what it doesn't have
    def remove(component)
      raise RemoveChildFromLeafError, 'Cannot remove children from a leaf.'
    end

    # Displays this leaf node with dashes indicating its current depth
    def display(depth)
      str = ''
      depth.times do
        str << '-'
      end
      puts str + @name
    end

  end

  # Represents an AddChildToLeafError so that specific error can be raised
  class AddChildToLeafError < StandardError
  end

  # Represents a RemoveChildFromLeafError so that specific error can be raised
  class RemoveChildFromLeafError < StandardError
  end
end