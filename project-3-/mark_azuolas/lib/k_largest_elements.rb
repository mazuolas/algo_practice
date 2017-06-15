require_relative 'heap'

def k_largest_elements(array, k)
  heap = BinaryMinHeap.new { |x,y| y <=> x }
  array.each do |el|
    heap.push(el)
  end
  biggest = []
  k.times do
    biggest << heap.extract
  end
  biggest
end
