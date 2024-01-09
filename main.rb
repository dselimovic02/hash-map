require_relative 'lib/hash_map'

hash_map = HashMap.new

hash_map.set('Test1', 42)
hash_map.set('Test2', true)
hash_map.set('Test3', [1, 2])


p hash_map.entries