class BSTNode
  def initialize(value)
    @left, @right, @value = nil, nil, value
  end
  attr_accessor :value, :left, :right

  def add_child(node)
    if node.value < value
      @left = node
    else
      @right = node
    end
  end
end
