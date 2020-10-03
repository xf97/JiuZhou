# -*- coding=utf-8 -*-

import operator
import suffix_expression

class Node:
    """
    二叉树的结点
    """
    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None

def generate_binary_tree(exp):
    """
    生成二叉树
    """
    tree_stack = []
    for item in exp:
        #print(item)
        parent = Node(item)
        if not item in  ['+', '-', 'x', '÷']:
            #操作数
            tree_stack.append(parent)
        else:
            #运算符
            right = tree_stack.pop()
            left = tree_stack.pop()
            parent.right = right
            parent.left = left
            tree_stack.append(parent)
    #二叉树的根
    parent = tree_stack[-1]
    return parent

def tree_is_same(root):
    """
    判断二叉树是否相同
    """
    if not root.left:
        if not root.right:
            return root.value
    elif root.value == '+' or root.value == 'x':
        left = tree_is_same(root.left)
        right = tree_is_same(root.right)
        if operator.le(left, right):
            #print(root.value + left + right)
            return root.value + left + right
        else:
            return root.value + right + left
    else:
        return root.value + tree_is_same(root.left) + tree_is_same(root.right) 

if __name__ == '__main__':
    exp1 = '3 + ( 2 ÷ 1 )'
    exp2 = '1 + 2 + 3'
    re1 = suffix_expression.to_suffix(exp1)
    re2 = suffix_expression.to_suffix(exp2)
    print(re1)
    print(re2)
    res1 = generate_binary_tree(re1)
    res2 = generate_binary_tree(re2)
    r1 = tree_is_same(res1) 
    r2 = tree_is_same(res2)
    print(r1)
    print(r2)
    if r1 == r2:
        print("12")