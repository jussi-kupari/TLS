#lang racket

(provide (all-defined-out))

(require "Atom.scm"
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

#| Q: What is (makeset lat) where lat is (apple peach pear peach plum apple lemon peach) |#
#| A: (apple peach pear plum lemon)|#

#| Q: Try to write makeset using member? |#
#| A: Ok. |#

;; makeset : LAT -> LAT
;; Given lat, produces reduces it to a set.
(define makeset.v1
  (λ (l)
    (cond
      ((null? l) '())
      ((member? (car l) (cdr l))
       (makeset.v1 (cdr l)))
      (else
       (cons (car l) (makeset.v1 (cdr l)))))))

;; Book solution is identical, but originally I had (null? l) return l.

(makeset.v1 '(apple peach pear peach plum apple lemon peach))
; ==> '(pear plum apple lemon peach)

#| Q: Are you surprised to see how short this is?
      We hope so. But don't be afraid: it's right. |#
#| A: Note: Not really. |#

#| Q: Using the previous definition, what is the result of (makeset lat) where 
      lat is (apple peach pear peach plum apple lemon peach) |#
#| A: (pear plum apple lemon peach). |#

#| Q: Try to write makeset using multirember |#
#| A: Ok. |#

;; makeset.v2 : LAT -> LAT
;; Given lat, produces reduces it to a set.
(define makeset.v2
  (λ (l)
    (cond
      ((null? l) '())
      ((member? (car l) (cdr l)) ; You can skip this and just go with the else part!
       (cons (car l)
             (makeset.v2
              (multirember (car l) (cdr l)))))
      (else (cons (car l) (makeset.v2 (cdr l)))))))

(makeset.v2 '(apple peach pear peach plum apple lemon peach))
; ==> '(apple peach pear plum lemon)

;; Book version neatly just uses multirember for every atom making in simpler.

;; makeset : LAT -> LAT
;; Given lat, produces reduces it to a set.
(define makeset
  (λ (l)
    (cond
      ((null? l) '())
      (else (cons (car l)
                  (makeset
                   (multirember (car l) (cdr l))))))))

(makeset '(apple peach pear peach plum apple lemon peach))
; ==> '(apple peach pear plum lemon)

#| Q: What is the result of (makeset lat) using this second definition where
      lat is (apple peach pear peach plum apple lemon peach) |#
#| A: (apple peach pear plum lemon). |#
(makeset.v2 '(apple peach pear peach plum apple lemon peach)) ; ==> '(apple peach pear plum lemon)
(makeset '(apple peach pear peach plum apple lemon peach)) ; ==> '(apple peach pear plum lemon)

#| Q: Describe in your own words how the second definition of makeset works.
      Here are our words: 
      "The function makeset remembers to cons the first atom in the lat onto the result of 
       the natural recursion, after removing all occurrences of the first atom from the rest of the lat." |#

#| A: Starting from the first atom in the list, makeset conses the atom to the result of
      the natural recursion of makeset on the remaining list after all possible occurrences
      of the atom have been removed. |#

#| Q: Does the second makeset work for the example (apple 3 pear 4 9 apple 3 4) |#
#| A: Yes, since multirember is now written using equal? instead of eq?. |#
(makeset '(apple 3 pear 4 9 apple 3 4)) ; ==> '(apple 3 pear 4 9)

#| Q: What is (subset ? set1 set2) where set1 is (5 chicken wings) and set2 is
      (5 hamburgers 2 pieces fried chicken and light duckling wings) |#
#| A: #t, because each atom in set1 is also in set2. |#

#| Q: What is (subset? set1 set2) where set1 is (4 pounds of horseradish) and 
      set2 is (four pounds chicken and 5 ounces horseradish) |#
#| A: #f. |#

#| Q: Write subset? |#
#| A: Ok. |#

;; subset? : Set Set -> Boolean
;; Given two sets, produces true if all atoms in the first are found in the second
(define subset?
  (λ (set1 set2)
    (cond
      ((null? set1) #t)
      (else
       (and (member? (car set1) set2)
            (subset? (cdr set1) set2))))))

(subset? '(5 chicken wings) '(5 hamburgers 2 pieces fried chicken and light duckling wings)) ; ==> #t
(subset? '(4 pounds of horseradish) '(four pounds chicken and 5 ounces horseradish)) ;  ==> #f

; First book version uses a slightly different structure
(define subset.v2? 
  (λ (set1 set2) 
    (cond 
      ((null? set1) #t) 
      (else (cond 
              ((member? (car set1) set2) 
               (subset.v2? (cdr set1) set2)) 
              (else #f))))))

(subset.v2? '(5 chicken wings) '(5 hamburgers 2 pieces fried chicken and light duckling wings)) ; ==> #t
(subset.v2? '(4 pounds of horseradish) '(four pounds chicken and 5 ounces horseradish)) ;  ==> #f

#| Q: Can you write a shorter version of subset? |#
#| A: Yes. |#
(define subset.v3?
  (λ (set1 set2)
    (cond
      ((null? set1) #t)
      ((member? (car set1) set2)
       (subset.v3? (cdr set1) set2))
      (else #f))))

(subset.v3? '(5 chicken wings) '(5 hamburgers 2 pieces fried chicken and light duckling wings)) ; ==> #t
(subset.v3? '(4 pounds of horseradish) '(four pounds chicken and 5 ounces horseradish)) ;  ==> #f

#| Q: Try to write subset ? with (and ...) |#
#| A: See above for my original version of subset. |#

#| Q: What is (eqset? set1 set2) where set1 is (6 large chickens with wings) and 
      set2 is (6 chickens with large wings) |#
#| A: #t. |#

;; eqset? : Set Set -> Boolean
;; Given two sets, produces true if they are the same.
(define eqset.v1?
  (λ (set1 set2)
    (cond
      ((and (null? set1) (null? set2) #t))
      ((and
        (member? (car set1) set2)
        (eqset.v1? (cdr set1) (rember (car set1) set2)))))))

(eqset.v1? '(6 large chickens with wings) '(6 chickens with large wings)) ; ==> #t

; Book just uses subset? and i forgot to use it...

(define eqset.v2?
  (λ (set1 set2)
    (cond
      ((subset? set1 set2)
       (subset? set2 set1))
      (else #f))))

(eqset.v2? '(6 large chickens with wings) '(6 chickens with large wings)) ; ==> #t

#| Q: Can you write eqset? with only one cond-line? |#
#| A: Ok. |#

(define eqset.v3?
  (λ (set1 set2)
    (cond
      (else
       (and (subset? set1 set2)
            (subset? set2 set1))))))

(eqset.v3? '(6 large chickens with wings) '(6 chickens with large wings)) ; ==> #t

#| Q: Write the one-liner. |#
#| A: Ok. |#

;; eqset? : Set Set -> Boolean
;; Given two sets, produces true if they are the same.
(define eqset?
  (λ (set1 set2)
    (and (subset? set1 set2)
         (subset? set2 set1))))

(eqset? '(6 large chickens with wings) '(6 chickens with large wings)) ; ==> #t

#| Q: What is (intersect? set1 set2) where set1 is (stewed tomatoes and macaroni) and 
      set2 is (macaroni and cheese) |#
#| A: #t, because at least one atom in set1 is in set2. |#

#| Q: Define the function intersect? |#
#| A: Ok. |#

;; intersect? : Set1 Set2 -> Boolean
;; Given two sets, produces true if at least one from first is in second.
(define intersect?
  (λ (set1 set2)
    (cond
      ((null? set1) #f) 
      (else
       (or (member? (car set1) set2)
           (intersect? (cdr set1) set2))))))

(intersect? '(stewed tomatoes and macaroni) '(macaroni and cheese)) ; ==> #t
(intersect? '(stewed tomatoes but no chicken) '(macaroni and cheese)) ; ==> #f

;First book version

(define intersect.v2? 
  (λ (set1 set2) 
    (cond 
      ((null? set1) #f ) 
      (else 
       (cond 
         ((member? (car set1) set2) #t ) 
         (else (intersect.v2? 
                (cdr set1 ) set2))))))) 

(intersect.v2? '(stewed tomatoes and macaroni) '(macaroni and cheese)) ; ==> #t
(intersect.v2? '(stewed tomatoes but no chicken) '(macaroni and cheese)) ; ==> #f

#| Q: Write the shorter version. |#
#| A: Ok. |#

(define intersect.v3? 
  (λ (set1 set2) 
    (cond 
      ((null? set1) #f ) 
      ((member? (car set1) set2) #t ) 
      (else (intersect.v3? (cdr set1) set2)))))

(intersect.v3? '(stewed tomatoes and macaroni) '(macaroni and cheese)) ; ==> #t
(intersect.v3? '(stewed tomatoes but no chicken) '(macaroni and cheese)) ; ==> #f

#| Q: Try writing intersect? with (or ...) |#
#| A: My own version was written with (or ...)|#

#| Q: What is (intersect set1 set2) where set1 is (stewed tomatoes and macaroni)
      and set2 is (macaroni and cheese) |#
#| A: (and macaroni). |#

#| Q: Now you can write the short version of intersect |#
#| A: Ok. |#

;; intersect : Set1 Set2 -> Boolean
;; Given two sets, produces the intersect of the two sets.
(define intersect 
  (λ (set1 set2) 
    (cond 
      ((null? set1 ) '()) 
      ((member? (car set1 ) set2) 
       (cons (car set1) 
             (intersect (cdr set1) set2))) 
      (else (intersect (cdr set1) set2)))))

(intersect '(stewed tomatoes and macaroni) '(macaroni and cheese)) ; ==> '(and macaroni)

; Book solution is identical to mine.

#| Q: What is (union set1 set2) where set1 is (stewed tomatoes and macaroni casserole) 
      and set2 is (macaroni and cheese) |#
#| A: (stewed tomatoes casserole macaroni and cheese) |#

#| Q: Write union |#
#| A: Ok. |#

;; union : Set Set -> Set
;; Given two sets, produces their union.
(define union.v1
  (λ (set1 set2)
    (cond
      ((null? set1) set2)
      ((member? (car set1) set2)
       (cons (car set1)           ; this would be easier the other way around
             (union.v1 (cdr set1) (rember (car set1) set2))))
      (else (cons (car set1)
                  (union.v1 (cdr set1) set2))))))

(union.v1 '(stewed tomatoes and macaroni casserole) '(macaroni and cheese))
; ==> '(stewed tomatoes and macaroni casserole cheese)

; Book solution is below. I'm tired and thought the other way around overcomplicating my solution...

(define union
  (lambda (set1 set2) 
    (cond 
      ((null? set1) set2) 
      ((member? (car set1) set2) 
       (union (cdr set1) set2)) 
      (else (cons (car set1) 
                  (union (cdr set1) set2)))))) 

(union '(stewed tomatoes and macaroni casserole) '(macaroni and cheese))
; ==> '(stewed tomatoes and macaroni casserole cheese)

#| Q: What is this function? |#

#|
(define xxx 
  (λ (set1 set2) 
    (cond 
      ((null? set1) '()) 
      ((member? (car set1) set2) 
       (xxx (cdr set1) set2)) 
      (else (cons (car set1) 
                  (xxx (cdr set1) set2)))))) |#

#| A: Note: Looks like it keeps the atoms that are unique for set1, set-diff.
      In our words: 
      "It is a function that returns all the atoms in set1 that are not in set2." 
      That is, xxx is the (set) difference function. |#

;; set-diff : Set Set -> Set
;; Given two sets, produces the set of atoms that is unique to the first set
(define set-diff 
  (λ (set1 set2) 
    (cond 
      ((null? set1) '()) 
      ((member? (car set1) set2) 
       (set-diff (cdr set1) set2)) 
      (else (cons (car set1) 
                  (set-diff (cdr set1) set2))))))

(set-diff '(stewed tomatoes and macaroni casserole) '(macaroni and cheese))
; ==> '(stewed tomatoes casserole)

#| Q: What is (intersect all l-set) where l-set is
      ((a b c) (c a d e) (e f g h a b)) |#

#| A: (a). |#

#| Q: What is (intersect all l-set) where l-set is
      ((6 pears and) 
       (3 peaches and 6 peppers) 
       (8 pears and 6 plums) 
       (and 6 prunes with some apples)) |#

#| A: (6 and).|#

#| Q: Now, using whatever help functions you need, write intersectall
      assuming that the list of sets is non-empty. |#

#| A: Ok. |#

;; intersectall : L-Set -> Set
;; Given l-set, produces the intersection of atoms in the sets
(define intersectall
  (λ (l-set)
    (cond
      ((null? (cdr l-set)) (car l-set))
      (else
       (intersect (car l-set)
                  (intersectall (cdr l-set)))))))

#| Note: I wanted to do this recursively with intersection but it
         took me some time to realize that the terminal line has to be
         (null? (cdr l-set) (car l-set)).

         The book solution is of course the same. |#

(intersectall '((a b c) (c a d e) (e f g h a b))) ; ==> '(a)
(intersectall '((6 pears and) 
                (3 peaches and 6 peppers) 
                (8 pears and 6 plums) 
                (and 6 prunes with some apples))) ; ==> '(6 and)


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