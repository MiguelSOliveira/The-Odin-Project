class Node
  attr_accessor :left, :right, :value

  def initialize(value) @value = value end
end

def build_tree(array, root)
  array[1..-1].each do |number|
    cur_node = root
    in_tree = false
    until in_tree
      if number >= cur_node.value
        if not cur_node.right
          cur_node.right = Node.new(number)
          in_tree = true
        else cur_node = cur_node.right end
      else
        if not cur_node.left
          cur_node.left = Node.new(number)
          in_tree = true
        else cur_node = cur_node.left end
      end
    end
  end
end

def print_tree(node)
  puts "Father Node: #{node.value}"
  puts "Left node: #{node.left.value}" if node.left
  puts "Right node: #{node.right.value}" if node.right
  print_tree(node.left) if node.left
  print_tree(node.right) if node.right
end

def bfs(root, target_node)
  return root if root.value == target_node

  queue = [root]
  while not queue.empty?
    cur_node = queue.shift
    return cur_node if cur_node.value == target_node

    queue << cur_node.left if cur_node.left
    queue << cur_node.right if cur_node.right
  end
end

def dfs(root, target_node)
  return root if root.value == target_node

  stack = [root]
  until stack.empty?
    cur_node = stack.pop
    return cur_node if cur_node.value == target_node

    stack << cur_node.left if cur_node.left
    stack << cur_node.right if cur_node.right
  end
end

def print_node_info(node)
  puts "------------------------"
  puts "Value #{node.value}" rescue puts "Value not found"
  puts "Left Node #{node.left.value}" rescue puts "Left node not found"
  puts "Right Node #{node.right.value}" rescue puts "Right node not found"
end

def dfs_rec(cur_node, target_node)
  print_node_info(cur_node) and return if cur_node.value == target_node

  dfs_rec(cur_node.left, target_node) if cur_node.left
  dfs_rec(cur_node.right, target_node) if cur_node.right
end

def binary_search(value, array)
  loop do
    middle = array.size / 2
    return true  if value == array[middle]
    return false if middle < 1
    if value < array[middle]
      array = array[0...middle]
    else
      array = array[middle..-1]
    end
  end
end

array = [3,5,1,4,6,3,1,4]
root = Node.new(array[0])
build_tree(array, root)
print_tree(root)

found_bfs_node = bfs(root, 4)
print_node_info(found_bfs_node)

found_dfs_node = dfs(root, 5)
print_node_info(found_dfs_node)

dfs_rec(root, 1)

binary_search_array = [1,2,3,4,5,6,7,8,9]
puts binary_search(2, binary_search_array)
