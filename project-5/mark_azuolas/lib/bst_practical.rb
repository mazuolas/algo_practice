require 'byebug'
def kth_largest(tree_node, k)
  # nodes = in_order_traversal(tree_node)
  # find(nodes[nodes.length-k], tree_node)
  kth_biggest(tree_node, k).pop
end
#
# def in_order_traversal(tree_node = @root, arr = [])
#   return arr unless tree_node
#   arr = in_order_traversal(tree_node.left, arr)
#   arr += [tree_node.value]
#   in_order_traversal(tree_node.right, arr)
# end
#
# def find(value, tree_node = @root)
#   return nil unless tree_node
#   return tree_node if value == tree_node.value
#   if value < tree_node.value
#     find(value, tree_node.left)
#   else
#     find(value, tree_node.right)
#   end
# end

def kth_biggest(tree_node, k, arr = [])
  return arr if k == arr.length
  return arr unless tree_node
  arr = kth_biggest(tree_node.right, k, arr)
  return arr if k == arr.length
  arr += [tree_node]
  return arr if k == arr.length
  kth_biggest(tree_node.left, k, arr)
end
