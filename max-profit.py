#!/usr/bin/env python3

def max_profit(lst):
    return sum(filter(lambda n: n > 0, map(lambda x, y: x - y, lst[1:], lst[:-1])))
