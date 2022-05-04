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

#| Note: I wanted to do this recursively with intersect but it
         took me some time to realize that the terminal line has to be
         (null? (cdr l-set) (car l-set)).

         The book solution is of course the same. |#

(intersectall '((a b c) (c a d e) (e f g h a b))) ; ==> '(a)

(intersectall '((6 pears and) 
                (3 peaches and 6 peppers) 
                (8 pears and 6 plums) 
                (and 6 prunes with some apples))) ; ==> '(6 and)


#| Q: Is this a pair? (pear pear) |#
#| A: Yes, because it is a list with only two atoms. |#

#| Q: Is this a pair? (3 7) |#
#| A: Yes. |#

#| Q: Is this a pair? ((2) (pair)) |#
#| A: Yes, because it is a list with only two S-expressions. |#

#| Q: (a-pair? l) where l is (full (house)) |#
#| A: #t, because it is a list with only two S-expressions.|#

#| Q: Define a-pair? |#
#| A: Ok. |#

;; a-pair.v1? : Sexp -> Boolean
;; Given S-expression, produces true if it is a list of exactly two S-expressions.
(define a-pair.v1?
  (λ (sexp)
    (cond
      ((atom? sexp) #f)
      ((null? (cdr sexp)) #f)
      ((null? (cdr (cdr sexp))) #t)
      (else #f))))

(a-pair.v1? 'pear)                 ; ==> #f
(a-pair.v1? '(pear))               ; ==> #f
(a-pair.v1? '(pear pear))          ; ==> #t
(a-pair.v1? '(3 7))                ; ==> #t
(a-pair.v1? '((2) (pair)))         ; ==> #t
(a-pair.v1? '(full (house)))       ; ==> #t
(a-pair.v1? '(full (house) again)) ; ==> #f


; Book solution below. I ended with the same after thinking I had come up with something better...

(define a-pair? 
  (λ (x) 
    (cond 
      ((atom? x) #f) 
      ((null? x) #f) 
      ((null? (cdr x)) #f) 
      ((null? (cdr (cdr x))) #t) 
      (else #f)))) 

(a-pair? 'pear)                 ; ==> #f
(a-pair? '(pear))               ; ==> #f
(a-pair? '(pear pear))          ; ==> #t
(a-pair? '(3 7))                ; ==> #t
(a-pair? '((2) (pair)))         ; ==> #t
(a-pair? '(full (house)))       ; ==> #t
(a-pair? '(full (house) again)) ; ==> #f

#| Q: How can you refer to the first S-expression of a pair? |#
#| A: By taking the car of the pair. |#

#| Q: How can you refer to the second S-expression of a pair? |#
#| A: By taking the car of the cdr of the pair. |#

#| Q: How can you build a pair with two atoms? |#
#| A: You cons the first one onto the cons of the second one onto ().
      That is, (cons x1 (cons x2 '())). |#

#| Q: How can you build a pair with two S-expressions? |#
#| A: You cons the first one onto the cons of the 
      second one onto (). That is, (cons x1 (cons x2 '())). |#

#| Q: Did you notice the differences between the last two answers? |#
#| A: No, there aren't any. |#

(define first.v1 
  (λ (p) 
    (cond 
      (else (car p)))))

(define second.v1 
  (λ (p) 
    (cond 
      (else (car (cdr p))))))

(define build.v1 
  (λ (sl s2) 
    (cond 
      (else (cons sl 
                  (cons s2 '()))))))

#| Q: What possible uses do these three functions have? |#
#| A: They are used to make representations of pairs and to get
      parts of representations of pairs. See chapter 6. 
      They will be used to improve readability, as you will soon see. 
      Redefine first, second, and build as one-liners. |#

;; first : Pair -> Sexp
;; Given pair, produces the first element
(define first
  (λ (p) 
    (car p)))

;; second : Pair -> Sexp
;; Given pair, produces, the second element
(define second 
  (λ (p) 
    (car (cdr p))))

;; build : Sexp Sexp -> Pair
;; Given two S-expressions, produces a pair
(define build
  (λ (sl s2) 
    (cons sl 
          (cons s2 '()))))

#| Q: Can you write third as a one-liner? |#
#| A: Yes. |#

;; third : List -> Sexp
;; Given list, produces the third S-expression in it.
(define third
  (λ (l)
    (car (cdr (cdr l)))))

#| Q: Is l a rel where l is (apples peaches pumpkin pie) |#
#| A: No, since l is not a list of pairs. We use rel to stand for relation. |#

#| Q: Is l a rel where l is ((apples peaches) (pumpkin pie) (apples peaches)) |#
#| A: No, since l is not a set of pairs. |#

#| Q: Is l a rel where l is ((apples peaches) (pumpkin pie)) |#
#| A: Yes. |#

#| Q: Is l a rel where l is ((4 3) (4 2) (7 6) (6 2) (3 4)) |#
#| A: Yes. |#

#| Q: Is rel a fun where rel is ((4 3) (4 2) (7 6) (6 2) (3 4)) |#
#| A: No. We use fun to stand for function. |#

#| Q: What is (fun? rel) where rel is ((8 3) (4 2) (7 6) (6 2) (3 4)) |#
#| A: #t, because (firsts rel) is a set -See chapter 3. |#

#| Q: What is (fun? rel) where rel is ((d 4) (b 0) (b 9) (e 5) (g 4)) |#
#| A: #f, because b is repeated.|#



#| Q: Write fun? with set? and firsts |#
#| A: Ok. |#

;; fun? : Rel -> Boolean
;; Given rel, produces true if the first elements produce a set.
(define fun?
  (λ (rel)
    (set? (firsts rel))))

(fun? '((4 3) (4 2) (7 6) (6 2) (3 4)))                   ; ==> #f
(fun? '((apples peaches) (pumpkin pie) (apples peaches))) ; ==> #f
(fun? '((apples peaches) (pumpkin pie)))                  ; ==> #t
(fun? '((8 3) (4 2) (7 6) (6 2) (3 4)))                   ; ==> #t
(fun? '((d 4) (b 0) (b 9) (e 5) (g 4)))                   ; ==> #f


#| Q: Is fun? a simple one-liner? |#
#| A: It sure is. |#

#| Q: How do we represent a finite function? |#
#| A: For us, a finite function is a list of pairs in which no first element
      of any pair is the same as any other first element. |#

#| Q: What is (revrel rel) where rel is ((8 a) (pumpkin pie) (got sick)) |#
#| A: ((a 8) (pie pumpkin) (sick got)). |#

#| Q: You can now write revrel |#
#| A: Ok. |#

;; revrel : Rel -> Rel
;; Given rel, reverses the order of each pair in the rel.
(define revrel
  (λ (rel)
    (cond
      ((null? rel) '())
      (else
       (cons (build (second (car rel))
                    (first (car rel)))
             (revrel (cdr rel)))))))

(revrel '((8 a) (pumpkin pie) (got sick))) ; ==> '((a 8) (pie pumpkin) (sick got))

; Book solution is identical.


#| Q: Would the following also be correct: |#
(define revrel.v2 
  (lambda (rel) 
    (cond 
      ((null? rel) '()) 
      (else (cons (cons 
                   (car (cdr (car rel))) 
                   (cons (car (car rel)) 
                         '())) 
                  (revrel.v2 (cdr rel)))))))

(revrel.v2 '((8 a) (pumpkin pie) (got sick))) ; ==> '((a 8) (pie pumpkin) (sick got))

#| A: Yes, but now do you see how representation aids readability?
      Note: Yes, I do see. |#

#| Q: Suppose we had the function revpair that reversed the two components
      of a pair like this (see below). How would you rewrite revrel to use
      this help function? |#

;; revpair : Pair -> Pair
;; Given pair, reverses the order of the S-expressions
(define revpair 
  (λ (pair) 
    (build (second pair) (first pair)))) 


#| A: See my solution below. |#

(define revrel.v3
  (λ (rel)
    (cond
      ((null? rel) '())
      (else (cons (revpair (car rel))
                  (revrel.v3 (cdr rel)))))))

; No problem, and it is even easier to read: 
; Book solution is exactly the same.

(revrel.v3 '((8 a) (pumpkin pie) (got sick))) ; ==> '((a 8) (pie pumpkin) (sick got))

#| Q: Can you guess why fun is not a fullfun where fun is
      ((8 3) (4 2) (7 6) (6 2) (3 4)) |#
#| A: fun is not a fullfun, since the 2 appears more than once as a second item of a pair. |#

#| Q: Why is #t the value of (fullfun? fun) where fun is
      ((8 3) (4 8) (7 6) (6 2) (3 4)) |#
#| A: Because (3 8 6 2 4) is a set. |#

#| Q: What is (fullfun? fun) where fun is
      ((grape raisin) 
       (plum prune) 
       (stewed prune)) |#
#| A: #f. |#

#| Q: What is (fullfun? fun) where fun is
      ((grape raisin) 
       (plum prune) 
       (stewed grape)) |#
#| A: #t, because (raisin prune grape) is a set. |#

#| Q: Define fullfun? |#
#| A: Ok. But first I will create a helper. |#

; Note: My fullfun? below is the same as in the book (no helper in the book yet).

;; seconds : Fun -> List
;; Given fun, produces a list composed of the second expressions of each sublist.
(define seconds
  (λ (fun)
    (cond
      ((null? fun) '())
      ((null? (car fun)) (seconds (cdr fun)))
      (else
       (cons (car (cdr (car fun))) (seconds (cdr fun)))))))

(seconds '((8 3) (4 8) (7 6) (6 2) (3 4))) ; ==> '(3 8 6 2 4)

;; fullfun? : Fun -> Boolean
;; Given fun, produces true if the secons elements in fun create a set.
(define fullfun?
  (λ (fun)
    (set? (seconds fun))))

(fullfun? '((8 3) (4 8) (7 6) (6 2) (3 4))) ; ==> #t

#| Q: Can you define seconds |#
#| A: It is just like firsts. |#

#| Q: What is another name for fullfun? |#
#| A: one-to-one?. |#

#| Q: Can you think of a second way to write one-to-one? |#
#| A: Not of the top of my head, no. |#

(define one-to-one? 
  (λ (fun) 
    (fun? (revrel fun)))) 

; Note: Didn't remember we had revrel

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#