require_relative 'enumerable'
include Enumerable

[1,2,3].my_each {|x| puts x}
[1,2,3].my_each_with_index {|x| puts x}
[1,2,3,4].my_select {|x| x.even?}
puts [1,2,3,4].my_all {|x| x <= 4}
puts [1,2,3,4].my_any {|x| x > 4}
puts [1,2,3,4].my_none {|x| x > 4}
puts [1, 2, 4, 2].count
puts [1, 2, 4, 2].count(2)
puts [1, 2, 4, 2].count {|x| x % 2 == 0}
p [1, 2, 3, 4].my_map {|x| x * 2}
puts [1,2,3,4,5,6,7,8,9,10].inject(0) {|result,element| result + element}
puts [1,2,3,4,5,6,7,8,9,10].inject {|result,element| result * element}
p [1,2,3,4,5,6,7,8,9,10].my_map_proc Proc.new {|element| element ** 2}
p [1,2,3].my_map_proc_and_block Proc.new {|element| element + 1} {|value| value ** 2}
