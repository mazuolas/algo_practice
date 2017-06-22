def method_name
  stack = []
  node = @root
  stack = left_things(node, stack)
  until stack.empty?
    node = stack.pop
    p node.value
    if node.right
      stack << node.right
      stack = left_things(node.right, stack)
    end
  end
end

def left_things(node, stack)
  while node.left
    stack << node
    node = node.left
  end
  stack
end
