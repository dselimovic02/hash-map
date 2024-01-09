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
end