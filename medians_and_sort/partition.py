from random import randint


def simple_partition(arr, p, r):
    x = arr[r]
    i = p - 1
    for j in range(p, r):
        if arr[j] <= x:
            i += 1
            arr[i], arr[j] = arr[j], arr[i]

    arr[i+1], arr[r] = arr[r], arr[i+1]
    return i + 1


def randomized_partition(arr, p, r):
    i = randint(p, r)
    arr[r], arr[i] = arr[i], arr[r]
    return simple_partition(arr, p, r)
