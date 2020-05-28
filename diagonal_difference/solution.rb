def diagonalDifference(arr)
    left_to_right = 0
    right_to_left = 0
    column = 0
    row = 0
    until arr[row] == nil || arr[row][column] == nil
        left_to_right += arr[row][column]
        row += 1
        column += 1
    end
    row = 0
    column = -1
    until arr[row] == nil || arr[row][column] == nil
        right_to_left += arr[row][column]
        row += 1
        column -= 1
    end
    (left_to_right - right_to_left).abs
end

array = [[11, 2, 4], [4, 5, 6], [10, 8, -12]]
p diagonalDifference(array)