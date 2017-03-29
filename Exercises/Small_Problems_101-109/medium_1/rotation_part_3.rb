# rotation_part_3.rb

#Understand the problem
#  If you take a number like 735291, and rotate it to the left, you get 352917.
#  If you now keep the first digit fixed in place, and rotate the remaining
#  digits, you get 329175. Keep the first 2 digits fixed in place and rotate
#  again to 321759. Keep the first 3 digits fixed in place and rotate again to
#  get 321597. Finally, keep the first 4 digits fixed in place and rotate the
#  final 2 digits to get 321579. The resulting number is called the maximum
#  rotation of the original number.

#  Write a method that takes an integer as argument, and returns the maximum
#  rotation of that argument. You can (and probably should) use the
#  rotate_rightmost_digits method from the previous exercise.

#Examples / Test Cases
#  max_rotation(735291) == 321579
#  max_rotation(3) == 3
#  max_rotation(35) == 53
#  max_rotation(105) == 15 # the leading zero gets dropped
#  max_rotation(8_703_529_146) == 7_321_609_845

#Data Structures
#  - Input:
#  - Intermediate:
#  - Output:
#  - Return:
#
#Algorithm / Abstraction
#  -

# Program
puts "\n-------"
puts "Program"
puts "-------"
def rotate_array(array)
  array[1..-1] + [array[0]]
end

def rotate_rightmost_digits(integer, n)
  digit_str = integer.to_s.chars
  digit_str[-n..-1] = rotate_array(digit_str[-n..-1])
  digit_str.join.to_i
end

def max_rotation(integer)
  digit_count = integer.to_s.chars.length
  digit_count.downto(2) do |n|
    integer = rotate_rightmost_digits(integer, n)
  end
  integer
end

puts max_rotation(735291) == 321579
puts max_rotation(3) == 3
puts max_rotation(35) == 53
puts max_rotation(105) == 15 # the leading zero gets dropped
puts max_rotation(8_703_529_146) == 7_321_609_845


puts "\n-------------------"
puts "Further Exploration"
puts "-------------------"
