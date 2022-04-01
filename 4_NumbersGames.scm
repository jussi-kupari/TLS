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

#| Q: What is (* 5 3) |#
#| A: 15. |#

#| Q: What is (* 13 4) |#
#| A: 52. |#

#| Q: What does (* n m) do? |#
#| A: Builds a number by adding up n m times |#

#| Q: What is the terminal condition line for *?|#
#| A: ((zero? m) 0), b/c n * 0 = 0 |#

#| Q: Since (zero? m) is the terminal condition, m must eventually
      be reduced to zero. What function is used to do this? |#
#| A: sub1 |#



#|                 *** The Fourth Commandment ***           
                          (first revision) 
          Always change at least one argument while recurring.
            It must be changed to be closer to termination.
   The changing argument must be tested in the termination condition:   
            when using cdr, test termination with null? and 
              when using sub1, test termination with zero?.                 |#



#| Q: What is another name for (* n (sub1 m)) in this case? |#
#| A: The natural recursion for (* n m) |#

#| Q: Try to write the function * [times] |#
#| A: Ok. |#

;; times : WN WN -> WN
;; Given two whole numbers, adds up the first times the second
(define times
  (λ (n m)
    (cond
      ((zero? m) 0)
      (else (+ n (times n (sub1 m)))))))

(times 7 5) ; ==> 35

#| Q: What is (times 12 3) |#
#| A: (+ 12 (+ 12 (+ 12 0)), or 36, but let's follow through the function one 
      time to see how we get this value. |#

#| Q: (zero? m) |#
#| A: False. |#

#| Q: What is the meaning of (+ n (times n (sub1 m)))? |#
#| A: It adds n (where n = 12) to the natural recursion. If times is correct then 
      (times 12 (sub1 3)) should be 24. |#
(times 12 (sub1 3)) ; ==> 24

#| Q: What are the new arguments of (* n m) |#
#| A: n is 12 and m is 2 |#

#| Q: (zero? m) |#
#| A: False. |#

#| Q: What is the meaning of (+ n (times n (sub1 m)))? |#
#| A: It adds n (where n = 12) to (* n (sub1 m)). |#
(times 12 (sub1 2)) ; ==> 12

#| Q: What are the new arguments of (* n m) |#
#| A: n is 12 and m is 1 |#

#| Q: (zero? m) |#
#| A: False. |#

#| Q: What is the meaning of (+ n (times n (sub1 m)))? |#
#| A: It adds n (where n = 12) to (* n (sub1 m)). |#
(times 12 (sub1 1)) ; ==> 0

#| Q: What is the value of the line ((zero? m) 0)  |#
#| A: 0, b/c (zero? m) is now true. |#

#| Q: Are we finished yet? |#
#| A: No. |#

#| Q: Why not? |#
#| A: We still have all the + calls to pick up. |#

#| Q: What is the value of the original application? |#
#| A: (+ 12 (+ 12 (+ 12 0)). Notice that n has been +ed m times. |#

#| Q: Argue, using equations, that times is the conventional multiplication of nonnegative 
      integers, where n is 12 and m is 3. |#

#| A: (times 12 3) = 12 + (times 12 2)
       = 12 + 12 + (times 12 1)
       = 12 + 12 + 12 + (times 12 0)
       = 12 + 12 + 12 + 0

      Which is as we expected. This technique works for all recursive functions, not just 
      those that use numbers. You can use this approach to write functions as well as to 
      argue their correctness. |#

#| Q: Again, why is 0 the value for the terminal condition line in times? |#
#| A: Because 0 will not affect +. That is, n + O = n |#



#|                          *** The Fifth Commandment *** 
            When building a value with + , always use 0 for the value of the 
          terminating line, for adding 0 does not change the value of an addition.
       When building a value with *, always use 1 for the value of the terminating line,
            for multiplying by 1 does not change the value of a multiplication.
    When building a value with cons, always consider () for the value of the terminating line.        |#



#| Q: What is (tup+ tup1 tup2) where tup1 is (3 6 9 11 4) and tup2 is (8 5 2 0 7) |#
#| A: (11 11 11 11 11) |#

#| Q: What is (tup+ tup1 tup2) where tup1 is (2 3) and tup2 is (4 6) |#
#| A: (6 9) |#

#| Q: What does (tup+ tup1 tup2) do? |#
#| A: It takes two tuples of equal length as arguments and adds the first number from tup1 to the
      first number of tup2 and so on, building a tup of the answers. |#

#| Q: What is unusual about tup+ |#
#| A: It looks at each element of two tups at the same time, or in other words, it recurs on 
      two tups.  |#

#| Q: If you recur on one tup how many questions do you have to ask? |#
#| A: Two: (null tup) and else. |#

#| Q: When recurring on two tups, how many questions need to be asked about the tups? |#
#| A: Four questions:
      Are both tups null? (and (null? tup1) (null? tup2))
      Is the first tup null? (null? tup1)
      Is the second tup null? (null? tup2)
      else |#

