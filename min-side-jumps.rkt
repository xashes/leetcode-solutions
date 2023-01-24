#lang racket

(module+ test
  (require rackunit))

;; check remain obstacles list
;; if null? or (no obstacles on this track) return jump-count
;; find remain list for current track

(define/contract (min-side-jumps obstacles)
  (-> (listof exact-integer?) exact-integer?)
  (define tracks '(1 2 3))
  (let loop ([track 2]
             [remain-lst obstacles]
             [jump-count 0]
             )
    (define (find-obstacle track)
      (index-of remain-lst track)
      )
    (cond
      [(null? remain-lst) jump-count]
      [else (let ([obstacle-pos (find-obstacle track)])
              (if (not obstacle-pos)
                  jump-count
                  (let ([remain (drop remain-lst (sub1 obstacle-pos))])
                    (define (target-track)
                      (define-values (x y) (apply values (remove track tracks)))
                      (cond
                        [(equal? (car remain) x) y]
                        [(equal? (car remain) y) x]
                        [else (let ([x-idx (index-of remain x)])
                                (if (not x-idx)
                                    (begin (set! remain null)
                                           x)
                                    (let ([y-idx (index-of remain y)])
                                      (if (not y-idx)
                                          (begin (set! remain null)
                                                 y)
                                          (if (> x-idx y-idx)
                                              x
                                              y)))))]))
                    (let ([t (target-track)])
                      (loop t remain (add1 jump-count))))
                  )
              )]))
  )

(module+ test
  (check-equal? (min-side-jumps '(0 1 2 3 0)) 2)
  (check-equal? (min-side-jumps '(0 1 1 3 3 0)) 0)
  (check-equal? (min-side-jumps '(0 2 1 0 3 0)) 2)
  (check-equal? (min-side-jumps '(0 0 3 1 0 1 0 2 3 1 0)) 2)
  )
