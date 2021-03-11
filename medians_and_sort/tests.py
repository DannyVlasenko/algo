import quick_sort
import quick_select
import timeit
from partition import simple_partition
from partition import randomized_partition
from random import randint


def random_array(length, min=-100, max=100):
    array = list()
    for _ in range(length):
        array.append(randint(min, max))
    return array


#select_arr = random_array(30, -100, 100)
select_arr = [1, 2, 3]
print(select_arr)
median = quick_select.select(select_arr, len(select_arr)//2+1, simple_partition)
if len(select_arr) % 2 == 0:
    median2 = quick_select.select(select_arr, len(select_arr) // 2, simple_partition)
    median = (median + median2) / 2

print(select_arr)
quick_sort.sort(select_arr, randomized_partition)
print(select_arr)
print(median)

#arr = random_array(500)
#arr2 = arr.copy()
#print(timeit.timeit(lambda: quick_sort.sort(arr, simple_partition), number=100))
#print(timeit.timeit(lambda: quick_sort.sort(arr2, randomized_partition), number=100))

