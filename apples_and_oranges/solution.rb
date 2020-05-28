# For every apple:
    # Does the apple distance plus the apple tree location lie within the house range?
        # If so, add one to number of apples on house
    # (same for oranges)
    # Print those numbers


def countApplesAndOranges(house_start, house_end, apple_tree, orange_tree, apples, oranges)
    apples_on_house = 0
    oranges_on_house = 0
    apples.each do |apple|
        if apple + apple_tree >= house_start && apple + apple_tree <= house_end
            apples_on_house += 1
        end
    end
    oranges.each do |orange|
        if orange + orange_tree >= house_start && orange + orange_tree <= house_end
            oranges_on_house += 1
        end
    end
    puts apples_on_house
    puts oranges_on_house
end

s = 7
t = 11
a = 5
b = 15
apples = [-2, 2, 1]
oranges = [5, -6]

countApplesAndOranges(s, t, a, b, apples, oranges)