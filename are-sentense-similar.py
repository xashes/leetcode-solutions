from collections import deque

def areSentencesSimilar(sentence1: str, sentence2: str) -> bool:
    # 分别加入队列
    # 从两端把相同的元素弹出
    # 如果有一个为空则为真
    d1 = deque(sentence1.split())
    d2 = deque(sentence2.split())
    while d1 and d2:
        if d1[0] == d2[0]:
            d1.popleft()
            d2.popleft()
        elif d1[-1] == d2[-1]:
            d1.pop()
            d2.pop()
        else:
            return False
    else:
        return True

def test_asts():
    assert areSentencesSimilar("a b c", "a c") is True
