# Prep:

# Conceptually:
    # Take original matrix, cut into quarters.
    # Move each element onto matching space in next quarter.

# What is the pattern?
# Given:
#   [ 5, 1, 9,11],
#   [ 2, 4, 8,10],
#   [13, 3, 6, 7],
#   [15,14,12,16]
# If the matrix is treated as concentric rings,
    # each element in the outer ring is getting moved n-1 spaces forward in the ring;
    # each element in the inner ring is getting moved (n -2 -1)
# Does this work with diff. sizes?
#   [1,2,3],
#   [4,5,6],
#   [7,8,9]
#   Yes.
#   [ 5, 1, 9,11,3],
#   [ 5, 1, 9,11,3],
#   [ 2, 4, 8,10,3],
#   [13, 3, 6, 7,3],
#   [15,14,12,16,3]
#   Yes.
# Is it easy to implement the idea of multiple concentric rings in an algorithm?
    # ehhhh.
# Is there another way of conceiving of the movement that would work mathematically?
    # In this case:
        #   [1,2,3],
        #   [4,5,6],
        #   [7,8,9]
    # 1 is at [0,0] and needs to move to [2,0].
    # 2 is at [1,0] and needs to move to [2,1].
    # 3 is at [2,0] and needs to move to [2,2].
    # 4 is at [0,1] and needs to move to [1,0].

# Observations so far:
    # - If n is odd, the central piece can be ignored; but it also follows the (n -2 -1) rule.
    # - The algorithm could be broken down into (n * n / 4) cycles of 4 steps each:
        # for every element in the top left quadrant:
            # 4 times do:
                # calculate target (where current element needs to be moved to)
                # store the value currently at target,
                # move the value at current element (or prev. stored value) to target

    # - Instead of square quadrants, could also do triangles, but works better on odd #s
        # [x, x, x]
        # [0, x, 0]
        # [0, 0, 0]
        # or:
        # [x,x,x,x,x]
        # [0,x,x,x,0]
        # [0,0,x,0,0]
        # [0,0,0,0,0]
        # [0,0,0,0,0]
        # but this doesn't quite work, see [1,1] which would move to [2,1], another x:
        # [x,x,x,x]
        # [0,x,x,0]
        # [0,0,0,0]
        # [0,0,0,0]
        # this is accurate:
        # [x,x,x,x,0]
        # [0,x,x,0,0]
        # [0,0,0,0,0]
        # [0,0,0,0,0]
        # [0,0,0,0,0]
        # and this is accurate:
        # [x,x,x,0]
        # [0,x,0,0]
        # [0,0,0,0]
        # [0,0,0,0]
        # The math of which is:
            # The first row, except for the last;
            # the next row, beginning 1 in, except for last 2
            # etc., until target row is empty

# Finding next cell in sequence:
    # n = 5
    # from a to b:
    # [0,a,0,0,0]
    # [0,0,0,0,b]
    # [0,0,0,0,0]
    # [d,0,0,0,0]
    # [0,0,0,c,0]
    # target's x is equal to abs. difference between current element's y index and (length - 1):
        # a = [1,0]
        # b = [4,1]
        # c = [3,4]
        # d = [0,3]
        # a's y: 0
        # length = 4
        # abs(4 - 0) == 4
        # b's y: 1
        # abs (4,1) == 3
        # c's x: 3
        # c's y: 4
        # abs(4,4) == 0
        # That works!
    # target's y is equal to current x
        # a's x: 1
        # b's y: 1
        # b's x: 4
        # c's y: 4
        # c's x: 3
        # d's y: 3
        # That works! 
    # [0,0,0,0,0]
    # [0,a,0,b,0]
    # [0,0,0,0,0]
    # [0,d,0,c,0]
    # [0,0,0,0,0]
    # a = [1,1]
    # b = [3,1]
    # c = [3,3]
    # d = [1,3]
        # still works!

# Pseudocode:
    # find and store `n`
    # set row start pointer to 0
    # set row end pointer to n-1
    # set current row pointer to 0
    # until row start pointer is equal to or less than row end pointer,
        # for each element on current row, from start to end, do:
            # do four times:
                # find target cell:
                    # target 
                # save value at target cell to buffer
                # store current cell's value (or previous buffer value) in target cell
        # add one to current row pointer
        # add one to row start pointer
        # subtract one from end pointer

def rotate(matrix)
    length = matrix.length
    row_start = 0
    row_end = length - 2
    current_row = 0
    until row_start > row_end
        matrix[current_row][row_start..row_end].each_with_index do |current_element, index|
            stored_value = current_element
            current_x = index + row_start
            current_y = current_row
            4.times do |cycle|
                target_x = (current_y - (length - 1)).abs
                target_y = current_x
                next_value = matrix[target_y][target_x]
                matrix[target_y][target_x] = stored_value
                stored_value = next_value
                current_x = target_x
                current_y = target_y
            end
        end
        row_start += 1
        row_end -= 1
        current_row += 1
    end
end

matrix = [
  [1,2,3],
  [4,5,6],
  [7,8,9]
]
modified_matrix = matrix.dup

rotate(modified_matrix)

expected = [
  [7,4,1],
  [8,5,2],
  [9,6,3]
]

puts "matrix should be:"
expected.each { |row| p row }
puts "matrix after method was:"
modified_matrix.each { |row| p row }
puts "are they the same? #{ modified_matrix == expected ? 'yes' : 'no' }"

matrix_2 = [
  [ 1, 2, 3, 4],
  [ 5, 6, 7, 8],
  [ 9,10,11,12],
  [13,14,15,16]
]
modified_matrix_2 = matrix_2.dup

rotate(modified_matrix_2)

expected_2 = [
  [13, 9, 5, 1],
  [14,10, 6, 2],
  [15,11, 7, 3],
  [16,12, 8, 4]
]

puts "2nd matrix should be:"
expected_2.each { |row| p row }
puts "matrix after method was:"
modified_matrix_2.each { |row| p row }
puts "are they the same? #{ modified_matrix_2 == expected_2 ? 'yes' : 'no' }"