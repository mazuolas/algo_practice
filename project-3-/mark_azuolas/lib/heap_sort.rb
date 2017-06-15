require_relative "heap"

class Array
  def heap_sort!
    prc = Proc.new { |x, y| y - x }
    return self if length < 2
    pointer = 1
    while pointer < length
      BinaryMinHeap.heapify_up(self, pointer, pointer+1, &prc)
      pointer += 1
    end
    pointer
    while pointer > 0
      self[0], self[pointer-1] = self[pointer-1], self[0]
      BinaryMinHeap.heapify_down(self, 0, pointer-1, &prc )
      pointer -= 1
    end
    self
  end
end
