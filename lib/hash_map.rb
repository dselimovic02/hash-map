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
      @buckets[key_index].add(Node.new(key, value))
    end

    check_capacity
  end

  def get(key)
    key_index = hash(key)

    node = @buckets[key_index] || nil
    loop do
      break if node.nil?
      break if node.key.eql? key
      node = node.next
    end

    
    node.value || nil
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
    print '{'
    str = ''
    @buckets.each_with_index do |bucket, i|
      unless bucket.nil?
        str += "#{bucket}, "
      end
    end
    print "#{str[0..-3]}}\n"
  end

  private

  def check_capacity
    if @capacity > @buckets.length * @load_factor
      pairs = get_pairs

      @buckets = Array.new(@buckets.length * 2)

      pairs.each { |pair| set(pair[0], pair[1]) } 
    end
  end

  def get_pairs
    ary = []
    @buckets.each do |bucket|
      next if bucket.nil?
      if bucket.next.nil?
        ary << [bucket.key, bucket.value]
      else 
        ary += bucket.get_pairs
      end
    end
    ary
  end
end