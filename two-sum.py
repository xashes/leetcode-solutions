#!/usr/bin/env python3

from typing import List

def twoSum(nums: List[int], target: int) -> List[int]:
    d = {}
    for idx, value in enumerate(nums):
        if (target - value) in d:
            return [idx, d[value]]
        else:
            d[value] = idx
    return []
