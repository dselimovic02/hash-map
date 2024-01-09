require_relative 'node'

class HashMap
  def initialize
    @buckets = Array.new(16)
    @capacity = 0
    @load_factor = 0.75
  end

  def hash(string)
    hash_num = 0
    prime_num = 31

    string.each_char{ |char| hash_num = prime_num * hash_num + char.ord}

    hash_num % @buckets.length
  end

  def set(key, value)
    key_index = hash(key)

    if @buckets[key_index].nil?
      @buckets[key_index] = Node.new(key, value)
      @capacity += 1
    else
      @buckets[key_index].value = value
    end

    check_capacity
  end

  def key?(key)
    key_index = hash(key)
    return false if @buckets[key_index].nil?

    true
  end

  def remove(key)
    key_index = hash(key)

    @capacity -= 1
    @buckets[key_index] = nil
  end

  def length
    @capacity
  end

  def clear
    self.initialize
  end

  def keys
    @buckets.reduce([]) { |ary, bucket| ary << bucket.key unless bucket.nil?; ary}
  end

  def values
    @buckets.reduce([]) { |ary, bucket| ary << bucket.value unless bucket.nil?; ary}
  end

  def entries 
    keys = self.keys
    values = self.values
    ary = []
    @capacity.times do |i|
       ary << [keys[i], values[i]]
    end
    ary
  end

  private

  def check_capacity
    @buckets += Array.new(16) if @capacity > @buckets.length * @load_factor
  end
end