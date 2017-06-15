require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @length = 0
    @capacity = 8
  end

  # O(1)
  def [](index)
    raise 'index out of bounds' if index+1 > @length
    @store[index]

  end

  # O(1)
  def []=(index, value)
    @length += 1
    if index < @capacity
      @store[index] = value
    else
      resize!
      @store[index] = value
    end
  end

  # O(1)
  def pop
    raise 'index out of bounds' if @length == 0
    @store[@length] = nil
    @length -= 1
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length == @capacity
    @length +=1
    @store[@length] = val
  end

  # O(n): has to shift over all the elements.
  def shift
    raise 'index out of bounds' if @length == 0
    first = @store[0]
    @length -= 1
    @length.times do |i|
      @store[i] = @store[i+1]
    end
    @store[length+2] = nil
    first
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length == @capacity
    old = @store[0]
    @store[0] = val
    @length.times do |i|
      @store[i+1], old = old, @store[i+1]
    end
    @length+=1
    @store
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity *= 2
    newStore = StaticArray.new(@capacity)
    @length.times do |i|
      newStore[i] = @store[i] if @store[i]
    end
    @store = newStore
  end
end
