#lang racket

(module+ test
  (require rackunit))

(define (count-nice-pairs nums)
  (remainder
   (let loop ([difflst (map reverse-diff nums)])
     (if (null? difflst)
         0
         (+ (count-eq-on (car difflst) (cdr difflst))
            (loop (cdr difflst)))
         ))
   (+ (expt 10 9) 7)
   ))

(define (count-eq-on n lon)
  (if (null? lon)
      0
      (if (equal? n (car lon))
          (add1 (count-eq-on n (cdr lon)))
          (count-eq-on n (cdr lon))))
  )

(define (reverse-number num)
  (string->number
   (list->string
    (reverse
     (string->list
      (number->string num)))))
  )
(define (reverse-diff n)
  (- n (reverse-number n))
  )

(module+ test
  (check-equal? (count-nice-pairs '(42 11 1 97)) 2)
  (check-equal? (count-nice-pairs '(13 10 35 24 76)) 4)
  )

(module+ test
  (check-equal? (reverse-number 123) 321)
  (check-equal? (reverse-number 987) 789)
  )
