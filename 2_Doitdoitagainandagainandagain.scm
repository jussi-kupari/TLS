#lang racket

;; atom? : Any -> Boolean
;; Produces #true if input is an atom
(define atom? 
  (λ (x) 
    (and (not (pair? x)) (not (null? x)))))



#|     Do It, Do it Again, and Again, and Again...     |#



#| Q: True or false: (lat? l) where l is (Jack Sprat could eat no chicken fat) |#
#| A: True, b/c (Jack Sprat could eat no chicken fat) is a list of only atoms |#

#| Q: True or false: (lat ? l) where l is ((Jack) Sprat could eat no chicken fat) |#
#| A: False, b/c the first element in ((Jack) Sprat could eat no chicken fat) is the list (Jack) |#

#| Q: True or false: (lat? l) where l is (Jack (Sprat could) eat no chicken fat) |#
#| A: False, b/c (Jack (Sprat could) eat no chicken fat) contains the list (Sprat could) |#

#| Q: True or false: (lat ? l) where l is () |#
#| A: True, b/c l does not contain any number of lists |#
; Note: It is not entirely obvious to me why an empty list is considered a list of atoms.

#| Q: True or false: a lat is a list of atoms. |#
#| A: True |#
; Note: An empty or null list is also a list of atoms

#| Q: Write the function lat? using some, but not necessarily all, of the following functions: 
      car cdr cons null? atom? and eq? |#
#| A: From the book:
      "You were not expected to be able to do this 
      yet, because you are still missing some 
      ingredients. Go on to the next question. 
      Good luck."

      Below is my attempt, called list-of-atoms?, using some techniques not introduced yet. |#

;; list-of-atoms? : List-of-Anything -> Boolean
;; Given list, produces true if it only contains atoms
(define (list-of-atoms? l)
  (cond
    [(null? l) true]
    [else (if (atom? (car l))
              (list-of-atoms? (cdr l))
              false)]))

(list-of-atoms? '(Jack Sprat could eat no chicken fat)) ; ==> #t
(list-of-atoms? '((Jack) Sprat could eat no chicken fat)) ; ==> #f
(list-of-atoms? '(Jack (Sprat could) eat no chicken fat)) ; ==> #f
(list-of-atoms? '()) ; ==> #t

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#
