#lang racket

(require "Atom.scm"
         "1_Toys.scm"
         "2_Doitdoitagainandagainandagain.scm"
         "3_ConsTheMagnificent.scm"
         "4_NumbersGames.scm"
         "5_OhMyGawdItsFullOfStars.scm")



#|                    Shadows                    |#



#| Q: Is 1 an arithmetic expression? |#
#| A: Yes. |#

#| Q: Is 3 an arithmetic expression? |#
#| A: Yes, of course. |#

#| Q: Is 1 + 3 an arithmetic expression? |#
#| A: Yes! |#

#| Q: Is 1 + 3 * 4 an arithmetic expression? |#
#| A: Definitely. |#

#| Q: Is cookie an arithmetic expression? |#
#| A: Yes. Are you almost ready for one? |#

#| Q: And, what about 3 ** y + 5 |#
#| A: Yes. |#

#| Q: What is an arithmetic expression in your words? |#
#| A: In ours: "For the purpose of this chapter, an arithmetic expression is either an atom 
      (including numbers), or two arithmetic expressions combined by +, *, or **." |#

#| Q: What is (quote a) |#
#| A: a. |#

#| Q: What is (quote +) |#
#| A: The atom +, not the operation + |#

#| Q: What does (quote *) stand for? |#
#| A: The atom *, not the operation *. |#

#| Q: Is (eq? (quote a) y) true or false where y is a? |#
#| A: True. |#

#| Q: Is (eq? x y) true or false where x is a and y is a? |#
#| A: That's the same question again. And the answer is still true. |#

#| Q: Is (n + 3) an arithmetic expression? |#
#| A: Not really, since there are parentheses around n + 3. Our definition of arithmetic 
      expression does not mention parentheses. |#

#| Q: Could we think of (n + 3) as an arithmetic expression? |#
#| A: Yes, if we keep in mind that the parentheses are not really there. |#

#| Q: What would you call (n + 3) |#
#| A: We call it a representation for n + 3. |#

#| Q: Why is (n + 3) a good representation? |#
#| A: Because 
      1. (n + 3) is an S-expression. 
      It can therefore serve as an argument for a function.

      2. It structurally resembles n + 3. |#

#| Q: True or false: (numbered? x) where x is 1 |#
#| A: True. |#

#| Q: How do you represent 3 + 4 * 5? |#
#| A: (3 + (4 * 5)). |#

#| Q: True or false: (numbered? y) where y is (3 + (4 ** 5)) |#
#| A: True. |#

#| Q: True or false: (numbered? z) where z is (2 * sausage) |#
#| A: False, because sausage is not a number. |#

#| Q: What is numbered? |#
#| A: book: It is a function that determines whether a representation
      of an arithmetic expression contains only numbers besides the +, *, 
      and **. |#

#| Q: Now can you write a skeleton for numbered? |#
#| A: Not so sure. |#

#|
(define numbered?
  (λ (aexp)
    (cond
     ((...) ...)
     ((...) ...)
     ((...) ...)
     ((...) ...))))

 is  a good guess. |#

#| Q: What is the first question? |#
#| A: (atom? aexp). |#

#| Q: What is (eq? (car (cdr aexp)) (quote +)) |#
#| A: It is the second question. |#

#| Q: Can you guess the third one? |#
#| A: No, but the book says:
      (eq? (car (cdr aexp)) (quote * )) is perfect. |#

#| Q: And you must know the fourth one. |#
#| A: (eq? (car (cdr aexp)) (quote **)), of course. |#

#| Q: Should we ask another question about aexp? |#
#| A: No! So we could replace the previous question by else. |#

#| Q: Why do we ask four, instead of two, questions about arithmetic expressions? 
      After all, arithmetic expressions like (1 + 3) are lats. |#
#| A: Because we consider (1 + 3) as a representation of an arithmetic expression in 
      list form, not as a list itself. And, an arithmetic expression is either a
      number, or two arithmetic expressions combined by +, * , or **. |#

#| Q: Now you can almost write numbered?
      Here is our proposal:

