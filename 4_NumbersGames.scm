#lang racket

;; atom? : Any -> Boolean
;; Produces #true if input is an atom
(define atom? 
  (λ (x) 
    (and (not (pair? x)) (not (null? x)))))



#|               Numbers Games               |#



#| Q: Is 14 an atom? |#
#| A: Yes, all numbers are atoms. |#

#| Q: Is (atom? n) true or false where n is 14 |#
#| A: True, because 14 is a number and therefore an atom. |#
(atom? 14) ; ==> #t

#| Q: Is -3 a number? |#
#| A: Yes, but we do not consider negative numbers. |#

#| Q: Is 3.14159 a number? |#
#| A: Yes, but we consider only whole numbers. |#

#| Q: Are -3 and 3.14159 numbers? |#
#| A: Yes, but the only numbers we use are the nonnegative integers. |#

#| Q: What is (add1 n), where n is 67? |#
#| A: 68. |#
(add1 67) ; ==> 68

#| Q: What is (add1 67)? |#
#| A: Also 68, because we don't need to say "where n is 67" when the argument is a number. |#

#| Q: What is (sub1 n) where n is 5? |#
#| A: 4. |#
(sub1 5) ; ==> 4

#| Q: What is (sub1 0) |#
#| A: No answer. (in practice (sub1 0) returns -1 )|#

#| Q: Is (zero? 0) true or false? |#
#| A: True. |#

#| Q: Is (zero? 1492) true or false? |#
#| A: False. |#
(zero? 1492) ; ==> #f

#| Q: What is (+ 46 12) |#
#| A: 58. |#
(+ 46 12)

#| Q: Try to write the function plus Hint: It uses zero? add1 and sub1 |#
#| A: Ok. |#

;; plus : WN WN -> WN
;; Given two whole numbers (nonnegative integers), produces their sum
(define plus
  (λ (n m)
    (cond
      ((zero? m) n)
      (else
       (add1 (plus n (sub1 m)))))))

(plus 5 5) ; ==> 10
(plus 5 0) ; ==> 5
(plus 0 5) ; ==> 5

#| Q: But didn't we just violate The First Commandment? |#
#| A: Yes, but we can treat zero? like null? since zero? asks if a number is empty and null? 
      asks if a list is empty. |#

#| Q: If zero? is like null? is add1 like cons? |#
#| A: Yes! cons builds lists and add1 builds numbers. |#

#| Q: What is (- 14 3) |#
#| A: 11. |#
(- 14 3) ; ==> 11

#| Q: What is (- 17 9) |#
#| A: 8. |#
(- 17 9) ; ==> 8

#| Q:  What is (- 18 25)|#
#| A: No answer. There are no negative numbers. |#

#| Q: Try to write the function minus Hint: Use sub1 |#
#| A: Ok. |#

;; minus : WN WN -> WN
;; Given two whole numbers (nonnegative integers), subtracts the second from the first
(define minus
  (λ (n m)
    (cond
      ((zero? m) n)
      (else (minus (sub1 n) (sub1 m))))))

(minus 6 5) ; ==> 1
(minus 5 5) ; ==> 0
(minus 26 5) ; ==> 21

; from the book
(define --  
  (λ (n m) 
    (cond 
      ((zero? m) n) 
      (else (sub1 (-- n (sub1 m)))))))

(-- 6 5) ; ==> 1
(-- 5 5) ; ==> 0
(-- 26 5) ; ==> 21

#| Q: Can you describe how (-- n m) works? |#
#| A: It takes two numbers as arguments, and reduces the second until it hits zero.
      It subtracts one from the result as many times as it did to cause the second
      one to reach zero.

      minus takes two numbers as arguments, and reduces both one at a time.
      The difference between the numbers is what remains from the first numbers when the
      second hits zero. |#

#| Q: Is this a tup? (2 11 3 79 47 6) |#
#| A: Yes, tup is short for tuple. |#

#| Q: Is this a tup? (8 55 5 555) |#
#| A: Yes. It is also a list of numbers. |#

#| Q: Is this a tup? (1 2 8 apple 4 3) |#
#| A: No. This is just a list of atoms. It has a non-number in it. |#

