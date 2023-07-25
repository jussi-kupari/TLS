#lang racket

;(provide (all-defined-out))

(require
  (only-in "Atom.scm" atom?)
  (only-in "4_NumbersGames.scm" plus x **)
  (only-in "6_Shadows.scm" operator 1st-sub-exp 2nd-sub-exp))

(module+ test
  (require rackunit))



#|                    Lambda the Ultimate                    |#


                                                                
#| Q: Remember what we did in rember and insertL at the end of chapter 5? |#
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

#| Q: What is (rember-f test? a l) where test? is eq?, a is jelly and
l is (jelly beans are good) |#
#| A: (beans are good). |#

#| Q: What is (rember-f test? a l) where test? is equal? a is (pop corn) and
l is (lemonade (pop corn) and (cake)) |#
#| A: (lemonade and (cake)). |#

#| Q: Try to write rember-f |#
#| A: Ok. |#

;; rember-f : Sexp Predicate List -> List
;; Removes sexp from list using predicate

(define rember-f.v1
  (λ (test? a l)
    (cond
      ((null? l) '())
      ((test? (car l) a) (cdr l))
      (else
       (cons (car l)
             (rember-f.v1 test? a (cdr l)))))))

(module+ test
  (check-equal?
   (rember-f.v1 = 5 '(6 2 5 3)) '(6 2 3))
  (check-equal?
   (rember-f.v1 eq? 'jelly '(jelly beans are good)) '(beans are good))
  (check-equal?
   (rember-f.v1 eq? 'jelly '(jelly beans are good)) '(beans are good))
  (check-equal?
   (rember-f.v1 equal? '(pop corn) '(lemonade (pop corn) and (cake))) '(lemonade and (cake))))


; The first book solution is fully verbose with extra conds.
(define rember-f.v2 
  (λ (test? a l) 
    (cond 
      ((null? l) '()) 
      (else
       (cond 
         ((test? (car l) a) (cdr l)) 
         (else (cons (car l) 
                     (rember-f.v2 test? a 
                                  (cdr l)))))))))
(module+ test
  (check-equal?
   (rember-f.v2 = 5 '(6 2 5 3)) '(6 2 3))
  (check-equal?
   (rember-f.v2 eq? 'jelly '(jelly beans are good)) '(beans are good))
  (check-equal?
   (rember-f.v2 eq? 'jelly '(jelly beans are good)) '(beans are good))
  (check-equal?
   (rember-f.v2 equal? '(pop corn) '(lemonade (pop corn) and (cake))) '(lemonade and (cake))))

; This is good! 

#| Q: What about the short version? |#
#| A: This is exactly like my first version rember-f.v1 above! |#

#|
(define rember-f
  (λ (test? a l)
    (cond
      ((null? l) '())
      ((test? (car l) a) (cdr l))
      (else
       (cons (car l)
             (rember-f test? a
                          (cdr l))))))) |#


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
#| A: Let's generate all versions with rember-f. |#

#| Q: What kind of values can functions return? |#
#| A: Lists and atoms. |#

#| Q: What about functions themselves? |#
#| A: Yes, but you probably did not know that yet. |#

#| Q: Can you say what (λ (a l) ...) is? |#
#| A: (λ (a l) ...) is a function of two arguments, a and l. |#

; (λ (a l) 'value) ==> #<procedure>

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
;; Produces a predicate to check similarity against given sexp
(define eq?-c
  (λ (a)
    (λ (x)
      (eq? x a))))

#| Q: What is (eq?-c k) where k is salad |#
#| A: Its value is a function that takes x as an argument and
tests whether it is eq? to salad. |#

#| Q: So let's give it a name using (define ...) |#
#| A: Okay. |#

; (define eq?-salad (eq?-c k)), where k is salad

;; eq?-salad : Sexp -> Boolean
;; Produces true if given sexp is equal to the atom salad
(define eq?-salad (eq?-c 'salad))

#| Q: What is (eq?-salad y) where y is salad |#
#| A: #t. |#

(module+ test
  (check-true
   (eq?-salad 'salad)))

#| Q: What is (eq?-salad y) where y is tuna |#
#| A: #f. |#

(module+ test
  (check-false
   (eq?-salad 'tuna)))

#| Q: Do we need to give a name to eq?-salad |#
#| A: No, we may just as well ask
((eq?-c x) y)
where
x is salad
and 
y is tuna. |#

(module+ test
  (check-false
   ((eq?-c 'salad) 'tuna)))

#| Q: Now rewrite rember-f as a function of one argument test?
that returns an argument like rember with eq? replaced by test? |#
#| A: Ok.

;; rember-f : Predicate -> Function
;; Produces a function that removes a sexp from a list using the predicate.

(define rember-f
  (λ (test?)
    (λ (a l)
      (cond
        ((null? l) '())
        ((test? (car l) a) (cdr l))
        (else
         (cons (car l) ...)))))) 

is a good start |#
 
#| Q: Describe in your own words the result of (rember-f test?) where test? is eq? |#
#| A: It is a function that takes two arguments, a and l. It compares the elements of the list 
with a using eq?, and removes the first atom that results in #true. |#

#| Q: Give a name to the function returned by (rember-f test?) where test? is eq? |#
#| A: (define rember-eq? (rember-f test?)) where test? is eq?. |#

#| Q: What is (rember-eq? a l) where a is tuna and l is (tuna salad is good) |#
#| A: (salad is good). |#

#| Q: Did we need to give the name rember-eq? to the function (rember-f test?) 
      where test? is eq? |#
#| A: No, we could have written ((rember-f test?) a l) where test? is eq?, a is
      tuna and l is (tuna salad is good). ((rember-f eq?) 'tuna '(tuna salad is good)). |#

#| Q: Now, complete the line (cons (car l) ...) in rember-f so that rember-f works. |#
#| A: Ok. |#

;; rember-f : Predicate -> Function
;; Produces a function that removes the first matching element from a list using the predicate.

(define rember-f
  (λ (test?)
    (λ (a l)
      (cond
        ((null? l) '())
        ((test? (car l) a) (cdr l))
        (else
         (cons (car l)
               ((rember-f test?) a (cdr l))))))))

(module+ test
  (check-equal?
   ((rember-f eq?) 'tuna '(tuna salad is good))
   '(salad is good)))

#| Q: What is ((rember-f eq?) a l) where a is tuna and 
l is (shrimp salad and tuna salad) |#
#| A: (shrimp salad and salad). |#

(module+ test
  (check-equal?
   ((rember-f eq?) 'tuna '(shrimp salad and tuna salad))
   '(shrimp salad and salad)))

#| Q: What is ((rember-f eq?) a l) where a is 'eq? and l is (equal? eq? eqan? eqlist? eqpair?)
      Did you notice the difference between 'eq? and eq? Remember that the former is the atom
      and the latter is the function. |#
#| A: (equal? eqan? eqlist? eqpair?). |#

(module+ test
  (check-equal?
   ((rember-f eq?) 'eq? '(equal? eq? eqan? eqlist? eqpair?))
   '(equal? eqan? eqlist? eqpair?)))

#| Q: And now transform insertL to insertL-f the same way we have transformed rember into rember-f |#
#| A: Ok. |#

;; insertL-f : Predicate -> Function
;; Produces a version of insertL that uses the predicate to match atoms

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
;; Produces a function that inserts an atom to the right of the first occurrence of a second atom.
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
#| A: Ok. My attempt is below. It seems to work but also uses an extra argument for the predicate |#

;; insert-G : Predicate Atom -> Function
;; Produces a function to insert atoms in a specific position in a list using predicate and atom ('left or 'right).
(define insert-G
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
                  ((insert-G test? pos) new old (cdr l)))))))
      (else
       (λ (new old l)
         (cond
           ((null? l) '())
           ((test? (car l) old)
            (cons new (cons old (cdr l))))
           (else
            (cons (car l)
                  ((insert-G test? pos) new old (cdr l))))))))))

(module+ test
  (check-equal?
   ((insert-G eq? 'right) 'chicken 'tuna '(This is a very good tuna salad!))
   '(This is a very good tuna chicken salad!))
  
  (check-equal?
   ((insert-G eq? 'left) 'chicken 'tuna '(This is a very good tuna salad!))
   '(This is a very good chicken tuna salad!)))

; This can also be written with the predefined insertR-f and insertL-f functions in shorter format.
; but this function is dependent on those two predefined functions

(define insert-G-short
  (λ (test? pos)
    (cond
      ((eq? pos 'right)
       (insertR-f test?))
      (else
       (insertL-f test?)))))

(module+ test
  (check-equal?
   ((insert-G-short eq? 'right) 'chicken 'tuna '(This is a very good tuna salad!))
   '(This is a very good tuna chicken salad!))
  
  (check-equal?
   ((insert-G-short eq? 'left) 'chicken 'tuna '(This is a very good tuna salad!))
   '(This is a very good chicken tuna salad!)))

#| Q: Which pieces differ? |#
#| A: The second lines differ from each other. In insertL it is: 
((eq? (car l) old) 
 (cons new (cons old (cdr l)))), 

but in insertR it is: 
((eq? (car l) old) 
 (cons old (cons new (cdr l)))). |#

#| Q: Put the difference in words! |#
#| A: We say: 
"The two functions cons old and new in a 
       different order onto the cdr of the list l." |#

#| Q: So how can we get rid of the difference? |#
#| A: You probably guessed it: by passing in a function that expresses
the appropriate consing. |#

#| Q: Define a function seqL that 
1. takes three arguments, and 
2. conses the first argument 
onto the result of consing 
the second argument onto the third argument. |#
#| A: Ok. |#

;; define seqL : Sexp Sexp List -> List
;; Produces a list by consing first sexp to the result of consing second and third.
(define seqL 
  (λ (new old l) 
    (cons new (cons old l))))

(module+ test
  (check-equal?
   (seqL 'a 'b '(c)) '(a b c)))

#| Q: What is: |#

(define seqR
  (λ (new old l)
    (cons old (cons new l))))

#| A: A function that 
1. takes three arguments, and 
2. conses the second argument 
onto the result of consing 
the first argument onto 
the third argument. |#

#| Q: Do you know why we wrote these functions? |#
#| A: Because they express what the two differing lines in insertL and insertR express. |#

#| Q: Try to write the function insert-g of one
argument seq 
which returns insertL 
where seq is seqL 
and 
which returns insertR 
where seq is seqR |#

#| A: Ok |#

;; insert-g : Function -> Function
;; Produces a function to insert atoms in a specific position in a list.
(define insert-g 
  (λ (seq) 
    (λ (new old l) 
      (cond 
        ((null? l) '()) 
        ((eq? (car l) old) 
         (seq new old (cdr l))) 
        (else (cons (car l) 
                    ((insert-g seq) new old 
                                    (cdr l)))))))) 

(module+ test
  (check-equal?
   ((insert-g seqR) 'chicken 'tuna '(This is a very good tuna salad!))
   '(This is a very good tuna chicken salad!))

  (check-equal?
   ((insert-g seqL) 'chicken 'tuna '(This is a very good tuna salad!))
   '(This is a very good chicken tuna salad!)))


#| Q: Now define insertL with insert-g |#
#| A: Ok. |#
(define insertL (insert-g seqL)) 

#| Q: And insertR. |#
#| A: Sure. |#
(define insertR (insert-g seqR))

(module+ test
  (check-equal?
   (insertR 'chicken 'tuna '(This is a very good tuna salad!))
   '(This is a very good tuna chicken salad!))
  (check-equal?
   (insertL 'chicken 'tuna '(This is a very good tuna salad!))
   '(This is a very good chicken tuna salad!)))

#| Q: Is there something unusual about these two definitions? |#
#| A: Yes. Earlier we would probably have written 
(define insertL (insert-g seq)) 
where 
seq is seqL 
and 
(define insertR (insert-g seq)) 
where 
seq is seqR. 
But, using "where" is unnecessary when you 
pass functions as arguments. |#

#| Q: Is it necessary to give names to seqL and seqR |#
#| A: Not really. We could have passed their definitions instead. |#

#| Q: Define insertL again with insert-g 
Do not pass in seqL this time. |#
#| A: Ok. |#

(define insert-L
  (insert-g
   (λ (new old l) 
     (cons new (cons old l)))))

#| Q: Is this better? |#
#| A: Yes, because you do not need to remember as many names. You can
(rember func-name "your-mind") where func-name is seqL. |#

#| Q: Do you remember the definition of subst |#
#| A: Here is one.

(define subst 
  (λ (new old l) 
    (cond 
      ((null? l) '()) 
      ((eq? (car l) old) 
       (cons new (cdr l))) 
      (else (cons (car l) 
                  (subst new old (cdr l))))))) |#

#| Q: Does this look familiar? |#
#| A: Yes, it looks like insertL or insertR. Just the 
answer of the second cond-line is different. |#

#| Q: Define a function like seqL or seqR for subst |#
#| A: What do you think about this? |#

(define seqS 
  (λ (new old l) 
    (cons new l)))  ; Note that old is not used here

#| Q: And now define subst using insert-g |#
#| A: Ok. |#

(define subst (insert-g seqS))

(module+ test
  (check-equal?
   (subst 'xx 'b '(a b c)) '(a xx c)))

#| Q: And what do you think yyy is |#

(define yyy 
  (λ (a l) 
    ((insert-g seqrem) #f a l)))

; where

(define seqrem 
  (λ (new old l) l))

#| A:

Step-by-step:

1. seqrem is a function that takes three arguments: new old and l and
always returns l ignoring the others.

2. Here is insert-g again:

(define insert-g 
  (λ (seq) 
    (λ (new old l) 
      (cond 
        ((null? l) '()) 
        ((eq? (car l) old) 
         (seq new old (cdr l)))  ; With seqrem this always returns (cdr l)
        (else (cons (car l) 
                    ((insert-g seq) new old 
                                    (cdr l))))))))

3. If we use seqrem with insert-g, we get a function that takes
three arguments: new old and l, that returns (cdr l) when it encounters
old in the list. The argument new is not used. 

4. When we define yyy we create function that takes two arguments: a and l
that removes the first encounter of a in l. 

5. yyy is just rember.

6. It appears that #f [false] in the inner function allows us to bypass the unused argument
See further down.


This is from the book:

Surprise! It is our old friend rember

Hint: Step through the evaluation of
(yyy a l) 
where 
a is sausage 
and 
l is (pizza with sausage and bacon). |#


;; What role does #f play?!

;; Let's try something

;; inner : Number Number Number -> Number
;; Produces the sum of the first two numbers and ignores the third
(define inner
  (λ (a b c)
    (+ a b)))

(module+ test
  (check-equal?
   (inner 5 7 3) 12))

;; outer : Number Number -> Number
;; Produces the sum of the two arguments
(define outer
  (λ (a b)
    (inner a b #f)))

(module+ test
  (check-equal?
   (outer 15 62) 77))

;; Using #f we can bypass the unused argument.





#|             What you have just seen is the power of abstraction.          |#




#|                        ** The Ninth Commandment **
                  Abstract common patterns with a new function.               |#




#| Q: Have we seen similar functions before? |#
#| A: Yes, we have even seen functions with similar lines. |#

#| Q: Do you remember value from chapter 6? |#
#| A: Let me look it up.

;; value : Nexp -> WN
;; Given nexp, produces its value
(define value
  (λ (nexp)
    (cond
      ((atom? nexp) nexp)
      ((eq? (car (cdr nexp)) '+)
       (plus (value (car nexp))
             (value (car (cdr (cdr nexp))))))                     
      ((eq? (car (cdr nexp)) '*)
       (* (value (car nexp))
          (value (car (cdr (cdr nexp))))))
      (else                                    
       (** (value (car nexp))
           (value (car (cdr (cdr nexp))))))))) |#

#| Q: Do you see the similarities? |#
#| A: The last three answers are the same except for the plus, *, and **. |#

#| Q: Can you write the function atom-to-function 
which: 
1. Takes one argument x and 
2. returns the function + 
if (eq? x '+) 
   returns the function * 
   if (eq? x '*) and 
   returns the function ** 
   otherwise? |#
#| A: Let me try. I will use functions that we defined in Chapter 4. |#

;; atom-to-function : Atom -> Function
;; Given atom, produces the appropriate function
(define atom-to-function
  (λ (x)
    (cond
      ((eq? x '+) plus) 
      ((eq? x '*) *)   
      (else **))))


;; I don't know how to test for functions that return functions
(atom-to-function '+)  ; ==> #<procedure:plus>
(atom-to-function '*)  ; ==> #<procedure:x>
(atom-to-function '**) ; ==> #<procedure:**>

#| Q: What is (atom-to-function (operator nexp)) where nexp is (+ 5 3)

Note! This is referring to functions defined in previous chapters

;; operator : Aexp -> Atom
;; Given aexp, produces the operator between the sub-expressions.
(define operator
  (λ (nexp)
    (car nexp))) |#

#| A: The function plus, not the atom +. |#

(operator '(+ 5 3)) ; ==> '+
(atom-to-function (operator '(+ 5 3))) ; ==> #<procedure:plus>

#| Q: Can you use atom-to-function to rewrite value with only two cond-lines? |#
#| A: Of course.

Here is the original function btw

;; value : Nexp -> WN
;; Given nexp, produces its value
(define value
  (λ (nexp)
    (cond
      ((atom? nexp) nexp)
      ((eq? (car (cdr nexp)) '+)
       (plus (value (car nexp))
             (value (car (cdr (cdr nexp))))))                     
      ((eq? (car (cdr nexp)) '*)
       (* (value (car nexp))
          (value (car (cdr (cdr nexp))))))
      (else                                    
       (** (value (car nexp))
           (value (car (cdr (cdr nexp))))))))) |#


;; value : Nexp -> WN
;; Produces the value of the nexp
(define value.v1
  (λ (nexp)
    (cond
      ((atom? nexp) nexp)
      (else
       ((atom-to-function (operator nexp))     
        (value.v1 (car nexp))                  ; 1st-sub-exp
        (value.v1 (car (cdr (cdr nexp))))))))) ; 2nd-sub-exp


; Book also uses 1st-sub-exp and 2nd-sub-exp
(define value
  (λ (nexp)
    (cond
      ((atom? nexp) nexp)
      (else
       ((atom-to-function (operator nexp))
        (value (1st-sub-exp nexp))
        (value (2nd-sub-exp)))))))

(module+ test
  (check-equal? (value.v1 (+ 5 3)) 8)
  (check-equal? (value.v1 (* 5 3)) 15)
  (check-equal? (value.v1 (** 5 3)) 125)
  (check-equal? (value (+ 5 3)) 8)
  (check-equal? (value (* 5 3)) 15)
  (check-equal? (value (** 5 3)) 125))

#| Q: Is this quite a bit shorter than the first version? |#
#| A: Yes, but that's okay. We haven't changed its meaning. |#

#| Q: Time for an apple? |#
#| A: One a day keeps the doctor away. |#

#| Q: Here is multirember again.

(define multirember 
  (λ (a lat) 
    (cond 
      ((null? lat) '()) 
      ((eq? (car lat) a) 
       (multirember a (cdr lat))) 
      (else (cons (car lat) 
                  (multirember a 
                               (cdr lat)))))))

Write multirember-f |#

#| A: No problem. |#

;; multirember-f : Predicate -> Function
;; Produces a function to remove atoms from a list using a predicate
(define multirember-f
  (λ (test?)
    (λ (a lat) 
      (cond 
        ((null? lat) '()) 
        ((test? (car lat) a) 
         ((multirember-f test?) a (cdr lat))) 
        (else
         (cons (car lat) 
               ((multirember-f test?) a (cdr lat))))))))


#| Q: What is ((multirember-f test?) a lat)
      where 
        test? is eq? 
        a is tuna 
      and 
        lat is (shrimp salad tuna salad and tuna) |#
#| A: (shrimp salad salad and). |#

(module+ test
  (check-equal?
   ((multirember-f eq?) 'tuna '(shrimp salad tuna salad and tuna))
   '(shrimp salad salad and)))

#| Q: Wasn't that easy? |#
#| A: Yes. |#

#| Q: Define multirember-eq? using multirember-f |#
#| A: Ok. |#
      
(define multirember-eq? (multirember-f eq?))

(module+ test
  (check-equal?
   (multirember-eq? 'tuna '(shrimp salad tuna salad and tuna))
   '(shrimp salad salad and)))


#| Q: Do we really need to tell multirember-f about tuna |#
#| A: As multirember-f visits all the elements in lat, it always looks for tuna. |#

#| Q: Does test? change as multirember-f goes through lat |#
#| A: No, test? always stands for eq?, just as a always stands for tuna. |#

#| Q: Can we combine a and test? |#
#| A: Well, test? could be a function of just one argument and could compare
that argument to tuna. |#

#| Q: How would it do that? |#
#| A: The new test? takes one argument and compares it to tuna. |#

#| Q: Here is one way to write this function.

(define eq?-tuna  
  (eq?-c k))

where k is tuna

Can you think of a different way of writing 
this function?  |#

#| A: Yes, and here is a different way: |#

(define eq?-tuna 
  (eq?-c 'tuna))

(module+ test
  (check-true
   (eq?-tuna 'tuna))
  (check-false
   (eq?-tuna 'tunaaa)))

; Note: But isn't this exactly the same as above??

#| Q: Have you ever seen definitions that contain atoms? |#
#| A: Yes, 0, 'x, '+, and many more. |#

#| Q: Perhaps we should now write multiremberT which is similar to multirember-f 
Instead of taking test? and returning a function, multiremberT takes a function like 
eq?-tuna and a lat and then does its work. |#
#| A: This is not really difficult. |#

;; multiremberT : Predicate LAT -> LAT
;; Removes all matching atoms from lat using predicate

(define multiremberT
  (λ (test? lat) 
    (cond 
      ((null? lat) '()) 
      ((test? (car lat)) 
       (multiremberT test? (cdr lat))) 
      (else
       (cons (car lat) 
             (multiremberT test? (cdr lat)))))))

#| Q: What is (multiremberT test? lat) 
      where 
        test? is eq?-tuna 
      and 
        lat is (shrimp salad tuna salad and tuna) |#
#| A: (shrimp salad salad and). |#

(module+ test
  (multiremberT eq?-tuna '(shrimp salad tuna salad and tuna))
  '(shrimp salad salad and))

#| Q: Is this easy? |#
#| A: It's not bad. |#

#| Q: How about this? |#

(define multirember&co 
  (λ (a lat col) 
    (cond 
      ((null? lat) 
       (col '() '())) 
      ((eq? (car lat) a) 
       (multirember&co a 
                       (cdr lat) 
                       (λ (newlat seen) 
                         (col newlat 
                              (cons (car lat) seen))))) 
      (else 
       (multirember&co a 
                       (cdr lat) 
                       (λ (newlat seen) 
                         (col (cons (car lat) newlat) 
                              seen)))))))

#| A: Now that looks really complicated! |#

#| Q: Here is something simpler: |#

;; a-friend : List List -> Boolean
;; Produces true it the second list is empty.
(define a-friend
  (λ (x y)
    (null? y)))

#| A: Yes, it is simpler. It is a function that takes two arguments and asks
whether the second one is the empty list. It ignores its first argument. |#

#| Q: What is the value of
(multirember&co a lat col) 
where 
a is tuna 
lat is (strawberries tuna and swordfish) 
      and 
       col is a-friend |#

#| A: This is not simple. |#

#| Q: So let's try a friendlier example. What is the 
      value of (multirember&co a lat col) 
      where 
        a is tuna 
        lat is () 
      and 
        col is a-friend |#

#| A: #t, because a-friend is immediately used in the first answer on two
      empty lists, and a-friend makes sure that its second argument is empty. |#

#| Q: And what is (multirember&co a lat col) 
      where 
        a is tuna 
        lat is (tuna) 
      and 
        col is a-friend |#

#| A: multirember&co asks (eq? (car lat) 'tuna) 
      where 
        lat is (tuna). 
      Then it recurs on (). |#

#| Q: What are the other arguments that multirember&co uses for the natural recursion? |#
#| A: The first one is clearly tuna. The third argument is a new function. |#

#| Q: What is the name of the third argument? |#
#| A: col. |#

#| Q: Do you know what col stands for? |#
#| A: The name col is short for "collector."
      A collector is sometimes called a "continuation." |#

; http://www.michaelharrison.ws/weblog/2007/08/unpacking-multiremberco-from-tls/  # This link is broken
; https://web.archive.org/web/20201109005927/http://www.michaelharrison.ws/weblog/2007/08/unpacking-multiremberco-from-tls/
; https://stackoverflow.com/questions/7004636/explain-the-continuation-example-on-p-137-of-the-little-schemer/7005024#7005024
; https://stackoverflow.com/questions/2018008/help-understanding-continuations-in-scheme?rq=1
; https://davidgorski.ca/posts/collectors-in-scheme/
; http://debasishg.blogspot.com/2007/08/collector-idiom-in-scheme-is-this.html
; https://stackoverflow.com/questions/40641470/building-the-built-in-procedure-build-list-in-racket/40643451#40643451

; https://dreamsongs.com/Files/WhyOfY.pdf # this is for later


#| Q: Here is the new collector:

(define new-friend 
  (λ (newlat seen) 
    (col newlat 
         (cons (car lat) seen))))

where 
(car lat) is tuna 
and 
col is a-friend

Can you write this definition differently? |#

#| A: Do you mean the new way where we put tuna into the definition?

(define new-friend 
  (λ (newlat seen) 
    (col newlat 
         (cons 'tuna seen))))

where
col is a-friend.
|#

#| Q: Can we also replace col with a-friend in such definitions
because col is to a-friend what (car lat) is to tuna |#

#| A: Yes, we can:

(define new-friend 
  (λ (newlat seen) 
    (a-friend newlat 
              (cons 'tuna seen)))) |#

#| Q: And now? |#
#| A: multirember&co finds out that (null? lat) is true, which means
that it uses the collector on two empty lists. |#

#| Q: Which collector is this? |#
#| A: It is new-friend. |#

#| Q: How does a-friend differ from new-friend |#
#| A: new-friend uses a-friend on the empty list and the value of 
(cons 'tuna '()). |#

#| Q: And what does the old collector do with such arguments? |#
#| A: It answers #f, because its second argument is (tuna), which is not the empty list. |#

#| Q: What is the value of (multirember&co a lat a-friend) 
     where a is tuna 
     and 
       lat is (and tuna) |#

#| A: This time around multirember&co recurs with yet another friend.

(define latest-friend 
  (λ (newlat seen) 
    (a-friend (cons 'and newlat) 
              seen))) |#

 
#| Q: And what is the value of this recursive use of multirember&co |#
#| A: #f, since (a-friend ls1 ls2)
      where 
        ls1 is (and) 
      and 
        ls2 is (tuna) 
      is #f. |#

#| Q: What does (multirember&co a lat f) do? |#
#| A: It looks at every atom of the lat to see whether it is eq? to a.
      Those atoms that are not are collected in one list ls1; the others 
      for which the answer is true are collected in a second list ls2.
      Finally, it determines the value of (f ls1 ls2). |#

#| Q: Final question: What is the value of (multirember&co 'tuna ls col) 
      where 
        ls is (strawberries tuna and swordfish) 
      and 
        col is

(define last-friend 
  (λ (x y) 
    (length x))) |#

#| A: 3, because ls contains three things that are not tuna, and therefore last-friend is used on 
      (strawberries and swordfish) and (tuna). |#



#|                    *** The Tenth Commandment *** 
        Build functions to collect more than one value at a time.          |#



#| Q: Here is an old friend.

(define multiinsertL 
  (λ (new old lat) 
    (cond 
      ((null? lat) '()) 
      ((eq? (car lat) old) 
       (cons new 
             (cons old 
                   (multiinsertL new old 
                                 (cdr lat))))) 
      (else (cons (car lat) 
                  (multiinsertL new old 
                                (cdr lat)))))))

Do you also remember multiinsertR? |#

#| A: No Problem.

(define multiinsertR 
  (λ (new old lat) 
    (cond 
      ((null ? lat) '()) 
      ((eq? (car lat) old) 
       (cons old 
             (cons new 
                   (multiinsertR new old 
                                 (cdr lat))))) 
      (else (cons (car lat) 
                  (multiinsertR new old 
                                (cdr lat))))))) |#



#| Q: Now try multiinsertLR

Hint: multiinsertLR inserts new to the left of oldL and to the right of oldR in lat if 
oldL are oldR are different. |#

#| A: Ok. This was not complicated but I had to peak the answer because I
could not figure out what the function was supposed to do. |#

;; multiinsertLR : Atom Atom Atom LAT -> LAT
;; inserts atom to both sides of matched atom in list
(define multiinsertLR
  (λ (new oldL oldR lat)
    (cond
      ((null? lat) '())
      ((eq? (car lat) oldL)
       (cons new
             (cons oldL (multiinsertLR new oldL oldR (cdr lat)))))
      ((eq? (car lat) oldR)
       (cons oldR
             (cons new (multiinsertLR new oldL oldR (cdr lat)))))
      (else (cons
             (car lat) (multiinsertLR new oldL oldR (cdr lat)))))))

(module+ test
  (check-equal?
   (multiinsertLR 'milk 'chocolate 'coffee '(water tea chocolate coffee beer))
   '(water tea milk chocolate coffee milk beer)))

#| Q: The function multiinsertLR&co is to multiinsertLR what multirember&co is to multirember |#
#| A: Does this mean that multiinsertLR&co takes one more argument than multiinsertLR? |#

#| Q: Yes, and what kind of argument is it? |#
#| A: It is a collector function. |#

#| Q: When multiinsertLR&co is done, it will use col on the new lat, on the number of left 
      insertions, and the number of right insertions. Can you write an outline of multiinsertLR&co |#
#| A: Sure, it is just like multiinsertLR. |#

(define multiinsertLR&co-proto 
  (λ (new oldL oldR lat col) 
    (cond 
      ((null? lat) 
       (col '() 0 0)) 
      ((eq? (car lat) oldL) 
       (multiinsertLR&co-proto new oldL oldR 
                               (cdr lat) 
                               (λ (newlat L R) 
                                 '...))) 
      ((eq? (car lat) oldR) 
       (multiinsertLR&co-proto new oldL oldR 
                               (cdr lat) 
                               (λ (newlat L R) 
                                 '...))) 
      (else 
       (multiinsertLR&co-proto new oldL oldR 
                               (cdr lat) 
                               (λ (newlat L R) 
                                 '...)))))) 


#| Q: Why is col used on '() 0 and 0 when (null? lat) is true? |#
#| A: The empty lat contains neither oldL nor oldR. And this means that 0 occurrences of oldL
      and 0 occurrences of oldR are found and that multiinsertLR will return () when lat is empty. |#

#| Q: So what is the value of
 
(multiinsertLR&co 
 'cranberries 'fish 'chips '() col) |#

#| A: It is the value of (col '() 0 0), which we cannot determine because we don't know what col is. |#

#| Q: Is it true that multiinsertLR&co will use the new collector on three arguments when 
      (car lat) is equal to neither oldL nor oldR |#
#| A: Yes, the first is the lat that multiinsertLR would have produced for (cdr lat), oldL, and 
      oldR. The second and third are the number of insertions that occurred to the left and 
      right of oldL and oldR, respectively. |#

#| Q: Is it true that multiinsertLR&co then uses the function col on (cons (car lat) newlat) 
      because it copies the list unless an oldL or an oldR appears? |#
#| A: Yes, it is true, so we know what the new collector for the last case is:

      (λ (newlat L R) 
       (col (cons (car lat) newlat) L R)).|#

#| Q: Why are col's second and third arguments just L and R |#
#| A: If (car lat) is neither oldL nor oldR, we do not need to insert any new elements.
      So, L and R are the correct results for both (cdr lat) and all of lat. |#

#| Q: Here is what we have so far. And we have even thrown in an extra collector: |#

(define multiinsertLR&co-proto2 
  (λ (new oldL oldR lat col) 
    (cond 
      ((null? lat) 
       (col '() 0 0)) 
      ((eq? (car lat) oldL) 
       (multiinsertLR&co-proto2 new oldL oldR 
                                (cdr lat) 
                                (λ (newlat L R) 
                                  (col (cons new 
                                             (cons oldL newlat)) 
                                       (add1 L) R)))) 
      ((eq? (car lat) oldR) 
       (multiinsertLR&co-proto2 new oldL oldR 
                                (cdr lat) 
                                (λ (newlat L R) 
                                  '...))) 
      (else 
       (multiinsertLR&co-proto2 new oldL oldR 
                                (cdr lat) 
                                (λ (newlat L R) 
                                  (col (cons (car lat) newlat) 
                                       L R)))))))
 

#| A: The incomplete collector is similar to the extra collector. Instead of adding one to L, it 
      adds one to R, and instead of consing new onto consing oldL onto newlat, it conses oldR 
      onto the result of consing new onto newlat. |#

#| Q: Can you fill in the dots? |#

;; This is my attempt
(define multiinsertLR&co 
  (λ (new oldL oldR lat col) 
    (cond 
      ((null? lat) 
       (col '() 0 0)) 
      ((eq? (car lat) oldL) 
       (multiinsertLR&co new oldL oldR 
                         (cdr lat) 
                         (λ (newlat L R) 
                           (col (cons new 
                                      (cons oldL newlat)) 
                                (add1 L) R)))) 
      ((eq? (car lat) oldR) 
       (multiinsertLR&co new oldL oldR 
                         (cdr lat) 
                         (λ (newlat L R) 
                           (col (cons oldR (cons new newlat))
                                L (add1 R))))) 
      (else 
       (multiinsertLR&co new oldL oldR 
                         (cdr lat) 
                         (λ (newlat L R) 
                           (col (cons (car lat) newlat) 
                                L R)))))))

#| A: Yes, the final collector is

(λ (newlat L R) 
  (col (cons oldR (cons new newlat))
       L (add1 R))) |#

#| Q: What is the value of

(multiinsertLR&co new oldL oldR lat col) 
where 
 new is salty 
 oldL is fish 
 oldR is chips 
and 
 lat is (chips and fish or fish and chips) |#

#| A: It is the value of (col newlat 2 2) 
      where 
       newlat is (chips salty and salty fish or salty fish and chips salty). |#

(module+ test
  (check-equal?
   (multiinsertLR&co 'salty 'fish 'chips '(chips and fish or fish and chips) list)
   '((chips salty and salty fish or salty fish and chips salty) 2 2)))

#| Q: Is this healthy? |#
#| A: Looks like lots of salt. Perhaps dessert is sweeter. |#

#| Q: Do you remember what *-functions are? |#
#| A: Yes, all *-functions work on lists that are either 
- empty, 
- an atom consed onto a list, or 
- a list consed onto a list. |#

#| Q: Now write the function evens-only* which removes all odd numbers from a list of nested 
lists. Here is even?

;; even? : Natural -> Boolean
;; Produces #true, if the given number is even, else #false
(define even? 
  (lambda (n) 
    (= (* (quotient n 2) 2) n)))      
|#

; NOTE! I used 'quotient' in the above definition to mimic the custom function 'divide' from before  
; Racket has the function even?


#| A: Now that we have practiced this way of writing functions, evens-only* is just an exercise: |#

;; evens-only* : List-of-tuples-and-atoms -> List-of-tuples-and-atoms
;; Removes all odd numbers in the list 
(define evens-only*
  (λ (l)
    (cond
      ((null? l) '())
      ((atom? (car l))
       (cond
         ((even? (car l))
          (cons (car l) (evens-only* (cdr l))))
         (else (evens-only* (cdr l))))) 
      (else (cons (evens-only* (car l)) ; means that (car l) is a list
                  (evens-only* (cdr l)))))))

; This solution is identical to the one in the book.

#| Q: What is the value of

(evens-only* l) 
where 
l is ((9 1 2 8) 3 10 ((9 9) 7 6) 2) |#

#| A: '((2 8) 10 (() 6) 2) |#

(module+ test
  (check-equal?
   (evens-only* '((9 1 2 8) 3 10 ((9 9) 7 6) 2))
   '((2 8) 10 (() 6) 2)))

#| Q: What is the sum of the odd numbers in l 
where
l is ((9 1 2 8) 3 10 ((9 9) 7 6) 2) |#
#| A: 9 + 1 + 3 + 9 + 9 + 7 = 38. |#

#| Q: What is the product of the even numbers in l 
where 
l is ((9 1 2 8) 3 10 ((9 9) 7 6) 2) |#
#| A: 2 x 8 x 10 x 6 x 2 = 1920. |#

#| Q: Can you write the function evens-only*&co
      It builds a nested list of even numbers by removing the odd ones from its argument 
      and simultaneously multiplies the even numbers and sums up the odd numbers that 
      occur in its argument. |#
#| A: This is full of stars! |#

#| Q: Here is an outline. Can you explain what 
(evens-only*&co (car l) ... ) accomplishes? |#

(define evens-only*&co-proto 
  (λ (l col) 
    (cond 
      ((null? l) 
       (col '() 1 0)) 
      ((atom? (car l)) 
       (cond 
         ((even? (car l)) 
          (evens-only*&co-proto (cdr l) 
                                (λ (newl p s) 
                                  (col (cons (car l) newl) 
                                       (* (car l) p) s)))) 
         (else (evens-only*&co-proto (cdr l) 
                                     (λ (newl p s) 
                                       (col newl 
                                            p (+ (car l) s))))))) 
      (else (evens-only*&co-proto (car l) 
                                  '...)))))



#| A: It visits every number in the car of l and collects the list without odd numbers, the 
      product of the even numbers, and the sum of the odd numbers. |#

#| Q: What does the function evens-only*&co do after visiting all the numbers in (car l) |#
#| A: It uses the collector, which we haven't defined yet. |#

#| Q: And what does the collector do? |#
#| A: It uses evens-only*&co to visit the cdr of l and to collect the list that is like (cdr l), 
      without the odd numbers of course, as well as the product of the even numbers and the 
      sum of the odd numbers. |#

#| Q: Does this mean the unknown collector looks roughly like this: 
(λ (al ap as) 
  (evens-only*&co (cdr l) 
                  ...)) |#
#| A: Yes. |#

#| Q: And when (evens-only*&co (cdr l) ... ) is done with its job, what happens then? |#
#| A: The yet-to-be-determined collector is used, just as before. |#

#| Q: What does the collector for (evens-only*&co (cdr l) ...) do? |#
#| A: It conses together the results for the lists in 
      the car and the cdr and multiplies and adds 
      the respective products and sums. Then it 
      passes these values to the old collector:
(λ (al ap as) 
  (evens-only*&co (cdr l) 
                  (λ (dl dp ds) 
                    (col (cons al dl) 
                         (* ap dp) 
                         (+ as ds))))) |#

(define evens-only*&co 
  (λ (l col) 
    (cond 
      ((null? l) 
       (col '() 1 0)) 
      ((atom? (car l)) 
       (cond 
         ((even? (car l)) 
          (evens-only*&co (cdr l) 
                          (λ (newl p s) 
                            (col (cons (car l) newl) 
                                 (* (car l) p) s)))) 
         (else (evens-only*&co (cdr l) 
                               (λ (newl p s) 
                                 (col newl 
                                      p (+ (car l) s))))))) 
      (else (evens-only*&co (car l) 
                            (λ (al ap as) 
                              (evens-only*&co (cdr l) 
                                              (λ (dl dp ds) 
                                                (col (cons al dl) 
                                                     (* ap dp) 
                                                     (+ as ds))))))))))

; https://stackoverflow.com/questions/10692449/the-little-schemer-evens-onlyco

#| Q: Does this all make sense now? |#
#| A: Perfect. |#

#| Q: What is the value of (evens-only*&co l the-last-friend) 
      where 
       l is ((9 1 2 8) 3 10 ((9 9) 7 6) 2)
      and 
       the-last-friend is defined as follows: |#

(define the-last-friend 
  (λ (newl product sum) 
    (cons sum 
          (cons product 
                newl)))) 
#| A: (38 1920 (2 8) 10 (() 6) 2) |#
















#|                    Whew! Is your brain twisted up now?                    |#


#|                Go eat a pretzel; don't forget the mustard.                |#














