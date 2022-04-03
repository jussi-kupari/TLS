#lang racket

;; atom? : Any -> Boolean
;; Produces #true if input is an atom
(define atom? 
  (λ (x) 
    (and (not (pair? x)) (not (null? x)))))

;; lat? : List-of-Anything -> Boolean
;; Given list, produces true if it only contains atoms
(define lat? 
  (λ (l) 
    (cond 
      ((null? l) #t) 
      ((atom? (car l)) (lat? (cdr l))) 
      (else #f)))) 



#|              *Oh My Gawd*: It's Full of Stars               |#



#| Q: What is (rember* a l) where a is cup and l is ((coffee) cup ((tea) cup) (and (hick)) cup) 
      note: "rember*" is pronounced "rember-star." |#
#| A: ((coffee) ((tea)) (and (hick))). |#

#| Q: What is (rember* a l) where a is sauce and l is (((tomato sauce)) ((bean) sauce) (and ((flying)) sauce)) |#
#| A: (((tomato)) ((bean)) (and ((flying)))) |#

#| Q: Now write rember* 
      Here is the skeleton:
(define rember*
  (λ (a l)
    (cond
      ((...) ...)
      ((...) ...)
      ((...) ...)))) |#

#| A: Ok. |#

;; rember* : Atom List -> List
;; Given atom and a list, removes all occurrences of the atom from the list
(define rember*
  (λ (a l)
    (cond
      ((null? l) '()) ; empty list just returns empty
      ((atom? (car l))
       (cond
         ((eq? (car l) a)
          (rember* a (cdr l))) ; remove matching atom from list
         (else
          (cons (car l)
                (rember* a (cdr l)))))) ; keep unmatching atom in list
      (else (cons (rember* a (car l)) ; cons result of *rember on (car l) ... 
                  (rember* a (cdr l))))))) ; ... on the result of *rember on (cdr l)

(rember* 'cup '((coffee) cup ((tea) cup) (and (hick)) cup))
; ==> ((coffee) ((tea)) (and (hick)))
(rember* 'sauce '(((tomato sauce)) ((bean) sauce) (and ((flying)) sauce)))
;==> '(((tomato)) ((bean)) (and ((flying))))

#| Book version of rember* is identical to mine. |#

#| Using arguments from one of our previous examples, follow through this to see how it 
   works. Notice that now we are recurring down the car of the list, instead of just the 
   cdr of the list. |#

#| Q: (lat ? l) where l is (((tomato sauce)) ((bean) sauce) (and ((flying)) sauce)) |#
#| A: False. |#
(lat? '(((tomato sauce)) ((bean) sauce) (and ((flying)) sauce))) ; ==> #f

#| Q: Is (car l) an atom where l is (((tomato sauce)) ((bean) sauce) (and ((flying)) sauce)) |#
#| A: No it is not. |#
(atom? (car '(((tomato sauce)) ((bean) sauce) (and ((flying)) sauce)))) ; ==> #f

#| Q: What is (insertR* new old l) where new is roast old is chuck and 
      l is ((how much (wood)) could ((a (wood) chuck)) (((chuck))) (if (a) ((wood chuck))) could chuck wood) |#
#| A:
'((how much (wood))
  could
  ((a (wood) chuck roast))
  (((chuck roast)))
  (if (a) ((wood chuck roast)))
  could chuck roast wood) |#

#| Q: Now write the function insertR* which inserts the atom new to the right of old 
      regardless of where old occurs.
(define insertR*
  (λ (new old l)
    (cond
      ((...) ...)
      ((...) ...)
      ((...) ...)))) |#

#| A: Ok. |#

;; insertR* : Atom Atom List -> List
;; Given two atoms and a list, inserts the first atom on the right of any occurrecne of the second atom
(define insertR*
  (λ (new old l)
    (cond
      ((null? l) '())
      ((atom? (car l))
       (cond
         ((eq? (car l) old)
          (cons old
                (cons new
                      (insertR* new old
                                (cdr l)))))
         (else (cons (car l)
                     (insertR* new old
                               (cdr l))))))
      (else
       (cons (insertR* new old
                       (car l))
             (insertR* new old
                       (cdr l)))))))

(insertR* 'roast 'chuck
          '((how much (wood)) could ((a (wood) chuck)) (((chuck))) (if (a) ((wood chuck))) could chuck wood))
#| ==> '((how much (wood))
          could
          ((a (wood) chuck roast))
          (((chuck roast)))
          (if (a) ((wood chuck roast)))
          could chuck roast wood) |#

#| Book version of insertR* is identical to mine. |#

#| Q: How are insertR* and rember* similar? |#
#| A: Each function asks three questions.  |#

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

#| Q: |#
#| A: |#


