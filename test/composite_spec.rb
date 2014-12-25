require 'rspec'
require 'Patterns/version'
include Patterns
require File.expand_path('../../test', __FILE__) +'/test_env.rb'

describe 'CompositeTests' do

  it 'Can instantiate a root composite, leaf nodes for the root, branch composites, and leaf nodes for those branches' do
    root = Composite.new('root')

    root.add(Leaf.new('Leaf A'))

    root.add(Leaf.new('Leaf B'))

    branch1 = Composite.new('Branch 1')
    root.add(branch1)
    branch1.add(Leaf.new('Leaf Y'))
    branch1.add(Leaf.new('Leaf Z'))
    branch2 = Composite.new('Branch 2')
    branch1.add(branch2)
    branch2.add(Leaf.new('Leaf 1'))

    branch3 = Composite.new('Branch 3')
    root.add(branch3)
    branch3.add(Leaf.new('Leaf 1A'))

    expect{(root.display(1))}.to output.to_stdout
  end

end