(define numbered? 
  (λ (aexp) 
    (cond
      ((atom? aexp) (number? aexp))
      ((eq? (car (cdr aexp)) '+)
       ...) 
      ((eq? (car (cdr aexp)) '*)
       ...) 
      ((eq? (car (cdr aexp)) '**) 
       ...)))) |#

#| A: I see. |#

#| Q: Why do we ask (number? aexp) when we know that aexp is an atom? |#
#| A: Because we want to know if all arithmetic expressions that are atoms are numbers. |#

#| Q: What do we need to know if the aexp consists of two arithmetic expressions combined by + |#
#| A: We need to find out whether the two subexpressions are numbered. |#

#| Q: In which position is the first subexpression? |#
#| A: It is the car of the aexp. (car aexp) |#

#| Q: In which position is the second subexpression? |#
#| A: It is the car of the cdr of the cdr of aexp. (car (cdr (cdr aexp))) |#

#| Q: So what do we need to ask? |#
#| A: (numbered? (car aexp)) and (numbered ? (car (cdr (cdr aexp)))). 
      Both must be true. |#

#| Q: What is the second answer? |#
#| A:
      (and
         (numbered? (car aexp))
         (numbered? (car (cdr (cdr aexp))))) |#

#| Q: Try numbered? again. |#
#| A: Ok. |#

;; numbered? : Aexp -> Boolean
;; Given aexp, produces true if it is numbered. 
(define numbered? 
  (λ (aexp) 
    (cond
      ((atom? aexp) (number? aexp))
      ((eq? (car (cdr aexp)) '+)
       (and
        (numbered? (car aexp))
        (numbered? (car (cdr (cdr aexp))))))        ; * See below
      ((eq? (car (cdr aexp)) '*)
       (and
        (numbered? (car aexp))
        (numbered? (car (cdr (cdr aexp)))))) 
      ((eq? (car (cdr aexp)) '**)                   ;This could be replaced with else
       (and
        (numbered? (car aexp))
        (numbered? (car (cdr (cdr aexp)))))))))

#| *
(car (cdr (cdr aexp))) because
(cdr (cdr '((5 + 5) + (2 + 2)))) ==> '((2 + 2))
(car (cdr (cdr '((5 + 5) + (2 + 2))))) ==> '(2 + 2) |#

(numbered? 12) ; ==> #t
(numbered? 'twelve) ; ==> #f
(numbered? '(1 + 1)) ; ==> #t
(numbered? '(3 ** 5)) ; ==> #t
(numbered? '(6 * 2)) ; ==> #t
(numbered? '(6 * two)) ; ==> #f
(numbered? '((5 + 5) + (2 + 2))) ; ==> #t

#| Q: Since aexp was already understood to be an arithmetic expression, could we have written 
      numbered? in a simpler way? |#
#| A: Yes. |#

;; numbered?? : Aexp -> Boolean
;; Given aexp, produces true if it is numbered.
(define numbered??
  (λ (aexp)
    (cond
      ((atom? aexp) (number? aexp))
      (else                                  
       (and (numbered?? (car aexp))
            (numbered??
             (car (cdr (cdr aexp)))))))))

(numbered?? 12) ; ==> #t
(numbered?? 'twelve) ; ==> #f
(numbered?? '(1 + 1)) ; ==> #t
(numbered?? '(3 ** 5)) ; ==> #t
(numbered?? '(6 * 2)) ; ==> #t
(numbered?? '(6 * two)) ; ==> #f
(numbered?? '((5 + 5) + (2 + 2))) ; ==> #t

#| Q: Why can we simplify? |#
#| A: Because we know we've got the function right. |#

#| Q: What is (value u) where u is 13 |#
#| A: 13. |#

#| Q: (value x) where x is (1 + 3) |#
#| A: 4. |#

#| Q: (value y) where y is (1 + (3 ** 4) |#
#| A: 82. |#

#| Q: (value z) where z is cookie |#
#| A: No answer. |#

#| Q: (value nexp) returns what we think is the natural value of a numbered arithmetic expression. |#
#| A: We hope. |#

#| Q: How many questions does value ask about nexp. |#
#| A: Four. |#

#| Q: Now, let's attempt to write value. |#
#| A: Ok. |#

#| 
(define value 
    (λ (nexp) 
      (cond 
        ((atom? nexp) ...) 
        ((eq? (car (cdr nexp)) (quote +)) 
         ...) 
        ((eq? (car (cdr nexp)) (quote *)) 
         ...) 
        (else ...)))) |#

#| Book version is identical. |#

#| Q: What is the natural value of an arithmetic expression that is a number? |#
#| A: It is just that number. |#

#| Q: What is the natural value of an arithmetic expression that consists of two arithmetic 
      expressions combined by + |#
#| A: If we had the natural value of the two subexpressions, we could just add up the two values. |#

#| Q: Can you think of a way to get the value of the two subexpressions in (1 + (3 * 4))? |#
#| A: Of course, by applying value to 1, and applying value to (3 * 4). |#

#| Q: And in general? |#
#| A: By recurring with value on the subexpressions. |#



#|                    *** The Seventh Commandment *** 
            Recur on the subparts that are of the same nature: 
                        On the sublists of a list. 
            On the subexpressions of an arithmetic expression.             |#



#| Q: Give value another try. |#
#| A: Ok. |#

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
           (value (car (cdr (cdr nexp)))))))))

(value 10) ; ==> 10
(value 999) ; ==> 999
(value '(999 + 1)) ; ==> 1000
(value '(999 * 1)) ; ==> 999
(value '(999 ** 1)) ; ==> 1000
(value '(999 ** 2)) ; ==> 998001
(value '(999 ** 0)) ; ==> 1

#| Q: Can you think of a different representation of arithmetic expressions? |#
#| A: There are several of them. |#

#| Q: Could (3 4 +) represent 3 + 4? |#
#| A: Yes. |#

#| Q: Could (+ 3 4)? |#
#| A: Yes. |#

#| Q: Or (plus 3 4) |#
#| A: Yes. |#

#| Q: Is (+ (* 3 6) (** 8 2)) a representation of an arithmetic expression? |#
#| A: Yes. |#

#| Q: Try to write the function value for a new 
      kind of arithmetic expression that is either: 
      - a number 
      - a list of the atom + followed by 
        two arithmetic expressions, 
      - a list of the atom * followed by 
        two arithmetic expressions, or 
      - a list of the atom ** followed by 
        two arithmetic expressions. |#

#| What about
(define value.v2
  (λ nexp
    (cond
      ((atom? nexp) nexp)
      ((eq? (car nexp) '+)
       (plus (value.v2 (cdr nexp))
             (value.v2 (cdr (cdr nexp)))))
      ((eq? (car nexp) '*)
       (x (value.v2 (cdr nexp))
             (value.v2 (cdr (cdr nexp)))))
      ((eq? (car nexp) '**)
       (** (value.v2 (cdr nexp))
             (value.v2 (cdr (cdr nexp))))))))
|#

#| A: It's wrong. |#

;; Note: My version below doesn't work either (produces no output)

;; value.v2 : Nexp -> WN
;; Given nexp, produces its value
(define value.v2
  (λ nexp
    (cond
      ((atom? nexp) nexp)
      ((eq? (car nexp) '+)
       (plus (value.v2 (car (cdr nexp)))           ; book version misses the car here
             (value.v2 (car (cdr (cdr nexp))))))   ; and here (book deals with it below)
      ((eq? (car nexp) '*)
       (* (value.v2 (car (cdr nexp)))
          (value.v2 (car (cdr (cdr nexp))))))
      ((eq? (car nexp) '**)
       (** (value.v2 (car (cdr nexp)))
           (value.v2 (car (cdr (cdr nexp)))))))))



(value.v2 '(* 5 6)) ; ==> no output

#| Q: Let's try an example. |#
#| A: (+ 1 3). |#

#| Q: (atom? nexp) where nexp is (+ 1 3) |#
#| A: No. |#

#| Q: (eq? (car nexp) (quote +)) where nexp is (+ 1 3) |#
#| A: Yes. |#

#| Q: And now recur. |#
#| A: Yes. |#

#| Q: What is (cdr nexp) where nexp is (+ 1 3) |#
#| A: (1 3). |#

#| Q: (1 3) is not our representation of an arithmetic expression. |#
#| A: No, we violated The Seventh Commandment. (1 3) is not a subpart that is a
      representation of an arithmetic expression! We obviously recurred on a list.
      But remember, not all lists are representations of arithmetic expressions. 
      We have to recur on subexpressions. |#

#| Q: How can we get the first subexpression of a representation of an arithmetic expression? |#
#| A: By taking the car of the cdr. |#

#| Q: Is (cdr (cdr nexp)) an arithmetic expression where nexp is (+ 1 3) |#
#| A: No, the cdr of the cdr is (3), and (3) is not an arithmetic expression. |#

#| Q: Again, we were thinking of the list (+ 1 3) instead of the representation of
      an arithmetic expression. |#
#| A: Taking the car of the cdr of the cdr gets us back on the right track. |#

#| Q: What do we mean if we say the car of the cdr of nexp |#
#| A: The first subexpression of the representation of an arithmetic expression. |#

#| Q: Let's write a function 1st-sub-exp for arithmetic expressions. |#
#| A: Ok. |#

;; 1st-sub-exp : Nexp -> Nexp
;; Given nexp, produces the first sub-expression.
(define 1st-sub-exp
  (λ (nexp)
    (cond
      (else (car (cdr nexp))))))

(1st-sub-exp '(+ 4 7)) ; ==> 4

#| Q: Why do we ask else |#
#| A: Because the first question is also the last question. |#

#| Q: Can we get by without (cond ...) if we don't need to ask questions? |#
#| A: Yes, remember one-liners from chapter 4.

(define 1st-sub-exp 
  (λ (aexp) 
    (car (cdr aexp)))) |#
 
#| Q: Write 2nd-sub-exp for arithmetic expressions. |#
#| A: Ok. |#

;; 2st-sub-exp : Nexp -> Nexp
;; Given nexp, produces the second sub-expression.
(define 2st-sub-exp 
  (λ (aexp) 
    (car (cdr (cdr aexp)))))

(2st-sub-exp '(+ 4 7)) ; ==> 7

#| Q: Finally, let's replace (car nexp) by (operator nexp) |#
#| A: Ok. |#

;; operator : Aexp -> Atom
;; Given aexp, produces the operator between the sub-expressions.
(define operator
  (λ (nexp)
    (car nexp)))

(operator '(+ 4 7)) ; ==> '+

#| Q: Now write value again. |#
#| A: Ok. |#

;; value.v3 : Nexp -> WN
;; Given nexp, produces its value
(define value.v3
  (λ (nexp)
    (cond
      ((atom? nexp) nexp)
      ((eq? (operator nexp) '+)
       (+ (value (1st-sub-exp nexp))
          (value (2st-sub-exp nexp))))
      ((eq? (operator nexp) '*)
       (* (value (1st-sub-exp nexp))
          (value (2st-sub-exp nexp))))
      (else
       (** (value (1st-sub-exp nexp))
           (value (2st-sub-exp nexp)))))))

;; Book solution is identical.

(value.v3 '(* 5 6)) ; ==> 30


#| Q: Can we use this value function for the first representation of arithmetic expressions in 
      this chapter? |# 
#| A: Yes, by changing 1st-sub-exp and operator. |#

#| Q: Do it! |#
#| A:

(define 1st-sub-exp 
  (λ (aexp) 
    (car aexp)))

(define operator 
  (λ (aexp) 
    (car (cdr aexp)))) |#

#| Q: Wasn't this easy? |#
#| A: Yes, because we used help functions to hide the representation. |#



#|                  *** The Eighth Commandment *** 
        Use help functions to abstract from representations.           |#



#| Q: Have we seen representations before? |#
#| A: Yes, we just did not tell you that they were representations. |#

#| Q: For what entities have we used representations? |#
#| A: Truth-values! Numbers! |#

#| Q: Numbers are representations? |#
#| A: Yes. For example 4 stands for the concept four. We chose that symbol because
      we are accustomed to arabic representations. |#

#| Q: What else could we have used? |#
#| A: (() () () ()) would have served just as well. What about ((((()))))? How about (I V)? |#

#| Q: Do you remember how many primitives we need for numbers? |#
#| A: Four: number?, zero?, add1, and sub1. |#

#| Q: Let's try another representation for numbers. How shall we represent zero now? |#
#| A: () is our choise. |#

#| Q: How is one represented? |#
#| A: (()). |#

#| Q: How is two represented? |#
#| A: (() ()). |#

#| Q: Got it? What about three? |#
#| A: Three is (() () ()). |#

#| Q: Write a function to test for zero. |#
#| A: Ok. |#

;; Zero? : Numb -> Boolean
;; Given Numb, produces true if it is Zero 
(define Zero?
  (λ (n)
    (eq? n '())))

(Zero? '()) ; ==> #t
(Zero? '(())) ; ==> #f

; Book version is below

;; sero? : Numb -> Boolean
;; Given Numb, produces true if it is Zero
(define sero?
  (λ (n)
    (null? n)))

(sero? '()) ; ==> #t
(sero? '(())) ; ==> #f


#| Q: Can you write a function that is like add1 |#
#| A: Ok. |#

;; edd1 : Numb -> Numb
;; Given Numb, produces a Numb that is one greater.
(define edd1
  (λ (n)
    (cons '() n)))

(edd1 '()) ; ==> '(())
(edd1 '(())) ; ==> '(() ())

; Book solution is identical (I called mine originally Add1)

#| Q: What about sub1 |#
#| A: Ok. |#

;; zub1 : Numb -> Numb
;; Given Numb, produces a Numb that is one smaller.
(define zub1
  (λ (n)
    (cdr n)))

(zub1 '(())) ; ==> '()
(zub1 '(() ())) ; ==> '(())

; Book solution is identical (I called mine originally Sub1)

#| Q: Is this correct? |#
#| A: Let's see. |#

#| Q: What is (zub1 n) where n is () |#
#| A: No answer, but that's fine. - Recall The Law of Cdr.
      Cdr is only defined for non-empty lists. |#

#| Q: Rewrite + using this representation. |#
#| A: Ok. |#

;; Plus ; Numb Numb -> Numb
;; Given two numbs, produces their sum.
(define Plus
  (λ (n m)
    (cond
      ((sero? m) n)
      (else (Plus (edd1 n) (zub1 m))))))

(Plus '(() ()) '()) ; ==> '(() ())
(Plus '(() ()) '(())) ; ==> '(() () ())

; Book version differs from like (as did the original plus function)

;; Plus ; Numb Numb -> Numb
;; Given two numbs, produces their sum.
(define Pluz
  (λ (n m)
    (cond
      ((sero? m) n)
      (else (edd1 (Pluz n (zub1 m)))))))

(Pluz '(() ()) '()) ; ==> '(() ())
(Pluz '(() ()) '(())) ; ==> '(() () ())


#| Q: Has the definition of Plus changed? |#
#| A: Yes and no. It changed, but only slightly. |#

#| Q: Recall lat? |#
#| A: Easy:

;; lat? : List-of-Anything -> Boolean
;; Given list, produces true if it only contains atoms
(define lat? 
  (λ (l) 
    (cond 
      ((null? l) #t) 
      ((atom? (car l)) (lat? (cdr l))) 
      (else #f))))

But why did you ask? |#

#| Q: Do you remember what the value of (lat? ls) is where ls is (1 2 3) |#
#| A: #t, of course. |#

#| Q: What is (1 2 3) with our new numbers? |#
#| A: ((()) (()()) (()()())). |#

#| Q: What is (lat? ls) where 
ls is ((()) (()()) (()()())) |#
#| A: it is very false. |#

#| Q: Is that bad? |#
#| A: You must beware of shadows. |#