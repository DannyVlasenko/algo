class Node:

    def __init__(self, val, l=None, r=None):
        self.value = val
        self.left = l
        self.right = r


def get_grandchildren(node):
    if node.left is None:
        left = None, None
    else:
        left = node.left.left, node.left.right

    if node.right is None:
        right = None, None
    else:
        right = node.right.left, node.right.right

    return left, right


def node_val_or_none(node):
    if node is not None:
        return node.value

    return None


def sum_or_none(val, node):
    if val is None:
        return node_val_or_none(node)

    return val + (node_val_or_none(node) or 0)


def bind(val, func):
    if val is not None:
        return func(val)

    return None


def is_leaf(node):
    return (node.left is None) and (node.right is None)


def has_grandchildren(node):
    return node.left is not None and not is_leaf(node.left) or node.right is not None and not is_leaf(node.right)


def sum_grand(node):
    if (node.left is None) or is_leaf(node.left):
        # use right
        left = (bind(node.right.left, sum2tree) or 0)
        right = (bind(node.right.right, sum2tree) or 0)
        return max(left, right, left + right)
    else:
        if (node.right is None) or is_leaf(node.right):
            # use left
            left = (bind(node.left.left, sum2tree) or 0)
            right = (bind(node.left.right, sum2tree) or 0)
            return max(left, right, left + right)
        else:
            # use both
            left_left = (bind(node.left.left, sum2tree) or 0)
            left_right = (bind(node.left.right, sum2tree) or 0)
            right_left = (bind(node.right.left, sum2tree) or 0)
            right_right = (bind(node.right.right, sum2tree) or 0)
            max_left = max(left_left, left_right, left_left + left_right)
            max_right = max(right_left, right_right, right_left + right_right)
            return max(max_left, max_right, max_left + max_right)


def sum2tree(node):
    if node is None:
        raise Exception("Empty tree!")

    if is_leaf(node):
        return node.value

    if node.left is None:
        excl = sum2tree(node.right)
    else:
        if node.right is None:
            excl = sum2tree(node.left)
        else:
            excl = max(sum2tree(node.left), sum2tree(node.right), sum2tree(node.left) + sum2tree(node.right))

    if has_grandchildren(node):
        incl = max(node.value, sum_grand(node), node.value + sum_grand(node))
        return max(excl, incl)
    else:
        return max(node.value, excl)


def create_tree():
    return Node(-2,
                Node(-2,
                     Node(-7,
                          Node(-20),
                          Node(-1)
                          ),
                     Node(-9,
                          Node(-5,
                               Node(-3),
                               Node(-2,
                                    None,
                                    Node(-12))
                               ),
                          Node(-3)
                          )
                     ),
                Node(-3,
                     Node(-1,
                          Node(-15),
                          )
                     )
                )


tree = create_tree()
print(sum2tree(tree))
