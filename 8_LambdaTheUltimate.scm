#lang racket

(provide (all-defined-out))

(require "Atom.scm"
         "1_Toys.scm"
         "2_Doitdoitagainandagainandagain.scm"
         "3_ConsTheMagnificent.scm"
         "4_NumbersGames.scm"
         "5_OhMyGawdItsFullOfStars.scm"
         "6_Shadows.scm"
         "7_FriendsAndRelations.scm")



#|                    Lambda the Ultimate                    |#


                                                                
#| Q: Remember what we did in rember and inserlL at the end of chapter 5? |#
#| A: We replaced eq? with equal? |#

#| Q: Can you write a function rember-f that would use either eq? or equal? |#
#| A: No, because we have not yet told you how. |#

#| Q: How can you make rember remove the first a from (b c a) |#
#| A: By passing a and (b c a) as arguments to rember. |#

#| Q: How can you make rember remove the first c from (b c a) |#
#| A: By passing c and (b c a) as arguments to rember. |#

#| Q: How can you make rember-f use equal? instead of eq? |#
#| A: By passing equal? as an argument to rember-f. |#

#| Q: What is (rember-f test? a l) where
     test? is = 
     a is 5 and 
     l is (6 2 5 3) |#

#| A: (6 2 3). |#

#| Q: What is (rember-f test? a l) where test? is eq? a is jelly and
      l is (jelly beans are good) |#
#| A: (beans are good). |#

#| Q: What is (rember-f test? a l) where test? is equal? a is (pop corn) and
      l is (lemonade (pop corn) and (cake)) |#
#| A: (lemonade and (cake)). |#

#| Q: Try to write rember-f |#
#| A: Ok. |#

;; rember-f : Sexp Predicate List -> List
;; Given sexp, function and list, produces a list with the sexp removed

