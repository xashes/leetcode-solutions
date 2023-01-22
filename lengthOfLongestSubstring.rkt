#lang racket

(module+ test
  (require rackunit))

(define/contract (length-of-longest-substring s)
  (-> string? exact-integer?)
  (let ([len (string-length s)])
    (if (< len 2)
        len
        (let loop ([slow 0]
                   [fast 1]
                   [maxlength 0])
          (cond
            [(>= fast len) (max maxlength (- fast slow))]
            ;; 用什么数据结构进行成员比较效率更高，是细节问题
            ;; 这里可以用一个抽象的成员比较函数，在有性能需求时，改为需要的数据结构
            [(string-contains? (substring s slow fast) (~a (string-ref s fast)))
             (loop (add1 slow) (max (add1 slow) fast) (max maxlength (- fast slow)))]
            [else (loop slow (add1 fast) maxlength)]
            )
          )))

  )

(module+ test
  (check-equal? (length-of-longest-substring "abcabcbb") 3)
  (check-equal? (length-of-longest-substring "bbbbb") 1)
  (check-equal? (length-of-longest-substring "pwwkew") 3)
  )
