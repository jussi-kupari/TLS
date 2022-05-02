#lang racket

(provide (all-defined-out))

;; atom? : Any -> Boolean
;; Produces true if input is an atom
(define atom? 
  (λ (x) 
    (and (not (pair? x)) (not (null? x)))))