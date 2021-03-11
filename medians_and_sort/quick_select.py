
def select_sub_array(arr, p, r, i, part_func):
    if p == r:
        return arr[p]
    q = part_func(arr, p, r)
    k = q - p + 1
    if i == k:
        return arr[q]
    elif i < k:
        return select_sub_array(arr, p, q-1, i, part_func)
    else:
        return select_sub_array(arr, q+1, r, i-k, part_func)


def select(arr, i, part_func):
    if len(arr) == 0:
        return 0

    return select_sub_array(arr, 0, len(arr)-1, i, part_func)