#| Q: Do you mean the questions 
      (and (null'? tup1 ) (null'? tup2)) 
      (null? tup1 ) 
      (null? tup2) 
      and else |#
#| A: Yes, like I said above. |#

#| Q: Can the first tup be () at the same time as the second is other than () |#
#| A: If the tups must be of equal length the no. |#

#| Q: Does this mean (and (null? tup1 ) (null? tup2)) and 
      else are the only questions we need to ask? |#
#| A: Yes, but we could also ask (null? tup1) or (null? tup2) as the first
      question, because the tups are of equal length. |#

#| Q: Write the function tup+ |#
#| A: Will do. |#

(define tup+
  (λ (tup1 tup2)
    (cond
      ((and (null? tup1) (null? tup2))
       '())
      (else
       (cons
        (+ (car tup1) (car tup2))
        (tup+ (cdr tup1) (cdr tup2)))))))

(tup+ '(5 7 9) '(2 2 3)) ; ==> '(7 9 12)

; book version is the same as mine

#| Q: What are the arguments of +? |#
#| A: (car tup1) (car tup2) |#

#| Q: What are the arguments of cons? |#
#| A: (+ (car tup1) (car tup2)) and (tup+ (cdr tup1) (cdr tup2)) |#

#| Q: What is (tup+ tup1 tup2) where tup1 is (3 7) and tup2 is (4 6) |#
#| A: (7 13), but let's see how it works |#
(tup+ '(3 7) '(4 6)) ; ==> '(7 13)

#| Q: (null? tup1 ) |#
#| A: False. |#

#| Q: (cons
        (+ (car tup1 ) (car tup2))
        (tup+ (cdr tup1 ) (cdr tup2))) |#
#| A: (cons (+ 3 4 (tup+ (7) (6)),
      so cons 7 to the natural recursion |#

#| Q: Why does the natural recursion include the cdr of both arguments? |#
#| A: Because the typical element of the final value uses the car of both tups,
      so now we are ready to consider the rest of both tups. |#

#| Q: (null? tup1) where tup1 is now (7) and tup2 is now (6) |#
#| A: False. |#

#| Q: (cons 
        (+ (car tup1) (car tup2)) 
        (tup+ (cdr tup1 ) (cdr tup2))) |#
#| A: (cons (+ 7 6) (tup+ () ()), or cons 13 onto the natural recursion. |#

#| Q: (null? tup1 ) |#
#| A: True. |#

#| Q: Then, what must be the value? |#
#| A: (), because (null? tup2) must also be true. |#

#| Q: What is the value of the application? |#
#| A: (7 13). In other words, (cons (+ 3 4) (cons (+ 7 6) (cons ())
      or (cons 7 (cons 13 (cons ()), or (7 13).
      That is, the cons of 7 onto the cons of 13 onto (). |#

#| Q: What problem arises when we want (tup+ tup1 tup2) where 
      tup1 is (3 7) and tup2 is (4 6 8 1) |#
#| A: No answer, since tup1 will become null before tup2. 
      See The First Commandment: We did not ask all the necessary questions! 
      But, we would like the final value to be (7 13 8 1). |#

#| Q: Can we still write tup+ even if the tups are not the same length? |#
#| A: Yes! |#

#| Q: What new terminal condition line can we add to get the correct final value? |#
#| A: Add ((null? tup1) tup2). |#

#| Q: What is (tup+ tup1 tup2) where tup1 is (3 7 8 1) and tup2 is (4 6) |#
#| A: No answer, since tup2 will become null before tup1. 
      See The First Commandment: We did not ask all the necessary questions! |#

#| Q: What do we need to include in our function? |#
#| A: We need to ask two more questions: (null? tup1) and (null? tup2). |#

#| Q: What does the second new line look like?|#
#| A: ((null? tup2) tup1) |#

#| Q: Here is a definition of tup+ that works for any two tups:
      Can you simplify it? |#

(define tup+.v2 
    (λ (tup1 tup2) 
      (cond 
        ((and (null? tup1) (null? tup2)) 
         '()) 
        ((null? tup1) tup2) 
        ((null? tup2) tup1) 
        (else 
         (cons (+ (car tup1) (car tup2)) 
                (tup+.v2 
                 (cdr tup1) (cdr tup2)))))))

(tup+.v2 '(3 7 8 1) '(4 6)) ; ==> '(7 13 8 1)

#| A: You can remove the ((and (null? tup1) (null? tup2)) '())
      This is because if the tups are the same length you will be
      consing a null tup at the and as is correct |#

(define tup+.v3 
    (λ (tup1 tup2) 
      (cond 
        ((null? tup1) tup2) 
        ((null? tup2) tup1) 
        (else 
         (cons (+ (car tup1) (car tup2)) 
                (tup+.v3 
                 (cdr tup1) (cdr tup2))))))) 

(tup+.v3 '(3 7 8 1) '(4 6)) ; ==> '(7 13 8 1)

#| Q: Does the order of the two terminal conditions matter? |#
#| A: No. |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#