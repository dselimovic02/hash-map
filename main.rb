require_relative 'lib/hash_map'

hash_map = HashMap.new

hash_map.set('Denis', 42)
hash_map.set('Anja', 52)

p hash_map.buckets
