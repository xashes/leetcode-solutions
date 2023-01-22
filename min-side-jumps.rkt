#lang racket

(module+ test
  (require rackunit))

;; check remain obstacles list
;; if null? or (no obstacles on this track) return jump-count
;; find remain list for current track

(define/contract (min-side-jumps obstacles)
  (-> (listof exact-integer?) exact-integer?)
  (define len (length obstacles))
  (let loop ([track 2]
             [pos 0]
             [jump-count 0])
    (define (no-obstacles-in-track-future?)
      (not (member track obstacles))
      )
    (define (obstacle-next?)
      (= track (list-ref obstacles (add1 pos)))
      )
    (define (proper-track)
      (let ([remain (drop obstacles pos)])
        (car
         (argmin cdr
                 (map (lambda (t) (cons t
                                        (let ([remain-lst (member t remain)]
                                              )
                                          (if remain-lst
                                              (length remain-lst)
                                              0)
                                          ))) '(1 2 3))))))
    (cond
      [(= pos (sub1 len)) jump-count]
      [(no-obstacles-in-track-future?) jump-count]
      [(obstacle-next?) (loop (proper-track) pos (add1 jump-count))]
      [else (loop track (add1 pos) jump-count)]
      )
    ))

(module+ test
  (check-equal? (min-side-jumps '(0 1 2 3 0)) 2)
  (check-equal? (min-side-jumps '(0 1 1 3 3 0)) 0)
  (check-equal? (min-side-jumps '(0 2 1 0 3 0)) 2)
  )
