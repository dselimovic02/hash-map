class Node
  attr_accessor :key, :value, :next

  def initialize(key, value)
    @key = key
    @value = value
    @next = nil
  end

  def add(node = self, new_node)
    if node.next.nil?
      return node.next = new_node
    end

    add(node.next, new_node)
  end

  def to_s
    string = ''
    str_val = ''
    str_key = ''

    node = self
    loop do
      if node.value.is_a?(String)
        str_val = "\"#{node.value}\""
      else
        str_val = "#{node.value}"
      end

      str_key = "\"#{node.key}\""

      string += str_key + '=>' + str_val

      break if node.next.nil?
      string += ", "
      node = node.next
    end
    string
  end

  def get_pairs(node = self)
    return [node.key, node.value] if node.next.nil?
    [[node.key, node.value]] + [get_pairs(node.next)]
  end
end 