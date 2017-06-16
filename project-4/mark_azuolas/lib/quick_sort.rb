class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length < 2
    val = array.shift
    left = []
    right = []
    array.each { |el| el > val ? right << el : left << el}
    QuickSort.sort1(left) + [val] + QuickSort.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length < 2
    prc ||= Proc.new { |x, y| x <=> y }

    pivot = self.partition(array, start, length, &prc)
    left_length = pivot - start
    right_length = length - left_length - 1
    self.sort2!(array, start, left_length, &prc)
    self.sort2!(array, pivot + 1, right_length, &prc)
    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }

    pivot = array[start]
    pivot_index = start

    ((start+1)...(start+length)).each do |i|
      if prc.call(pivot, array[i]) > 0
        array[pivot_index], array[i] = array[i], array[pivot_index+1]
        array[pivot_index+1] = pivot
        pivot_index += 1
      end
    end
    pivot_index
  end

end