#| Q: Is this a tup? (3 (7 4) 13 9) |#
#| A: No. b/c it is not a list of numbers. (7 4) is not a number. |#

#| Q: Is this a tup? () |#
#| A: Yes, it is a list of zero numbers. This special case is the empty tup. |#

#| Q: What is (addtup tup) where tup is (3 5 2 8)? |#
#| A: 18. |#

#| Q: What is (addtup tup) where tup is (15 6 7 12 3)? |#
#| A: 43. |#

#| Q: What does addtup do? |#
#| A: It builds a number by totaling all the numbers in its argument. |#

#| Q: What is the natural way to build numbers from a list? |#
#| A: Use + in place of cons: + builds numbers in the same way as cons builds lists. |#

#| Q: When building lists with cons the value of the terminal condition is ()
      What should be the value of the terminal condition when building numbers with + |#
#| A: 0. |#

#| Q: What is the natural terminal condition for a list? |#
#| A: (null? l) |#

#| Q: What is the natural terminal condition for a tup? |#
#| A: (zero? tup) |#

#| Q: When we build a number from a list of numbers, what should the terminal condition 
      line look like? |#
#| A: ((null? tup) 0), so when the tuple is empty the value is zero.
      Compare to ((null? l) ()) with lists. |#

#| Q: What is the terminal condition line of addtup? |#
#| A: ((null? tup) 0) |#

#| Q: How is a lat defined? |#
#| A: It is either an empty list, or it contains an atom, (car lat),
      and a rest, (cdr lat), that is also a lat. |#

#| Q: How is a tup defined? |#
#| A: Like a list of numbers. It is either an empty list, or it contains a 
      number and a rest that is also a tup. |#

#| Q: What is used in the natural recursion on a list?|#
#| A: (cdr lat) |#

#| Q: What is used in the natural recursion on a tup? |#
#| A: (cdr tup) |#

#| Q: Why? |#
#| A: Because a tup is just a list of numbers. The rest of a non-empty list is a list 
      and the rest of a non-empty tup is a tup. |#

#| Q: How many questions do we need to ask about a list? |#
#| A: Two. |#

#| Q: How many questions do we need to ask about a tup? |#
#| A: Two, b/c it is a list of numbers; either it is empty or it is a 
      number and a rest, which is again a tup.  |#

#| Q: How is a number defined? |#
#| A: It is either zero or it is one added to a rest, 
      where rest is again a number. |#

#| Q: What is the natural terminal condition for numbers? |#
#| A: (zero? n) |#

#| Q: What is the natural recursion on a number? |#
#| A: (sub1 n) |#

#| Q: How many questions do we need to ask about a number? |#
#| A: Two. (zero? n) and else. |#



 #|                *** The First Commandment *** 
                         (first revision) 
               When recurring on a list of atoms, lat,
         ask two questions about it: (null? lat) and else. 
      When recurring on a number, n, ask two questions about it:
                       (zero ? n) and else.                            |#



#| Q: What does cons do? |#
#| A: It constructs lists. |#

#| Q: What does addtup do? |#
#| A: I sums up all the numbers in a tuple. |#

#| Q: What is the terminal condition line of addtup? |#
#| A: ((null? tup) 0) |#

#| Q: What is the natural recursion for addtup? |#
#| A: (addtup (cdr tup)) |#

#| Q: What does addtup use to build a number? |#
#| A: It uses +, b/c + builds numbers, too! |#

#| Q: Fill in the dots in the following definition:
(define addtup 
    (λ (tup) 
      (cond 
        ((null? tup) 0) 
        (else ... )))) |#

#| A: Ok. |#

;; addtup : Tuple -> Whole Number
;; Given tuple, adds up all the numbers in the tuple
(define addtup 
    (λ (tup) 
      (cond 
        ((null? tup) 0) 
        (else
         (+ (car tup) (addtup (cdr tup)))))))

(addtup '(5 5 5 5 5)) ; ==> 25

#| Here is what we filled in: 
   (+ (car tup) (addtup ( cdr tup))). 
   Notice the similarity between this line, and 
   the last line of the function rember: 
   (cons (car lat) (rember a (cdr lat))). |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#
