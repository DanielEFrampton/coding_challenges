def contains_duplicate(nums)
    # The easy, Ruby way with O(n3) time complexity:
    # nums.length != nums.uniq.length
    
    # The better way, O(n) linear time complexity way:
    seen = {}
    nums.each do |num|
        if seen[num]
            return true
        else
            seen[num] = true
        end
    end
    false
end