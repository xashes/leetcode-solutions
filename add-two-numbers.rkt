#lang racket

(module+ test
  (require rackunit))

(define/contract (add-two-numbers l1 l2)
  (-> list? list? list?)
  (cond
    [(null? l1) l2]
    [(null? l2) l1]
    [else (let ([car-sum (+ (car l1) (car l2))])
            (let-values ([(q r) (quotient/remainder car-sum 10)])
              (cons r
                    (if (zero? q)
                        (add-two-numbers (cdr l1)
                                         (cdr l2))
                        (add-two-numbers
                         (add-two-numbers (cons q null)
                                          (cdr l1))
                         (cdr l2))))))]))
(module+ test
  (check-equal? (add-two-numbers '(2 4 3)
                                  '(5 6 4))
                '(7 0 8))
  (check-equal? (add-two-numbers '(0) '(0))
                '(0))
  (check-equal? (add-two-numbers '(9 9 9 9 9 9 9)
                                  '(9 9 9 9 ))
                '(8 9 9 9 0 0 0 1))
  )
