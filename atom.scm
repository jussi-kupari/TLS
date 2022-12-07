#lang racket

(provide atom?)

(module+ test
  (require rackunit))

;; atom? : Any -> Boolean
;; Produces true if input is an atom
(define atom? 
  (λ (x) 
    (and (not (pair? x)) (not (null? x)))))

(module+ test
  (check-true (atom? 'atom))
  (check-true (atom? 123))
  (check-false (atom? '()))
  (check-false (atom? '(this is not an atom)))
  (check-false (atom? '(123))))