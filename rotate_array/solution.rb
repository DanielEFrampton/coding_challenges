def rotate(nums, k)
    # The easy, Ruby way:
    # nums.rotate!(-k)
    
    # Slightly more complex way using extra memory:
    # length = nums.length
    # back_portion = nums.pop(k % length)
    # nums.unshift(*back_portion)

    # First attempt at O(1) space complexity, in-place way:
    # length = nums.length
    # if length.odd?
    #     current_index = 0
    #     prev_value = nil
    #     next_value = nil
    #     length.times do |time|
    #         next_value = nums[(current_index + k) % length]
    #         if prev_value
    #             nums[(current_index + k) % length] = prev_value
    #         else # on the first iteration
    #             nums[(current_index + k) % length] = nums[current_index]
    #         end
    #         prev_value = next_value
    #         current_index = (current_index + k) % length
    #     end
    # else
    #     # account for even length
    # end
    
    # Successful attempt at O(1), in-place way:
    length = nums.length
    cycles = length.gcd(k)
    cycles.times do |start_index|
        current_index = start_index
        next_index = nil
        prev_value = nil
        until next_index == start_index
            next_index = (current_index + k) % length
            stored_next_value = nums[next_index]
            if prev_value
                nums[next_index] = prev_value
            else # on the first iteration
                nums[next_index] = nums[current_index]
            end
            prev_value = stored_next_value
            current_index = next_index
        end
    end
end

nums = [1,2,3,4,5,6,7]
result = rotate(nums, 3)
puts "nums is [5,6,7,1,2,3,4]: #{(nums ==[5,6,7,1,2,3,4])}"
puts "(nums was actually #{nums})"

nums_2 = [1,2,3,4,5,6,7]
result = rotate(nums_2, 2)
puts "nums_2 is [6,7,1,2,3,4,5]: #{(nums_2 == [6,7,1,2,3,4,5])}"
puts "(nums_2 was actually #{nums_2})"

nums_3 = [1,2,3,4,5,6]
result = rotate(nums_3, 2)
puts "nums_3 is [5,6,1,2,3,4]: #{(nums_3 == [5,6,1,2,3,4])}"
puts "(nums_3 was actually #{nums_3})"

# Brainstorming after first attempt, and before final attempt:

# When length of array is odd, cyclic dependency always touches all
# elements in the array.

# When length of array is even, and "k" divides evenly into length,
# cyclic dependency creates [length / k ] working cycles

# When length of array is even and "k" does not divide evenly into length,
# cyclic dependency can have errors and leave orphaned elements unchanged.
# E.g., given [1,2,3,4,5,6], k=4, the cycle goes:
    # 1, 5, 3, 1
    # 2, 6, 4, 2 (well maybe not)
# given [1,2,3,4,5,6,7,8,9,10], k=7, the cycle goes:
    # 1,8,5,2,9,6,3,10,7,4 (the whole thing..what?)
# given [1,2,3,4], k=3, the cycle goes:
    # 1,4,3,2
# given [1,2,3,4,5,6,7,8,9,10], k=3, the cycle goes:
    # 1,4,7,10,3,6,9,2,5,8 (the whole thing...what?)
# given [1,2,3,4,5,6,7,8,9,10], k=9, the cycle goes:
    # 1,10,9,8,7,6,5,4,3,2

# given [1,2,3,4,5,6,7,8], k=3,
    # 1,4,7,2,5,8,3,6
# given [1,2,3,4,5,6,7,8], k=6,
    # 1,7,5,3
    # 2,8,6,4
# given [1,2,3,4,5,6,7,8,9,10,11,12], k=4,
    # 1,5,9
    # 2,6,10
    # 3,7,11
    # 4,8,12

# Revised understanding:
    # If array length is odd, it (typically) works in one cycle (see below).
    # If array length is even and k is odd, it works in one cycle.
    # if array length is even and k is even, multiple cycles needed.
        # how many?
            # seems closely related to relation between length and remainder of length / k.
            # the below tools support the idea that the number of cycles needed
                # can be determined by dividing length by k, and if there is a remainder, dividing length by the remainder.
            # I have apparently discovered what "greatest common divisor" means
            # The number of cycles can found by:
                # the greatest common divisor (GCD) between the length of the array and "k."
            # The number of elements found by each cycle:
                # the length divided by the number of cycles (GCD of length and k).
# Revised revised understanding:
    # The number of cycles needed is defined by the GCD of array length and k.
    # Even odd numbered array lengths will sometimes require multiple cycles.
        # E.g., array length of 9 and k of 3:
            # 1,4,7
            # 2,5,8
            # 3,6,9
    # But it is more likely for even-length arrays with even k values, because the GCD is so often 2+.

# New method pseudocode:
    # Find length of nums array.
    # Find GCD between length and k, name "cycles"
    # for each "cycle" in "cycles" times, do:
        # (the loop, until the pointer returns to start position)
        # But each time increase the start position by 1.

def find_cycle(array_length, k)
    nums = (1..array_length).to_a
    cycle = []
    current_index = 0
    next_target = nil
    until nums[0] == next_target
        cycle << nums[current_index]
        current_index = (current_index + k) % array_length
        next_target = nums[current_index]
    end
    cycle
end

def get_evens(top_num)
    (1..top_num).to_a.select do |num|
        num % 2 == 0
    end
end

# length = 50
# k_options = get_evens(length)
# k_options.each do |k|
#     found = find_cycle(length,k)
#     puts "for length of #{length} and k of #{k}, found #{found}, length was #{found.length}." +
#         " (length / k) = #{length / k}, remainder of #{length % k}."
#     puts "the greatest common divisor of length and k is #{length.gcd(k)}."
#     puts "Was the GCD equal to the array length divided by the length of the cycle found?: #{(length / found.length) == length.gcd(k)}"
# end

