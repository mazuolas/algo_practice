# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.
require_relative 'bst_node'

class BinarySearchTree
  attr_accessor :root
  def initialize
    @root = nil
  end

  def insert(value)
    unless @root
      @root = BSTNode.new(value)
      return root
    end

    node = @root
    while node
      last_node = node
      node = check_children(value, node)
    end
    node = BSTNode.new(value)
    last_node.add_child(node)
  end

  def find(value, tree_node = @root)
    return nil unless tree_node
    return tree_node if value == tree_node.value
    if value < tree_node.value
      find(value, tree_node.left)
    else
      find(value, tree_node.right)
    end
  end

  def delete(value)
    node = @root
    while node && node.value != value
      last_node = node
      node = check_children(value, node)
    end
    if node.left && node.right
      max = maximum(node.left)
      delete(max.value)
      node.value = max.value
    else
      remove_node(last_node, node)
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    return nil unless tree_node
    unless tree_node.right
      tree_node
    else
      maximum(tree_node.right)
    end
  end

  def depth(tree_node = @root)
    return 0 unless tree_node && (tree_node.left || tree_node.right)
    left = 1 + depth(tree_node.left)
    right = 1 + depth(tree_node.right)
    left > right ? left : right
  end

  def is_balanced?(tree_node = @root)
    (depth(tree_node.left) - depth(tree_node.right)).abs < 1
  end

  def in_order_traversal(tree_node = @root, arr = [])
    return arr unless tree_node
    arr = in_order_traversal(tree_node.left, arr)
    arr << tree_node.value
    in_order_traversal(tree_node.right, arr)
  end


  private
  # optional helper methods go here:
  def check_children(value, node)
    if value < node.value
      node.left
    else
      node.right
    end
  end

  def remove_node(parent, child)
    if child == @root
      @root = nil
      return
    end
    if parent.value > child.value
      parent.left = child.left || child.right
    else
      parent.right = child.left || child.right
    end
  end
end
