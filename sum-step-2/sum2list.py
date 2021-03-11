def sum_step_2(lst) -> list:
    if len(lst) == 2:
        return lst

    x = lst[0]
    xs = sum_step_2(lst[1:])

    return [max(x, xs[0], x + xs[1]), max(xs[0], xs[1])]


def sum2list(lst) -> int:
    if lst is None or len(lst) == 0:
        raise Exception("Empty list!")

    if len(lst) == 1:
        return lst[0]

    if len(lst) == 2:
        return max(lst)

    return max(sum_step_2(lst))


test_list = [4, 8, 3, -9, 5]  # 13
test_list2 = [5, 20, 15, -2, 18]  # 38
test_list3 = [4, 1, 6, 3, 2]  # 12
test_list4 = [0, 0, 0, 0, 0]  # 0
test_list5 = [0, 0, -1, 0, 0]  # 0
test_list6 = [-3, -2, -1, -2, -3]  # -1
test_list7 = [5, 5, 10, 100, 10, 5]  # 110
test_list8 = [-5, 5, 10, -100, 10, 5]  # 20
test_list9 = [100, 8, 10, 20, 7]  # 120
test_list10 = [1, -2, -3, 100]  # 101
test_list11 = [3, 2, 5, 10, 7]  # 15
test_list12 = [1, 8, 8, 8, 1]  # 16
test_list13 = [4, 8, 8, 8, 5]  # 17

print(sum2list(test_list))
print(sum2list(test_list2))
print(sum2list(test_list3))
print(sum2list(test_list4))
print(sum2list(test_list5))
print(sum2list(test_list6))
print(sum2list(test_list7))
print(sum2list(test_list8))
print(sum2list(test_list9))
print(sum2list(test_list10))
print(sum2list(test_list11))
print(sum2list(test_list12))
print(sum2list(test_list13))
