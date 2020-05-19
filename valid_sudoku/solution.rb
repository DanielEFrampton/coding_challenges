def is_valid_sudoku(board)
    has_valid_columns?(board) && has_valid_rows?(board) && has_valid_boxes?(board)
end

def has_valid_columns?(board)
    9.times.all? do |time|
        valid_set?(column(time, board))
    end
end

def column(index, board)
    board.map do |row|
        row[index]
    end
end

def has_valid_rows?(board)
    board.all? do |row|
        valid_set?(row)
    end
end

def valid_set?(set_of_nine)
    digits = set_of_nine.dup
    digits.delete('.')
    digits == digits.uniq
end

def has_valid_boxes?(board)
    boxes = [box_1 = board[0][0..2] + board[1][0..2] + board[2][0..2],
    box_2 = board[0][3..5] + board[1][3..5] + board[2][3..5],
    box_3 = board[0][6..8] + board[1][6..8] + board[2][6..8],
    box_4 = board[3][0..2] + board[4][0..2] + board[5][0..2],
    box_5 = board[3][3..5] + board[4][3..5] + board[5][3..5],
    box_6 = board[3][6..8] + board[4][6..8] + board[5][6..8],
    box_7 = board[6][0..2] + board[7][0..2] + board[8][0..2],
    box_8 = board[6][3..5] + board[7][3..5] + board[8][3..5],
    box_9 = board[6][6..8] + board[7][6..8] + board[8][6..8]]
    boxes.all? { |box| valid_set?(box) }
end

board_1 = [
  ["5","3",".",".","7",".",".",".","."],
  ["6",".",".","1","9","5",".",".","."],
  [".","9","8",".",".",".",".","6","."],
  ["8",".",".",".","6",".",".",".","3"],
  ["4",".",".","8",".","3",".",".","1"],
  ["7",".",".",".","2",".",".",".","6"],
  [".","6",".",".",".",".","2","8","."],
  [".",".",".","4","1","9",".",".","5"],
  [".",".",".",".","8",".",".","7","9"]
]

board_2 = [
  ["8","3",".",".","7",".",".",".","."],
  ["6",".",".","1","9","5",".",".","."],
  [".","9","8",".",".",".",".","6","."],
  ["8",".",".",".","6",".",".",".","3"],
  ["4",".",".","8",".","3",".",".","1"],
  ["7",".",".",".","2",".",".",".","6"],
  [".","6",".",".",".",".","2","8","."],
  [".",".",".","4","1","9",".",".","5"],
  [".",".",".",".","8",".",".","7","9"]
]

p has_valid_columns?(board_1)
p has_valid_rows?(board_1)
p has_valid_boxes?(board_1)
p is_valid_sudoku(board_1)

p has_valid_columns?(board_2)
p has_valid_rows?(board_2)
p has_valid_boxes?(board_2)
p is_valid_sudoku(board_2)