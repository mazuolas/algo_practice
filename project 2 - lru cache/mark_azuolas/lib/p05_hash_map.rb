require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count
  include Enumerable
  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    b = bucket(key)
    if b.include?(key)
      b.update(key, val)
    else
      @count += 1
      resize! if @count == num_buckets
      b.append(key, val)
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    @count -= 1 if bucket(key).remove(key)
  end

  def each(&prc)
    @store.each do |bucket|
      bucket.each do |node|
        prc.call(node.key, node.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets*2) { LinkedList.new }
    each do |key, val|
      new_store[key.hash % new_store.length].append(key,val)
    end
    @store = new_store
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % num_buckets]
  end
end
