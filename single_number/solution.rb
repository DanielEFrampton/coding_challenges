def single_number(nums)
    # O(n) linear time complexity, but using extra memory:
    unmatched = {}
    nums.each do |num|
        if unmatched[num]
            unmatched.delete(num)
        else
            unmatched[num] = true
        end
    end
    unmatched.first[0]
end