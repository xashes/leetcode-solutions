#lang racket

(module+ test
  (require rackunit))

(define/contract (two-sum nums target)
  (-> (listof exact-integer?) exact-integer? (listof exact-integer?))
  (define h (make-hash))
  (let loop ((lon nums)
             (idx 0))
    (if (null? lon)
        null
        (let* ((diff (- target (car lon)))
               (diffidx (hash-ref h diff #f)))
          (if diffidx
              (list diffidx idx)
              (begin (hash-set! h (car lon) idx)
                     (loop (cdr lon) (add1 idx)))
              ))))
  )
(module+ test
  (check-equal? (two-sum '(1 2 3 4) 5) '(1 2))
  )
