# Generate a 2-dimension grid with equal height and length, made up of cells,
# each of which has an equal chance to be one of four "dungeon" elements.
#
# Input: integer (non-zero, positive)
# Output: Array of arrays, whose elements are one-character strings
#
# Pseudocode:
#
# Define a method, with one argument, the size integer called "number"
#   Declare an array containing the four dungeon element strings, called "elements"
#   Declare a variable containing an empty array, named "grid"
#   For "row number" times,
#     Create an empty "row" array
#     For "column number" times,
#       If the previous row (referred to by way of the current "number") and the previous column, current column, and next column,
#         or previous column in the current row contain a monster element,
#         Choose a random element from the "elements" array sliced to only include the last 3 (excluding the monster), push it onto the "row" array
#       Otherwise (else)
#         Choose a random element from the "elements" array and push it onto the "row" array
#     Push the generated "row" onto the "grid"
#   Return the completed "grid" array

# - 'M' indicates a monster
# - 't' indicates treasure
# - '#' indicates a rock pile
# - ' ' indicates empty space

# After floor is generated, unless the z-coordinate is zero (i.e., top floor),
#  Change the element at the temporarily stored x,y coordinate of previous floor's down stairs to an up-stair element
# After floor is generated, if the z-coordinate of the floor is not the final (i.e., equals size)
#  Until x and y on grid do not contain an upward-facing stair,
  # Choose a random x coordinate, and random y coordinate
#  Change that element to a downward-facing stair
#  Store that x, y coordinate temporarily so the next floor can place an upward-facing stair

class DungeonGenerator

  def initialize(size)
    @size = size
    @dungeon = []
  end

  def generate
    previous_stairs = []
    @size.times do |z|
      floor = floor_generator
      unless z == 0
        floor[previous_stairs[0]][previous_stairs[1]] = 'u'
      end
      unless z == @size-1
        new_stair_coords = previous_stairs
        until new_stair_coords != previous_stairs
          new_stair_coords = [(0..(@size-1)).to_a.sample, (0..(@size-1)).to_a.sample]
        end
        floor[new_stair_coords[0]][new_stair_coords[1]] = 'd'
        previous_stairs = new_stair_coords
      end
      @dungeon << floor
    end
    @dungeon
  end

  def floor_generator
    elements = ['M', 't', '#', ' ']
    grid = []
    @size.times do |x| # 2
      row = []
      @size.times do |y| # 0
        if adjacent_monster?(x, y, row, grid)
          row.push(elements[1,3].sample)
        else
          row.push(elements.sample)
        end
      end
      grid << row
    end
    grid
  end

  def adjacent_monster?(x, y, row, grid)
    return true if y != 0 && row[y-1] == 'M'
    unless x == 0
      return true if y != 0 && grid[x-1][y-1] == 'M'
      return true if grid[x-1][y] == 'M'
      unless y == @size-1
        return true if grid[x-1][y+1] == 'M'
      end
    end
    false
  end

end

generator = DungeonGenerator.new(4)
dungeon = generator.generate

dungeon.each do |floor|
  floor.each { |row| p row }
  print "\n"
end
