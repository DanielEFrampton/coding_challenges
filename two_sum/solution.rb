def two_sum(nums, target)
    nums.each_with_index do |outer_num, outer_index|
        nums.each_with_index do |inner_num, inner_index|
            next if outer_index == inner_index
            if outer_num + inner_num == target
                return [outer_index, inner_index]
            end
        end
    end
end

# The above solution exceeds the time limit on Leetcode.
# I adjusted for this by skipping the comparison when a number exceeds target:

def two_sum(nums, target)
    length = nums.length
    nums.each_with_index do |outer_num, outer_index|
        diff = target - outer_num # e.g., target = 0, outer_num = -3, diff = 3
        nums.each_with_index do |inner_num, inner_index|
            next if outer_index == inner_index
            next if inner_num > diff
            if outer_num + inner_num == target
                return [outer_index, inner_index]
            end
        end
    end
end

# But this ran afoul of an array that contained negative integers
# which were less than the target but were part of the solution.
# I.e., -3 plus 3 equals target of 0, but -3 was skipped.

# An element could be less than the target, or greater. In order to rule
# out elements like this, unless there's a math operation I'm neglecting,
# you'd have to perform the operation once per combination in any case.

# Need to account for:
    # zero target & elements
    # negative target & elements
    # un-sorted arrays

# And if possible, get below quadratic time, which I believe I was able
# to do in a previous attempt at this challenge while at Turing.

# If the array were sorted, two pointers could be used to search
# the array for combinations.
# But if it were sorted, then the indices would be messed up.
# Using pointers and loops might still be the way to go.
# Without some way of fundamentally removing the need to iterate over
# each combination of both elements, though, it won't improve much.

# However, using the idea of the difference from the target earlier might help.
# If I make an array of equal length to the nums array containing
# the difference from the target, can I then use that to quickly find a match?

def two_sum(nums, target)
    diffs = nums.map { |num| target - num }
end

# This doesn't appear to be helping. What if that were a hash?

def two_sum(nums, target)
    complements = {}
    nums.each_with_index do |num, index|
        complements[target - num] = index
    end
    nums.each_with_index do |num, index|
        if complements[num] && complements[num] != index
            return [complements[num], index]
        end
    end
end

# This got past the time issue, and is in the 33rd percentile on Leetcode.

p two_sum([2, 7, 11, 15], 9)
