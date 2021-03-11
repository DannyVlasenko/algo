def median(nums1, nums2) -> float:
    total_len = len(nums1) + len(nums2)
    middle = total_len // 2
    even = not bool(total_len % 2)

    if nums1[0] <= nums2[0]:
        med = helper(nums1, nums2, middle, even)
    else:
        med = helper(nums2, nums1, middle, even)

    return med


def helper(smaller, bigger, middle, even, counter=0):
    if counter + 1 != middle:

        smaller = smaller[1:]

        if len(smaller) == 0:
            return rest(bigger, middle, even, counter + 1)
        if len(bigger) == 0:
            return rest(smaller, middle, even, counter + 1)

        if smaller[0] <= bigger[0]:
            return helper(smaller, bigger, middle, even, counter + 1)
        else:
            return helper(bigger, smaller, middle, even, counter + 1)

    if smaller[1] <= bigger[0]:
        if even:
            med = (smaller[1] + min(smaller[2], bigger[0])) / 2
        else:
            med = smaller[1]
    else:
        if even:
            med = (bigger[0] + min(smaller[1], bigger[1])) / 2
        else:
            med = bigger[0]

    return med


def rest(arr, middle, even, counter):
    if counter + 1 != middle:
        return rest(arr[1:], middle, even, counter + 1)

    if even:
        return (arr[0] + arr[1]) / 2
    else:
        return arr[0]


ar11 = [-5, 3, 6, 12, 15]
ar12 = [-12, -10, -6, -3, 4, 10]
expected1 = 3

ar21 = [2, 3, 5, 8]
ar22 = [10, 12, 14, 16, 18, 20]
expected2 = 11

ar31 = [1, 3]
ar32 = [2]
expected3 = 2

ar41 = [1, 2]
ar42 = [3, 4]
expected4 = 2.5

ar51 = [0, 0]
ar52 = [0, 0]
expected5 = 0

ar61 = []
ar62 = [1]
expected6 = 1

ar71 = [2]
ar72 = []
expected7 = 2

print(f"case 1 got {median(ar11, ar12)} expected {expected1}")
print(f"case 2 got {median(ar21, ar22)} expected {expected2}")
print(f"case 3 got {median(ar31, ar32)} expected {expected3}")
print(f"case 4 got {median(ar41, ar42)} expected {expected4}")
print(f"case 5 got {median(ar51, ar52)} expected {expected5}")
print(f"case 6 got {median(ar61, ar62)} expected {expected6}")
print(f"case 7 got {median(ar71, ar72)} expected {expected7}")
