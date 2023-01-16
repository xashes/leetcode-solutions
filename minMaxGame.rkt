#lang racket

(module+ test
  (require rackunit))

(define/contract (min-max-game nums)
  (-> (listof exact-integer?) exact-integer?)
  (let ([n (length nums)])
    (if (= n 1)
        (car nums)
        (min-max-game
         (for/list ([i (in-range (quotient n 2))])
           (if (even? i)
               (min (list-ref nums (* 2 i))
                    (list-ref nums (+ (* 2 i) 1)))
               (max (list-ref nums (* 2 i))
                    (list-ref nums (+ (* 2 i) 1)))
               )
           )))))

(define (min-max-game-v2 nums)
  (if (null? (cdr nums))
      (car nums)
      (min-max-game-v2 (min-max-map nums))
      )
  )
(define (min-max-map lst)
  (let loop ([count 0]
             [l lst])
    (if (null? l)
        null
        (cons (if (even? count)
                  (min (car l) (cadr l))
                  (max (car l) (cadr l))
                  )
              (loop (add1 count) (cddr l))))))

(module+ test
  (check-equal? (min-max-game '(1 3 5 2 4 8 2 2))
                1)
  (check-equal? (min-max-game '(3 3 5 2 4 8 2 2))
                3)
  (check-equal? (min-max-game-v2 '(1 3 5 2 4 8 2 2))
                1)
  (check-equal? (min-max-game-v2 '(3 3 5 2 4 8 2 2))
                3)
  )
