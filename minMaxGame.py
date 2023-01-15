#!/usr/bin/env python3

from typing import List

def minMaxGame(nums: List[int]) -> int:
    while len(nums) > 1:
        n = len(nums)
        for i in range(n//2):
            if i % 2 == 0:
                nums[i] = min(nums[2*i], nums[2*i + 1])
            else:
                nums[i] = max(nums[2*i], nums[2*i + 1])
        nums = nums[:n//2]

    return nums[0]

print(minMaxGame([8, 3, 5, 2, 4, 8, 2, 2]))
