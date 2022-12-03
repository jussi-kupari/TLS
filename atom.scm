#lang racket

(provide atom?)

;; atom? : Any -> Boolean
;; Produces true if input is an atom
(define atom? 
  (λ (x) 
    (and (not (pair? x)) (not (null? x)))))