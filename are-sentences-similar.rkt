#lang racket

(module+ test
  (require rackunit))

(define/contract (are-sentences-similar sentence1 sentence2)
  (-> string? string? boolean?)
  (define 1>2? (> (string-length sentence1) (string-length sentence2)))
  (define longlst (string-split (if 1>2? sentence1 sentence2)))
  (define shortlst (string-split (if 1>2? sentence2 sentence1)))

  (let-values ([(l1 l2) (drop-prefix longlst shortlst)])
    (if (null? l2)
        true
        (let-values ([(_ nl2) (drop-prefix (reverse l1) (reverse l2))])
          (if (null? nl2)
              true
              false
              )))
    ))

(define (drop-prefix longlist shortlist)
  (if (null? shortlist)
      (values longlist null)
      (let ([c1 (car longlist)]
            [c2 (car shortlist)])
        (if (equal? c1 c2)
            (drop-prefix (cdr longlist) (cdr shortlist))
            (values longlist shortlist)
            )
        )))

(module+ test
  (check-true (are-sentences-similar "My name is Haley" "My Haley"))
  (check-false (are-sentences-similar "of" "A lot of words"))
  (check-true (are-sentences-similar "Eating right now" "Eating"))
  (check-true (are-sentences-similar "d T d ED uXW L U J n klIe" "d T d ED uXW L U J klIe"))
  (check-false (are-sentences-similar "Luky" "Lucccky"))
  )
