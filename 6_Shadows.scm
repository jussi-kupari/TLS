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

;; plus : WN WN -> WN
;; Given two whole numbers (nonnegative integers), produces their sum
(define plus
  (λ (n m)
    (cond
      ((zero? m) n)
      (else
       (add1 (plus n (sub1 m)))))))

;; same-num? : WN WN -> Boolean
;; Given two whole numbers, produces true if they are the same.
(define same-num?
  (λ (n m)
    (cond
      ((zero? m) (zero? n))
      ((zero? n) #f)
      (else
       (same-num? (sub1 n) (sub1 m))))))

;; eqan? : Atom Atom -> Boolean
;; Given two atoms, produces true if they are the same atom.
(define eqan?
  (λ (a1 a2)
    (cond
      ((and (number? a1)
            (number? a2)
            (same-num? a1 a2)) #t)
      ((or (number? a1)
           (number? a2)) #f)
      (else (eq? a1 a2)))))

;; times : WN WN -> WN
;; Given two whole numbers, adds up the first times the second
(define times
  (λ (n m)
    (cond
      ((zero? m) 0)
      (else (+ n (times n (sub1 m)))))))

;; ** : WN WN -> WN
;; Given two whole numbers, raises the first to the power of the second
(define **
  (λ (n m)
    (cond
      ((zero? m) 1)
      (else (times n (** n (sub1 m)))))))



#|                    Shadows                    |#



#| Q: Is 1 an arithmetic expression? |#
#| A: Yes. |#

#| Q: Is 3 an arithmetic expression? |#
#| A: Yes, of course. |#

#| Q: Is 1 + 3 an arithmetic expression? |#
#| A: Yes! |#

#| Q: Is 1 + 3 x 4 an arithmetic expression? |#
#| A: Definitely. |#

#| Q: Is cookie an arithmetic expression? |#
#| A: Yes. Are you almost ready for one? |#

#| Q: And, what about 3 exp y + 5 |#
#| A: Yes |#

#| Q: What is an arithmetic expression in your words? |#
#| A: In ours: "For the purpose of this chapter, an arithmetic expression is either an atom 
      (including numbers), or two arithmetic expressions combined by plus, times, or **." |#

#| Q: What is (quote a)? |#
#| A: a. |#

#| Q: What is (quote +)? |#
#| A: The atom +, not the operation + |#

#| Q: What does (quote *) stand for? |#
#| A: The atom *, not the operation * |#

#| Q: Is (eq? (quote a) y) true or false where y is a? |#
#| A: True. a is the same as a. |#

#| Q: Is (eq? x y) true or false where x is a and y is a? |#
#| A: That's the same question again. And the answer is still true. |#

#| Q: Is (n + 3) an arithmetic expression? |#
#| A: Not really, since there are parentheses around n + 3. Our definition of arithmetic 
      expression does not mention parentheses. |#

#| Q: Could we think of (n + 3) as an arithmetic expression? |#
#| A: Yes, if we keep in mind that the parentheses are not really there. |#

#| Q: What would you call (n + 3) |#
#| A: We call it a representation for n + 3.
      note: It looks like a list to me. |#

#| Q: Why is (n + 3) a good representation? |#
#| A: Because 
      1. (n + 3) is an S-expression. 
      It can therefore serve as an argument for a function.

      2. It structurally resembles n + 3. |#

#| Q: True or false: (numbered? x) where x is 1 |#
#| A: True. |#

#| Q: How do you represent 3 + 4 * 5? |#
#| A: (3 + (4 * 5)). |#

#| Q: True or false: (numbered? y) where y is (3 + (4 ** 5))|#
#| A: True. |#

#| Q: True or false: (numbered? z ) where z is (2 * sausage) |#
#| A: False, b/c sausage is not a number. |#

#| Q: What is numbered? |#
#| A: my take: numbered? is a function that determines if the value
      of its argument is as a number.

     book: It is a function that determines whether a representation
     of an arithmetic expression contains only numbers besides the +, *, 
     and **. |#

#| Q: Now can you write a skeleton for numbered? |#
#| A: Not so sure. |#

#| A good guess
(define numbered?
  (λ (aexp)
    (cond
     ((...) ...)
     ((...) ...)
     ((...) ...)
     ((...) ...)
      ))) |#

#| Q: What is the first question? |#
#| A: (atom? aexp) |#

#| Q: What is (eq? (car (cdr aexp)) (quote +)) |#
#| A: It is the second question. |#

#| Q: Can you guess the third one? |#
#| A: No, but the book says:
      (eq? (car (cdr aexp)) (quote * )) is perfect. |#

#| Q: And you must know the fourth one. |#
#| A: (eq? (car (cdr aexp)) (quote ** )) |#

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

(define numbered? 
  (λ (aexp) 
    (cond
      ((atom? aexp) (number? aexp))
      ((eq? (car (cdr aexp)) '+)
       (and
        (numbered? (car aexp))
        (numbered? (car (cdr (cdr aexp)))))) 
      ((eq? (car (cdr aexp)) '*)
       (and
        (numbered? (car aexp))
        (numbered? (car (cdr (cdr aexp)))))) 
      ((eq? (car (cdr aexp)) '**)                   ;This could/should be else
       (and
        (numbered? (car aexp))
        (numbered? (car (cdr (cdr aexp)))))))))

(numbered? '(1 + 1)) ; ==> #t
(numbered? '(3 ** 5)) ; ==> #t
(numbered? '(6 * 2)) ; ==> #t
(numbered? '(6 * two)) ; ==> #f

#| Q: Since aexp was already understood to be an arithmetic expression, could we have written 
      numbered? in a simpler way? |#
#| A: Yes. |#

(define numbered??
  (λ (aexp)
    (cond
      ((atom? aexp) (number? aexp))
      (else                                  
       (and (numbered?? (car aexp))
            (numbered??
             (car (cdr (cdr aexp)))))))))

(numbered?? '(1 + 1)) ; ==> #t
(numbered?? '(3 ** 5)) ; ==> #t
(numbered?? '(6 * 2)) ; ==> #t
(numbered?? '(6 * two)) ; ==> #f

#| Q: Why can we simplify? |#
#| A: Because we know we've got the function right. |#

#| Q: What is (value u) where u is 13 |#
#| A: 13. |#

#| Q: (value x) where x is (1 + 3) |#
#| A: 4. |#

#| Q: (value y) where y is (1 + (3 ** 4) |#
#| A: 82.
      or (+ 1 (* 3 3 3 3)) |#

#| Q: (value z) where z is cookie |#
#| A: No answer. |#

#| Q: (value nexp) returns what we think is the natural value of a numbered arithmetic 
      expression. |#
#| A: We hope. |#

#| Q: How many questions does value ask about nexp. |#
#| A: Four. |#

#| Q: Now, let's attempt to write value. |#
#| A: Ok. |#

#| 
(define value 
    (λ (nexp) 
      (cond 
        ((atom? nexp) ... ) 
        ((eq? (car (cdr nexp)) (quote +)) 
         ... ) 
        ((eq? (car (cdr nexp)) (quote x )) 
         ... ) 
        (else ... )))) |#

#| Book version is identical. |#

#| Q: What is the natural value of an arithmetic expression that is a number? |#
#| A: The number itself. It is just that number. |#

#| Q: What is the natural value of an arithmetic expression that consists of two arithmetic 
      expressions combined by + |#
#| A: It is the sum of the two artihmetic subexpressions. If we had the natural value of the two 
      subexpressions, we could just add up the two values. |#

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

(define value
  (λ (nexp)
    (cond
      ((atom? nexp) nexp)
      ((eq? (car (cdr nexp)) '+)
       (plus (value (car nexp))
          (value (car (cdr (cdr nexp))))))                     
      ((eq? (car (cdr nexp)) '*)
       (times (value (car nexp))
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

#| A: Ok. |#


#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#