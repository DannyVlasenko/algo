def sort_subarray(arr, p, r, part_func):
    if p < r:
        q = part_func(arr, p, r)
        sort_subarray(arr, p, q-1, part_func)
        sort_subarray(arr, q+1, r, part_func)


def sort(arr, part_func):
    sort_subarray(arr, 0, len(arr)-1, part_func)



