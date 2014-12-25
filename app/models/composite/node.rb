module Patterns

  # Admittedly, this was taken from Nick Slocum's very Ruby and very brilliant solution to the composite problem
  # https://github.com/nslocum/design-patterns-in-ruby/tree/master/composite/tree
  # Node -> Object
  #
  # Represents a node that may contain any number of nodes, and any number of child nodes, forming a Tree-Like structure
  class Node
    # The name of this node
    attr_accessor :name
    # The name of this node's parent
    attr_accessor :parent
    # The array of child nodes this node possesses
    attr_reader :children

    # Initializes the Node class
    def initialize(name)
      @name = name
      @children = []
    end

    # Adds a child node to this node's list of children
    def add(node)
      @children << node
      node.parent = self
    end

    # Aliases the add method to '<<' allowing << to also set the child node's parent to itself
    alias :<< :add

    # Removes the child node from this node's children
    def remove(node)
      @children.delete node
    end

    # Crazy ruby assignment trick that returns the child at the index it is assigned
    def [](index)
      @children[index]
    end

    # Another crazy ruby assignment trick which allows a node to be replaced upon assignment while also marking the child node's parent as this node
    def []=(index, node)
      replaced_child = @children[index]
      @children[index] = node
      replaced_child.parent = nil
      node.parent = self
    end

    # Indicates whether or not this node has any other child nodes
    # -- will likely rename this and implement two methods, one that returns Composite nodes and one that returns Leaf nodes
    def leaf?
      children.empty?
    end
  end
end