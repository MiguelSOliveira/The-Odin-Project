def merge(left, right)
  i, j = 0, 0
  sorted = []

  while i < left.size && j < right.size
    if left[i] <= right[j]
      sorted << left[i]
      i += 1
    elsif right[j] <= left[i]
      sorted << right[j]
      j += 1
    end
  end

  sorted += left[i..-1]
  sorted += right[j..-1]
  return sorted
end

def mergesort(unsorted)
  return unsorted if unsorted.size <= 1

  size = (unsorted.size / 2).to_i
  right = mergesort(unsorted[size..-1])
  left = mergesort(unsorted[0...size])

  return merge(left, right)
end
p mergesort([9,9,8,8,7,8,7,6,5,4,3,2,1])
