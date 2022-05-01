#lang racket

;; Require
(require
  "Atom.scm"
  "1_Toys.scm"
  "2_Doitdoitagainandagainandagain.scm"
  "3_ConsTheMagnificent.scm"
  "4_NumbersGames.scm"
  "5_OhMyGawdItsFullOfStars.scm"
  "6_Shadows.scm")



#|                    Friends and Relations                    |#



#| Q: Is this a set? (apple peaches apple plum) |#
#| A: No, since apple appears more than once. |#

#| Q: True or false: (set? lat) where lat is (apples peaches pears plums) |#
#| A: #t, because no atom appears more than once. |#

#| Q: How about (set? lat) where lat is () |#
#| A: #t, because no atom appears more than once. |#

#| Q: Try to write set? |#
#| A: Ok. |#

;; set.v1? : LAT -> Boolean
;; Given lat, produces true if no atom appears more than once.
(define set.v1?
  (λ (lat)
    (cond
      ((null? lat) #t)
      (else
       (cond
         ((member? (car lat) (cdr lat)) #f)
         (else (set.v1? (cdr lat))))))))

#| Note: I didn't remember we had created member? and started to implement
        it from the beginning. I also used -if- with member?, but then reverted to cond,
        so this is now identical to the book solution. |#

(set.v1? '()) ; ==> #t
(set.v1? '(apple peaches apple plum)) ; ==> #F
(set.v1? '(apples peaches pears plums)) ; ==> #t

#| Q: Simplify  set? |#
#| A: Ok. Let's remove the redundant cond. |#

;; set? : LAT -> Boolean
;; Given lat, produces true if no atom appears more than once.
(define set?
  (λ (lat)
    (cond
      ((null? lat) #t)
      ((member? (car lat) (cdr lat)) #f)
      (else (set? (cdr lat))))))

(set? '()) ; ==> #t
(set? '(apple peaches apple plum)) ; ==> #F
(set? '(apples peaches pears plums)) ; ==> #t

#| Q: Does this work for the example (apple 3 pear 4 9 apple 3 4}|#
#| A: Yes, since member? is now written using equal? instead of eq?. |#

(set? '(apple 3 pear 4 9 apple 3 4)) ; ==> #f
(set? '(apple 3 pear 9 4)) ; ==> #t

#| Q: Were you surprised to see the function member? appear in the definition of set? |#
#| A: You should not be, because we have written member? already, and now we can use it 
      whenever we want. Note: I had forgotten we had defined member? before. |#

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