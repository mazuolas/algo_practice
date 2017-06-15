require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    @count += 1
    resize! if @count == num_buckets
    self[key] << key unless self[key].include?(key)
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    self[key].delete(key)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    newStore = Array.new(num_buckets*2) {[]}
    @store.each do |bucket|
      bucket.each do |num|
        newStore[num.hash % newStore.length] << num
      end
    end
    @store = newStore
  end
end