(define rember-f.v1
  (λ (test? a l)
    (cond
      ((null? l) '())
      ((test? (car l) a)
       (rember-f.v1 test? a (cdr l)))
      (else
       (cons (car l)
             (rember-f.v1 test? a (cdr l)))))))

(rember-f.v1 = 5 '(6 2 5 3)) ; ==> '(6 2 3)
(rember-f.v1 eq? 'jelly '(jelly beans are good)) ; ==> '(beans are good)
(rember-f.v1 equal? '(pop corn) '(lemonade (pop corn) and (cake))) ; ==> '(lemonade and (cake))

; The first book solution is more verbose as using the extra cond structure.

(define rember-f.v2 
  (λ (test? a l) 
    (cond 
      ((null? l) '()) 
      (else (cond 
              ((test? (car l) a) (cdr l)) 
              (else (cons (car l) 
                          (rember-f.v2 test? a 
                                       (cdr l)))))))))

(rember-f.v2 = 5 '(6 2 5 3)) ; ==> '(6 2 3)
(rember-f.v2 eq? 'jelly '(jelly beans are good)) ; ==> '(beans are good)
(rember-f.v2 equal? '(pop corn) '(lemonade (pop corn) and (cake))) ; ==> '(lemonade and (cake))

; This is good! 

#| Q: What about the short version? |#
#| A: Note: Looks like my version above but returns (cdr l) after first match. |#

(define rember-f.v3
  (λ (test? a l)
    (cond
      ((null? l) '())
      ((test? (car l) a) (cdr l))
      (else
       (cons (car l)
             (rember-f.v3 test? a
                          (cdr l)))))))

(rember-f.v3 = 5 '(6 2 5 3)) ; ==> '(6 2 3)
(rember-f.v3 eq? 'jelly '(jelly beans are good)) ; ==> '(beans are good)
(rember-f.v3 equal? '(pop corn) '(lemonade (pop corn) and (cake))) ; ==> '(lemonade and (cake))

#| Q: How does (rember-f test? a l) act where test? is eq? |#
#| A: (rember-f test? a l) where test? is eq?, acts like rember. |#

#| Q: And what about (rember-f test? a l) where test? is equal? |#
#| A: This is just rember with eq? replaced by equal?. |#

#| Q: Now we have four functions that do almost the same thing. |#
#| A:
      Yes: 
       rember with = 
       rember with equal? 
       rember with eq? 
       and 
       rember-f. |#

#| Q: And rember-f can behave like all the others. |#
#| A: Let's generate all versions with rember-f . |#

#| Q: What kind of values can functions return? |#
#| A: Lists and atoms. |#

#| Q: What about functions themselves? |#
#| A: Yes, but you probably did not know that yet. |#

#| Q: Can you say what (λ (a l) ...) is? |#
#| A: (lambda (a l) ...) is a function of two arguments, a and l. |#



#| Q: Now what is
 
(λ (a) 
  (λ (x) 
    (eq? x a))) |#

#| A: It is a function that, when passed an argument a, returns the function 
     (λ (x) (eq? x a)) where a is just that argument. |#

#| Q: Is this called "Curry-ing?" |#
#| A: Thank you, Moses Schönfinkel (1889-1942). |#

#| Q: It is not called "Schönfinkel-ing." |#
#| A: Thank you, Haskell B. Curry (1900-1982). |#

#| Q: Using (define ...) give the preceding function a name. |#
#| A: This is our choice. |#

;; eq?-c : Sexp -> Predicate
;; Given sexp, produces a predicate to check similarity against that sexp
(define eq?-c
  (λ (a)
    (λ (x)
      (eq? x a))))

#| Q: What is (eq?-c k) where k is salad |#
#| A: Its value is a function that takes x as an argument and
      tests whether it is eq? to salad. |#

#| Q: So let's give it a name using (define ...) |#
#| A: Okay. |#

;(define eq?-salad (eq?-c k)), where k is salad

(define eq?-salad (eq?-c 'salad))

#| Q: What is (eq?-salad y) where y is salad |#
#| A: #t. |#

(eq?-salad 'salad) ; ==> #t

#| Q: What is (eq?-salad y) where y is tuna |#
#| A: #f. |#

(eq?-salad 'tuna) ; ==> #f

#| Q: Do we need to give a name to eq?-salad |#
#| A: No, we may just as well ask
       ((eq?-c x) y)
      where
       x is salad
      and 
       y is tuna. |#

#| Q: Now rewrite rember-f as a function of one argument test?
      that returns an argument like rember with eq? replaced by test? |#

#| A: 
;; rember-f : Predicate -> Function
;; Given a predicate, produces a function that removes elements from a list.
(define rember-f
  (λ (test?)
    (λ (a l)
      (cond
        ((null? l) '())
        ((test? (car l) a) (cdr l))
        (else
         (cons (car l) ...)))))) 

         is a good start |#
 
#| Q: Describe in your own words the result of (rember-f test ?) where test? is eq? |#
#| A: It is a function that takes two arguments, a and l. It compares the elements of the list 
      with a, and the first one that is eq? to a is removed. |#

#| Q: Give a name to the function returned by (rember-f test?) where test? is eq? |#
#| A: (define rember-eq ? (rember-f test?)) where test? is eq?. |#

#| Q: What is (rember-eq? a l) where a is tuna and l is (tuna salad is good) |#
#| A: (salad is good). |#

#| Q: Did we need to give the name rember-eq? to the function (rember-f test?) 
      where test? is eq? |#
#| A: No, we could have written ((rember-f test?) a l) where test? is eq? a is
      tuna and l is (tuna salad is good). ((rember-f eq?) 'tuna '(tuna salad is good)). |#

#| Q: Now, complete the line (cons (car l) ...) in rember-f so that rember-f works. |#
#| A: Ok. |#

;; rember-f : Predicate -> Function
;; Given a predicate, produces a function that removes elements from a list.
(define rember-f
  (λ (test?)
    (λ (a l)
      (cond
        ((null? l) '())
        ((test? (car l) a) (cdr l))
        (else
         (cons (car l)
               ((rember-f test?) a (cdr l))))))))

; This is the book solution.

#| Q: What is ((rember-f eq?) a l) where a is tuna and 
      l is (shrimp salad and tuna salad) |#
#| A: (shrimp salad and salad). |#

((rember-f eq?) 'tuna '(shrimp salad and tuna salad)) ; ==> '(shrimp salad and salad)

#| Q: What is ((rember-f eq?) a l) where a is 'eq? and l is (equal? eq? eqan? eqlist? eqpair?)
      Did you notice the difference between 'eq? and eq? Remember that the former is the atom
      and the latter is the function. |#
#| A: |#

((rember-f eq?) 'eq? '(equal? eq? eqan? eqlist? eqpair?)) ; ==> '(equal? eqan? eqlist? eqpair?)

#| Q: And now transform insertL to insertL-f the same way we have transformed
      rember into rember-f |#
#| A: Ok. |#

;; insertL-f : Predicate -> Function
;; Given predicate, produces a function that inserts an atom to the left of
;; the first occurrence of a second atom in a list
(define insertL-f
  (λ (test?)
    (λ (new old l)
      (cond
        ((null? l) '())
        ((test? (car l) old)
         (cons new (cons old (cdr l))))
        (else
         (cons (car l)
               ((insertL-f test?) new old (cdr l))))))))

; Book solution is identical.

#| Q: And, just for the exercise, do it to insertR |#
#| A: Ok. |#

;; insertR-f : Predicate -> Function
;; Given predicate, produces a function that inserts an atom to the right of
;; the first occurrence of a second atom in a list.
(define insertR-f
  (λ (test?)
    (λ (new old l)
      (cond
        ((null? l) '())
        ((test? (car l) old)
         (cons old (cons new (cdr l))))
        (else
         (cons (car l)
               ((insertR-f test?) new old (cdr l))))))))

; Book solution is identical.

#| Q: Are insertR and insertL similar? |#
#| A: Only the middle piece is a bit different. |#

#| Q: Can you write a function insert-g that would insert either at the left or at the right?
      If you can, get yourself some coffee cake and relax! Otherwise, don't give up. You'll see it 
      in a minute. |#
#| A: Ok. My attempt below seems to work! |#

;; insert-G-verbose : Predicate Atom -> Function
;; Given predicate and position, produces a function to insert atoms in a list.
(define insert-G-verbose
  (λ (test? pos)
    (cond
      ((eq? pos 'right)
       (λ (new old l)
         (cond
           ((null? l) '())
           ((test? (car l) old)
            (cons old (cons new (cdr l))))
           (else
            (cons (car l)
                  ((insertR-f test?) new old (cdr l)))))))
      (else
       (λ (new old l)
         (cond
           ((null? l) '())
           ((test? (car l) old)
            (cons new (cons old (cdr l))))
           (else
            (cons (car l)
                  ((insertL-f test?) new old (cdr l))))))))))

((insert-G-verbose eq? 'right) 'chicken 'tuna '(This is a very good tuna salad!))
; ==> '(This is a very good tuna chicken salad!) Correct.
((insert-G-verbose eq? 'left) 'chicken 'tuna '(This is a very good tuna salad!))
; ==> '(This is a very good chicken tuna salad!) Correct.
((insert-G-verbose eq? 'xxx) 'chicken 'tuna '(This is a very good tuna salad!))
; ==> '(This is a very good chicken tuna salad!) Left is default so this is also correct.

; This can be written with the predefined insertR-f and insertL-f functions in short format.

(define insert-G
  (λ (test? pos)
    (cond
      ((eq? pos 'right)
       (insertR-f test?))
      (else
       (insertL-f test?)))))

((insert-G eq? 'right) 'chicken 'tuna '(This is a very good tuna salad!))
; ==> '(This is a very good tuna chicken salad!) Correct.
((insert-G eq? 'left) 'chicken 'tuna '(This is a very good tuna salad!))
; ==> '(This is a very good chicken tuna salad!) Correct.
((insert-G eq? 'xxx) 'chicken 'tuna '(This is a very good tuna salad!))
; ==> '(This is a very good chicken tuna salad!) Left is default so this is also correct.

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