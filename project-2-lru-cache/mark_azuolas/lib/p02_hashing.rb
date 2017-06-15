class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    sum = 0
    each_with_index do |el, i|
      sum += el.hash * i+1
    end
    sum.hash
  end
end

class String
  def hash
    sum = 0
    split('').each_with_index do |char, i|
      sum += char.ord.hash * i+1
    end
    sum.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    sum = 0
    each_key do |key|
      sum += key.hash + self[key].hash
    end
    sum.hash
  end
end
