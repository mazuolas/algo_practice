require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    node = @map[key]
    if node
      update_node!(node)
      node.val
    else
      val = @prc.call(key)
      @map[key] = @store.append(key, val)
      eject! if count > @max
      val
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    node.remove
    @map[node.key] = @store.append(node.key, node.val)
  end

  def eject!
    node = @store.first
    node.remove
    @map.delete(node.key)
  end
end
