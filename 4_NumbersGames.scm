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

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#
