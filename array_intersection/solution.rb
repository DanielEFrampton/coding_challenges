# Initial brainstorming:
# Doing this is quadratic time would look like:
    # For every element in array1,
        # For every element in array2,
            # Do the elements match? 
                # If so, add to results array and remove from array1 and array2.
                # If not, keep iterating.
    # Return results array.
# Is there a way to do this faster?
    # I'll revisit after getting it working.

# def intersect(nums1, nums2)
#     results = []
#     nums1.each_with_index do |outer_num, outer_index|
#         nums2.each_with_index do |inner_num, inner_index|
#             if outer_num == inner_num
#                 results << inner_num
#                 nums1[outer_index] = nil
#                 nums2[inner_index] = nil
#             end
#         end
#     end
#     results
# end

# At this point I realized two things:
    # 1) This doesn't correctly address the problem of removing the two numbers,
        # because while those numbers have been changed to `nil` they still exist as the
        # block variables `outer_num` for the remaining iterations of the inner loop.
    # 2) This destroys the original inputs and that's not great.
# Redesigning this as a recursive method would resolve both issues.

# Pseudo-coding the recursive way:
    # Takes three arguments: first array, second array, and optional results array (defaults to empty array)
        # Does first element in first array equal first element in second array?
            # if yes, 
                # add one of the two numbers to results array,
                # call recursive method with arrays with first elements removed
            # if no,
                # call recursive method with...
# (here, I went off and tried to code it)
# Recursive method doesn't solve the problem of needing to iterate at some level.
# Inserting a "break" when a match is found resolves the problem by simply not continuing to iterate using
# a number as a block variable when it has matched.

# def intersect(nums1, nums2)
#     results = []
#     nums1.each_with_index do |outer_num, outer_index|
#         nums2.each_with_index do |inner_num, inner_index|
#             if outer_num == inner_num
#                 results << inner_num
#                 nums1[outer_index] = nil
#                 nums2[inner_index] = nil
#                 break
#             end
#         end
#     end
#     results
# end

# This method's runtime is quite slow so far. The prompt gives a clue that sorting would help.
# [4,9,5], [9,4,9,8,4] would become: [4,5,9], [4,4,8,9,9].
# This opens up some new possibilities of using index positions and pointers.

def intersect(nums1, nums2)
    results = []
    sorted_1 = nums1.sort
    sorted_2 = nums2.sort
    current_index_1 = 0
    current_index_2 = 0
    while sorted_1[current_index_1] && sorted_2[current_index_2]
        if sorted_1[current_index_1] > sorted_2[current_index_2]
            current_index_2 += 1
        elsif sorted_1[current_index_1] == sorted_2[current_index_2]
            results << sorted_1[current_index_1]
            current_index_1 += 1
            current_index_2 += 1
        else
            current_index_1 += 1
        end
    end
    results
end

p intersect([4,9,5], [9,4,9,8,4])
p intersect([1,2,2,1], [2,2])

# This brought my average runtime down from 204ms to 32ms.

# The answer to the prompt's question, "what if the given array is already sorted,"
# is made fairly simple; I'd remove lines 54 and 55 and interact with the arrays directly.
# Because both arrays have a pointer, the relative size of the arrays shouldn't effect the speed.
# Because the loop stops the moment just one of the arrays has reached the end,
# if one array has many elements greater than the value of the largest number in the other,
# the loop would save time potentially wasted otherwise iterating over irrelevant numbers.
# If one had many elements less than the least in the other, however, it would waste time going over those.

# Finally, the last follow-up question asks what would happen if only one element could be loaded at a time.
# That shouldn't be a problem in this solution because only one of each array is interacted with at a time.
