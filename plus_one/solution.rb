# The easy, but messy, Ruby way:
# def plus_one(digits)
    # digit_string = digits.join('')
    # digit_num = digit_string.to_i
    # new_total = digit_num + 1
    # result = new_total.to_s.split('')
    # result.map {|char| char.to_i}
# end

# A less destructive/memory-intensive but more complex way:

# General idea:
    # Starting at final index (-1), check if number is less than 9.
        # If it is, add 1 to it, and return modified array.
        # If it isn't, change to 0 and move to the left, repeating.

# def plus_one(digits)
#     modified_digits = digits
#     current_index = -1
#     loop do
#         if modified_digits[current_index] < 9
#             modified_digits[current_index] += 1
#             return modified_digits
#         else
#             modified_digits[current_index] = 0
#             current_index -= 1
#         end
#     end
# end

# Edge case encountered:
    # If the left-most number is 9 and it needs to be incremented by one, it attempts to move beyond
    # the first index and the method fails because it tries to compare with nil.
    # Need to be able to create a unshift a new element with the digit `1` in that scenario.
    # The loop...do structure doesn't currently know or care about index position relative to length.
        # But I can check for nil.

def plus_one(digits)
    modified_digits = digits
    current_index = -1
    loop do
        if modified_digits[current_index] == nil
            modified_digits.unshift(1)
            return modified_digits
        elsif modified_digits[current_index] < 9
            modified_digits[current_index] += 1
            return modified_digits
        else
            modified_digits[current_index] = 0
            current_index -= 1
        end
    end
end

p "result from [4,3,2,1]: #{plus_one([4,3,2,1])}"
p "result from [4,3,9,9]: #{plus_one([4,3,9,9])}"
p "result from [9,9,9,9]: #{plus_one([9,9,9,9])}"