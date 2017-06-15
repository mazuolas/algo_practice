require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @length = 0
    @capacity = 8
    @start = 0
  end

  # O(1)
  def [](index)
    raise 'index out of bounds' if index+1 > @length
    @store[(@start+index) % @capacity]
  end

  # O(1)
  def []=(index, value)
    raise 'index out of bounds' if index+1 > @length
    @length += 1
    if index < @capacity
      @store[(@start+index) % @capacity] = value
    else
      resize!
      @store[(@start+index) % @capacity] = value
    end
  end

  # O(1)
  def pop
    raise 'index out of bounds' if @length == 0
    @length -= 1
    last = @store[(@start+@length) % @capacity]
    @store[(@start+@length) % @capacity] = nil
    last
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length == @capacity
    @store[(@start+@length) % @capacity] = val
    @length +=1
  end

  # O(n): has to shift over all the elements.
  def shift
    raise 'index out of bounds' if @length == 0
    first = @store[@start]
    @length -= 1
    @start = (@start + 1) % capacity
    first
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length == @capacity
    @length += 1
    @start = (@start - 1) % @capacity
    @store[@start] = val
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  # O(n): has to copy over all the elements to the new store.
  def resize!
    newStore = StaticArray.new(@capacity*2)
    @length.times do |i|
      newStore[i] = self[i]
    end
    @start = 0
    @capacity *= 2
    @store = newStore
  end
end
