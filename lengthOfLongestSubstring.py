def lengthOfLongestSubstring(s: str) -> int:
    length = len(s)
    if length <= 1:
        return length
    slow = 0
    fast = 1
    longest = 0

    while fast < length:
        if s[fast] in s[slow:fast]:
            longest = max(longest, fast - slow)
            slow += 1
            if slow == fast:
                fast += 1
        else:
            fast += 1
    else:
        longest = max(longest, fast - slow)
    return longest

def test_func():
    assert lengthOfLongestSubstring("abcabcbb") == 3
    assert lengthOfLongestSubstring("bbbbb") == 1
    assert lengthOfLongestSubstring("pwwkew") == 3
