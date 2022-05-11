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

; The first book solution is more verbose and returns (cdr l) when the first match is found.

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
#| A: Let's generate all versions with rember-f. |#

#| Q: What kind of values can functions return? |#
#| A: Lists and atoms. |#

#| Q: What about functions themselves? |#
#| A: Yes, but you probably did not know that yet. |#

#| Q: Can you say what (λ (a l) ...) is? |#
#| A: (λ (a l) ...) is a function of two arguments, a and l. |#

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
#| A: (define rember-eq? (rember-f test?)) where test? is eq?. |#

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

; This is identical to the book solution.

#| Q: What is ((rember-f eq?) a l) where a is tuna and 
      l is (shrimp salad and tuna salad) |#
#| A: (shrimp salad and salad). |#

((rember-f eq?) 'tuna '(shrimp salad and tuna salad)) ; ==> '(shrimp salad and salad)

#| Q: What is ((rember-f eq?) a l) where a is 'eq? and l is (equal? eq? eqan? eqlist? eqpair?)
      Did you notice the difference between 'eq? and eq? Remember that the former is the atom
      and the latter is the function. |#
#| A: (equal? eqan? eqlist? eqpair?). |#

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
#| A: Ok. My clumsy attempt is below, but it seems to work. |#

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

; This can be written with the predefined insertR-f and insertL-f functions in shorter format.

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

;; define seqL.v1 : Sexp Sexp Sexp -> List
;; Given three s-expressions, produces a list from first sexp to last.
(define seqL.v1
  (λ (first second third)
    (cons first
          (cons second
                (cons third '())))))

(seqL.v1 'a 'b 'c) ; ==> '(a b c)
(seqL.v1 'a 'b '(c)) ; ==> '(a b (c))

; The book function is not quite that.
(define seqL 
  (λ (new old l) 
    (cons new (cons old l))))


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

#| A: Ok. I am using the defined insertR and insertL functions from chapter 3. |#

(define insert-g.v1
  (λ (seq)
    (cond
      ((equal? seq seqL)
       insertL)
      ((equal? seq seqR)
       insertR))))

((insert-g.v1 seqR) 'chicken 'tuna '(This is a very good tuna salad!))
; ==> '(This is a very good tuna chicken salad!)

((insert-g.v1 seqL) 'chicken 'tuna '(This is a very good tuna salad!))
; ==> '(This is a very good chicken tuna salad!)


; The book solution is obviously not using the predefined functions.

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

((insert-g seqR) 'chicken 'tuna '(This is a very good tuna salad!))
; ==> '(This is a very good tuna chicken salad!)

((insert-g seqL) 'chicken 'tuna '(This is a very good tuna salad!))
; ==> '(This is a very good chicken tuna salad!)


#| Q: Now define insertL with insert-g |#
#| A: Ok. |#
(define insertl (insert-g seqL)) 

#| Q: And insert. |#
#| A: Sure. |#
(define insertr (insert-g seqR))

(insertr 'chicken 'tuna '(This is a very good tuna salad!))
; ==> '(This is a very good tuna chicken salad!)

(insertl 'chicken 'tuna '(This is a very good tuna salad!))
; ==> '(This is a very good chicken tuna salad!)

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

#| A: Ok .|#

(define insert-l
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
    (cons new l))) 

#| Q: And now define subst using insert-g |#
#| A: Ok. |#

(define subst (insert-g seqS))

(subst 'xx 'b '(a b c)) ; ==> '(a xx c)

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

6. It appears that #f in the inner function allows us to bypass the unused argument
   See further down.


This is from the book:

Surprise! It is our old friend rember

 Hint: Step through the evaluation of
   (yyy a l) 
 where 
   a is sausage 
 and 
   l is (pizza with sausage and bacon). |#

;; What role does #f play?

;; Let's try something ==>

;; Function that takes three arguments but doesn't use one of them.
(define inner
  (λ (x y z)
    (+ x y)))

;; Function that takes only two arguments but uses the other fn that takes three arguments.
(define outer
  (λ (x y)
    (inner x y #f)))

(outer 15 62) ; ==> 77

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
#| A: Let me try. |#

;; atom-to-function : Atom -> Function
;; Given atom, produces the appropriate function
(define atom-to-function
  (λ (a)
    (cond
      ((eq? a '+) plus) 
      ((eq? a ' *) x)   
      (else **))))      

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
;; Given nexp, produces its value
(define value
  (λ (nexp)
    (cond
      ((atom? nexp) nexp)
      (else
       ((atom-to-function (car (cdr nexp))) ; operator
        (value (car nexp))                  ; 1st-sub-exp
        (value (car (cdr (cdr nexp))))))))) ; 2nd-sub-exp

; Book uses operator, 1st-sub-exp and 2nd-sub-exp here

(value 10) ; ==> 10
(value 999) ; ==> 999
(value '(999 + 1)) ; ==> 1000
(value '(999 * 1)) ; ==> 999
(value '(999 ** 1)) ; ==> 1000
(value '(999 ** 2)) ; ==> 998001
(value '(999 ** 0)) ; ==> 1

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
;; Given predicate, produces a function to remove atoms from a list
(define multirember-f
  (λ (test?)
    (λ (a lat) 
      (cond 
        ((null? lat) '()) 
        ((eq? (car lat) a) 
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
((multirember-f eq?) 'tuna '(shrimp salad tuna salad and tuna))
; ==> ,(shrimp salad salad and)

#| Q: Wasn't that easy? |#
#| A: Yes. |#

#| Q: Define multirember-eq ? using multirember-f |#
#| A: Ok.
      (define multirember-eq? (multirember-f test?))
      where test? is eq?. |#
      
(define multirember-eq? (multirember-f eq?))
(multirember-eq? 'tuna '(shrimp salad tuna salad and tuna))
; ==> '(shrimp salad salad and)

#| Q: Do we really need to tell multirember-f about tuna |#
#| A: As multirember-f visits all the elements in lat, it always looks for tuna.

      Note: This is confusing. What is the point of this? multirember-f takes a
      predicate as input but the resulting function needs to be given an atom to
      look for. |#

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

#| Q: Have you ever seen definitions that contain atoms? |#
#| A: Yes, 0, 'x, '+, and many more. |#

#| Q: Perhaps we should now write multiremberT which is similar to multirember-f 
      Instead of taking test? and returning a function, multiremberT takes a function like 
      eq?-tuna and a lat and then does its work. |#
#| A: This is not really difficult. |#

;; multiremberT : Predicate LAT -> LAT
;; Given predicate and lat, removes all wanted atoms from lat
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

(multiremberT eq?-tuna '(shrimp salad tuna salad and tuna))
; ==> '(shrimp salad salad and)

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

; http://www.michaelharrison.ws/weblog/2007/08/unpacking-multiremberco-from-tls/
; https://stackoverflow.com/questions/7004636/explain-the-continuation-example-on-p-137-of-the-little-schemer/7005024#7005024
; https://stackoverflow.com/questions/2018008/help-understanding-continuations-in-scheme?rq=1

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

#| Q: What does (multirember&co a lat f) do?|#
#| A: It looks at every atom of the lat to see whether it is eq? to a.
      Those atoms that are not are collected in one list ls1; the others 
      for which the answer is true are collected in a second list ls2.
      Finally, it determines the value of (f ls1 ls2). |#

#| Q: Final question: What is the value of (multirember&co (quote tuna) ls col) 
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



#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#