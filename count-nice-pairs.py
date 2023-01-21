from typing import List
import math

def countNicePairs(nums: List[int]) -> int:
    reverse_diff = map(lambda x: x - reverse_num(x), nums)
    h = {}
    for n in reverse_diff:
        if n in h:
            h[n] += 1
        else:
            h[n] = 1
    combs = map(lambda x: math.comb(x, 2), h.values())
    return sum(combs)

def reverse_num(num: int) -> int:
    return int(str(num)[::-1])

def test_func():
    assert reverse_num(876) == 678
    assert countNicePairs([42, 11, 1, 97]) == 2
