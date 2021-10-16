# binary search tree

# arguments: constructor array (defaults to empty array), collector array, N
# break clause: if total of array elements equals N, return constructor
# call the method with the current array, with 1 added
  # if truthy, push to collector
# if total of array elements does not equal N - 1:
  # call the method with the current array, with 2 added
    # if truthy, push to collector
# return collector

def climb_stairs(n, constructor = [], collector = [])
  return (collector << constructor) if constructor.sum == n
  collector += climb_stairs(n, constructor + [1])
  if constructor.sum != n - 1
    collector += climb_stairs(n, constructor + [2])
  end
  collector
end

result = climb_stairs(6)
p result
p result.count
