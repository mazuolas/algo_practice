# 1,1,2,2,3,3,4
def single_in_sorted(arr)
  mid = arr.length/2
  if arr[mid] == arr[mid+1]
    p 1
    single_in_sorted(arr.take(mid))
  elsif arr[mid] == arr[mid-1]-
    single_in_sorted(arr.drop(mid+1)) + mid
    p 2
  else
    mid
  end
end

p single_in_sorted([1,1,2,2,3,3,4])
p single_in_sorted([1,2,2,3,3,4,4])
