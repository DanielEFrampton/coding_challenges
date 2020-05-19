# def move_zeroes(nums)
#     pointer = 0
#     zeroes = 0
#     until nums[pointer] == nil
#         if nums[pointer] == 0
#             nums.delete_at(pointer)
#             zeroes += 1
#         else
#             pointer += 1
#         end
#     end
#     zeroes.times { nums.push(0) }
# end

# The above solution was judged to have a 64ms runtime by Leetcode,
# which beat 19.73% of other submissions. How to optimize?
# The iteration at the end is costly. I'll try to remove that by going
# backwards over nums, instead of forward, to avoid the endless loop
# problem introduced by moving the zeroes to the end.

# def move_zeroes(nums)
#     pointer = -1
#     until nums[pointer] == nil
#         if nums[pointer] == 0
#             nums.delete_at(pointer)
#             nums.push(0)
#         end
#         pointer -= 1
#     end
# end

# This solution ended up being slower; 13.49% percentile.

# Brainstorming alternative solutions:
    # Sort the array to move all the zeroes to the front, then move them either by slicing and rearranging
        # or by a conditional "until number is not zero" algorithm.
    # Try to simplify the first solution.

# def move_zeroes(nums)
#     pointer = 0
#     zeroes = []
#     until nums[pointer] == nil
#         if nums[pointer] == 0
#             nums.delete_at(pointer)
#             zeroes << 0
#         else
#             pointer += 1
#         end
#     end
#     nums.concat(zeroes)
# end

# Up to 25.17% percentile.

# def move_zeroes(nums)
#     nums.sort!
#     pointer = 0
#     while nums[pointer] == 0
#         nums.rotate!(1)
#     end
# end

# This solution broke when presented with an array containing only zeroes.
# I added my own test case for this situation.
# I don't think this has potential, though; already several O(n) operations.

# Let's try moving zeroes progressively to the right.
    # If the number at the pointer is zero, and the one to the right of it is not:
        # swap them (using a buffer variable)
    # If the number is zero and so is the one to its right; 
        # expand the "window" of zeroes? (with a second pointer)
    # If the element to the right of the "window" is nil:
        # stop.
# This feels really complicated. But let's give it a try.

# def move_zeroes(nums)
#     start = 0
#     finish = 0
#     loop do
#         if nums[finish + 1] == nil # closing scenario; next is nil
#             break
#         elsif nums[finish] != 0 # opening scenario
#             # move both start and end of window forward if non-zero;
#             # (only proceed to next conditions if pointer is zero)
#             start +=1
#             finish +=1
#         elsif nums[finish + 1] != 0 # if next is non-zero, swap zeroes right
#             nums[start] = nums[finish + 1] # move non-zero num to start of window
#             nums[finish + 1] = 0 # put zero in its place
#             start += 1 # move start of window forward
#             finish += 1 # move end of window forward
#         elsif nums[finish + 1] == 0 # if next is zero, expand window
#             finish += 1 # move end of window forward but not start
#         end
#     end
# end

# It worked; but still only 22nd percentile.

# Let's return to the scenario where we can assume sorted elements.
# [0,0,1,3,12]
# Options at this point:
    # Count the zeroes until hitting non-zero, rotate by that amount.
    # Vice versa, ount the non-zeroes from the right until hitting zero.

# def move_zeroes(nums)
#     nums.sort!
#     zeroes = 0
#     nums.each do |num|
#         zeroes += 1 if num == 0
#         break if num != 0
#     end
#     nums.rotate!(zeroes)
# end

# This method failed when it encountered a test case where the original 
# non-zero elements were not in ascending order. I assumed this in my test cases.
# Using destructive sort will not work.

# At this point, having several working solutions, I looked at the "optimal solution"
# guide made available by Leetcode. Their optimal solution closely resembles my "window" solution.
# I'm going to rework this to try to optimize it as final submission.

# If an each block is used to iterate, I can remove a lot of the addition performed
# to move the pointers, and reduce the conditional logic to only worry about
# non-zero elements found.

# Pseudocode:
    # If the element is not zero,
        # move it to the right of the last non-zero element, 
        # replace with zero,
        # update last seen non-zero element position
    # If it is zero,
        # ignore?
            # (if it will end up after the last non-zero element, it's fine;)
            # (if not, it will get over-written)

# What if the first element is non-zero?
    # Need to ignore logic somehow to avoid over-writing itself
    # don't declare last seen non-zero variable until first is found?
    # I'll attempt it with an initial "last seen" value of -1, so that
    # "after the last non-zero element" will always start at 0 position.

# def move_zeroes(nums)
#     last_non_zero_element = -1
#     nums.each_with_index do |num, index|
#         if num != 0
#             last_non_zero_element += 1
#             buffer = nums[last_non_zero_element]
#             nums[last_non_zero_element] = num
#             nums[index] = buffer
#         end
#     end
# end

# This makes the code more concise, but is now slower; 72ms, 17th percentile.
# I will submit the original and call this a good learning experience. :)

def move_zeroes(nums)
    start = 0
    finish = 0
    loop do
        if nums[finish + 1] == nil # closing scenario; next is nil
            break
        elsif nums[finish] != 0 # opening scenario
            # move both start and end of window forward if non-zero;
            # (only proceed to next conditions if pointer is zero)
            start +=1
            finish +=1
        elsif nums[finish + 1] != 0 # if next is non-zero, swap zeroes right
            nums[start] = nums[finish + 1] # move non-zero num to start of window
            nums[finish + 1] = 0 # put zero in its place
            start += 1 # move start of window forward
            finish += 1 # move end of window forward
        elsif nums[finish + 1] == 0 # if next is zero, expand window
            finish += 1 # move end of window forward but not start
        end
    end
end

input_1 = [0,1,0,3,12]
output_1 = [1,3,12,0,0]
move_zeroes(input_1)
p "The value of the input after move_zeroes is #{output_1}?: #{input_1 == output_1}"
p "(It was #{input_1})" unless input_1 == output_1

input_2 = [0]
output_2 = [0]
move_zeroes(input_2)
p "The value of the input after move_zeroes is #{output_2}?: #{input_2 == output_2}"
p "(It was #{input_2})" unless input_2 == output_2

input_3 = [5,4,3,2,0,1]
output_3 = [5,4,3,2,1,0]
move_zeroes(input_3)
p "The value of the input after move_zeroes is #{output_3}?: #{input_3 == output_3}"
p "(It was #{input_3})" unless input_3 == output_3