#lang racket

;; atom? : Any -> Boolean
;; Given anything, produces true if it is an atom
(define atom? 
  (λ (x) 
    (and (not (pair? x)) (not (null? x)))))