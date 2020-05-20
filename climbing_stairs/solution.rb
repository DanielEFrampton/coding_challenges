# Prep:

# Paraphrase prompt: given positive integer `n`, how many unique sequences of 1 and/or 2 total that number?
# Considered in a linear way, there are a sequence of binary decisions to make: add 1, or 2, to sequence?
# Considered as a whole, there is probably a math operation that can determine this.
# The answer will always be a range between all 1s, and all (or all except one) 2s, and then all the possible
    # unique organizations of those combinations (some could be duplicates of others). 

# Considering the permutations:
    # n = 1
    # 1
    # output = 1

    # n = 2
    # 1,1, 2
    # output = 2

    # n = 3
    # 1,2, 2,1
    # 1,1,1
    # output = 3

    # n = 4
    # all ones: 1, 1, 1, 1 (1)
    # one 2: 1,1,2, 1,2,1, 2,1,1 (3)
    # two 2s: 2,2 (1)
    # output: 5

    # n = 5
    # 1,1,1,1,1 (1)
    # 2,1,1,1..1,1,1,2 (4)
    # 2,2,1, 2,1,2, 1,2,2 (3)
    # output: 8

    # n = 6
    # all ones: 1
    # one 2: 1,1,1,1,2 (5)
    # two 2s: 1,1,2,2, 1,2,1,2, 2,1,1,2, 2,2,1,1, 1,2,2,1, 2,1,2,1 (6)
        # 4 = 3,2,1
    # three 2s: 2,2,2 (1)
    # output = 13

    # n = 7
    # all ones: 1
    # one 2: 6 (e.g., 1,1,1,1,1,2)
    # two 2s: 10
        # 1,1,1,2,2, 2,1,1,1,2, 1,2,1,1,2, 1,1,2,1,2 (4) 
            # if one of the unique elements is fixed in last position,
                # how many positions can the other unique element be in? (length - 1)
        # 1,1,2,2,1, 1,2,1,2,1, 2,1,1,2,1, (3)
            # if one of the non-unique elements is fixed in last position, 
        # 1,2,2,1,1, 2,1,2,1,1, (2) (ignore one more)
        # 2,2,1,1,1 (1)
        # 10 = 4,3,2,1
        # start number of elements (5) minus (one less than number of unique elements)
    # three 2s: 1,2,2,2, 2,1,2,2, 2,2,1,2, 2,2,2,1 (4) (number of ones)
    # output: 21

    # n = 9
    # three 2s:
        # 1,1,1,2,2,2, 1,1,2,1,2,2, 1,2,1,1,2,2, 2,1,1,1,2,2 ... (10) (all the 7 w/ 2 2s, but with 2 in rightmost position)
            # number of elements (6) minus (one less than number of unique elements)
        # 1,1,2,2,2,1

# Pseudocode:
    # declare variable named combinations, starts at 0
    # (n / 2) times, do the following:
        # add (time) number of 2s to an array, then fill the rest with 1s up to target
        # determine number of combinations (???)
            # takes an array as an argument
            # manually move the 2s around?...
        # add that number to total

# def possible_combinations(total,twos)
#     initial = Array.new(total, 1)
#     final = initial.dup
#     final_pointer = -1
#     twos.times do |time|
#         initial[time] = 2
#         final[final_pointer] = 2
#         final_pointer -= 1
#     end
#     possibilities = []
#     until possibilities.last == final
        
#     end
#     # require 'pry'; binding.pry
# end

# (at this point, abandoned attempt to generate actual sequences and began
# attempt to re-create the math patterns present in the permutations above)

def climb_stairs(n)
    possibilities = 0
    counter = n
    return n if n < 4
    until counter == 0
        possibilities += (counter - 1)
        counter -= 1
    end
    possibilities -= 1 if n.even?
    possibilities
end

# (around this time, recognized fibonacci sequence in the output and test cases,
# and abandoned effort to directly reason from the evidence and simply began
# coding a fibonacci sequence generator.)

# recursive fibonacci sequence generator
# pseudo-code:
    # if n is 1 or 2, return n
    # n times:
        # add previous two numbers to get next number

# (abandoned recursive pattern because 1 and 2 present difficulties)
# First attempt at iterative Fibonnaci sequence generator:

def climb_stairs(n)
    return n if n == 1 || n == 2
    sequence = [1,2]
    (n-2).times do |time|
        sequence << (sequence[-1] + sequence[-2])
    end
    sequence.last
end

# Sped up by removing the array manipulation:

def climb_stairs(n)
    return n if n == 1 || n == 2
    second_to_last_num = 1
    last_num = 2
    (n-2).times do
        new_number = second_to_last_num + last_num
        second_to_last_num = last_num
        last_num = new_number
    end
    last_num
end

# The above solution was in the 65th percentile on Leetcode, and was my final submission.

puts "#{climb_stairs(1)} should be 1"
puts "#{climb_stairs(2)} should be 2"
puts "#{climb_stairs(3)} should be 3"
puts "#{climb_stairs(4)} should be 5"
puts "#{climb_stairs(5)} should be 8"
puts "#{climb_stairs(6)} should be 13"
puts "#{climb_stairs(7)} should be 21"
# puts possible_combinations(7,3)

# Conclusion:

# I don't like this challenge, because there's no clear way to get to the solution
# without prior awareness of the Fibonacci sequence or exposure to the challenge.
# In that light, it's challenging your amount of Leetcode practice and/or obscure
# math trivia rather than your problem-solving abilities.