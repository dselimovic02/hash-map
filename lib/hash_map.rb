class HashMap

  def hash(string)
    hash_num = 0
    prime_num = 31

    string.each{ |char| prime_num * hash_num + char.ord}

    hash_num
  end
end