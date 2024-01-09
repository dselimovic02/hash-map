require_relative 'node'

class HashMap
  attr_reader :buckets
  
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

  private

  def check_capacity
    num_of_buckets = @buckets.reduce(0) do |num, bucket| 
      num += 1 unless bucket.nil?
      num
    end
    @buckets += Array.new(16) if @capacity > num_of_buckets * @load_factor
  end
end