class MaxIntSet
  def initialize(max)
    @store = []
    @max = max
  end

  def insert(num)
    is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    is_valid?(num)
    @store[num] = false
  end

  def include?(num)
    is_valid?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    raise 'Out of bounds' if num > @max || num < 0
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num % 20][num] = true
  end

  def remove(num)
    @store[num % 20][num] = false
  end

  def include?(num)
    @store[num % 20][num]
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { [] }
    @count = 0
  end

  def insert(num)
    @count += 1
    resize! if @count > num_buckets
    self[num] << num if !self[num].include?(num)
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    newStore = Array.new(num_buckets*2) {[]}
    @store.each do |bucket|
      bucket.each do |num|
        newStore[num % newStore.length] << num
      end
    end
    @store = newStore
  end
end
