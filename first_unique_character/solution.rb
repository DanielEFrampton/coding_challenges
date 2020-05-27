# Different from the closure challenge because there can be 1+ and a stack structure won't work.

# Find in O(n) time:
    # keep track of what has been seen, and how many times, and pick the first with 1? quadratic
    # keep track of what has been seen, remove or shuffle forward duplicates, and pick first? linear
        # removing duplicates won't work because it doesn't account for 2+ occurences
            # i.e., if the duplicate is removed after 2nd is seen, 3rd would be "unique"
            # need structure that persists
            # hash that counts occurences and tracks minimum?
                # don't really need to count occurences, only need to know 1x letter(s).
            # two hashes, one to track uniques, one to track multiples?
        # shuffling forward isn't the use case for a Hash, abuses Ruby

def first_uniq_char(s)
    characters = s.chars
    unique = {}
    multiples =  {}
    characters.each_with_index do |char, index|
        next if multiples[char]
        if unique[char]
            unique.delete(char)
            multiples[char] = index
        else
            unique[char] = index
        end
    end
    unique.first ? unique.first[1] : -1
end

p "leetcode should return 0: #{first_uniq_char("leetcode")}"

# The runtime of the above solution was in the 93rd percentile on Leetcode at time of submission.

# Submitted Leetcode submission: 
# https://leetcode.com/submissions/detail/345561433/?from=/explore/featured/card/top-interview-questions-easy/127/strings/881/