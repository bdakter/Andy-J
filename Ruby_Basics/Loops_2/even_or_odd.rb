# Write a loop that prints numbers 1-5 and whether the number is even or odd.
# Use the code below to get # started.
#
# count = 1
#
# loop do
#   count += 1
# end
# Expected output:
#
# 1 is odd!
# 2 is even!
# 3 is odd!
# 4 is even!
# 5 is odd!

# ANSWER

count = 1

loop do
  puts count.odd? ? "#{count} is odd!" : "#{count} is even!"
  count += 1
  break if count > 5
end
