require_relative 'lib/hash_map'

hash_map = HashMap.new

20.times do |i|
  hash_map.set("Test#{i+1}", i)
end

hash_map.entries




