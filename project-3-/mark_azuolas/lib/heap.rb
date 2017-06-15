class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc = prc || Proc.new { |x, y| x <=> y }
  end

  def count
    @store.length
  end

  def extract
    val = @store[0]
    @store[0] = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, count-1, &@prc)
    val
  end

  def peek
    @store[0]
  end

  def push(val)
    @store << val
    BinaryMinHeap.heapify_up(@store, count-1, @count, &@prc)
  end

  public
  def self.child_indices(len, parent_index)
    if len > parent_index * 2 + 2
      [2*parent_index+1, 2*parent_index + 2 ]
    elsif len > parent_index * 2 + 1
      [2*parent_index+1]
    else
      nil
    end
  end

  def self.parent_index(child_index)
    raise 'root has no parent' if child_index == 0
    (child_index-1)/2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    children = child_indices(len, parent_idx)
    if children && children.length == 2
      if prc.call(array[children[0]], array[children[1]]) <= 0
        min_idx =  children[0]
      else
        min_idx = children[1]
      end
      if prc.call(array[min_idx], array[parent_idx]) < 0
        array[min_idx], array[parent_idx] = array[parent_idx], array[min_idx]
        BinaryMinHeap.heapify_down(array, min_idx, len, &prc)
      else
        array
      end
    elsif children && children.length == 1
      if prc.call(array[children[0]], array[parent_idx]) < 0
        array[children[0]], array[parent_idx] = array[parent_idx], array[children[0]]
        BinaryMinHeap.heapify_down(array, children[0], len, &prc)
      else
        array
      end
    else
      array
    end
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    if child_idx == 0
      array
    else
      parent_idx = BinaryMinHeap.parent_index(child_idx)
      if prc.call(array[child_idx], array[parent_idx]) < 0
        array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
        BinaryMinHeap.heapify_up(array, parent_idx, len, &prc)
      else
        array
      end
    end
  end
end
