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

#| Q: Is else the last question? |#
#| A: Yes, because either (null? tup1) or (null? tup2) is true if either one of them does 
      not contain at least one number. |#

#| Q: What is (bigger-than? 12 133) |#
#| A: False. |#

#| Q: What is (bigger-than? 120 11) |#
#| A: True. |#

#| Q: On how many numbers do we have to recur? |#
#| A: Two, n and m|#

#| Q: How do we recur? |#
#| A: (sub1 n) (sub1 m) |#

#| Q: When do we recur? |#
#| A: When we know neither number is equal to 0. |#

#| Q: How many questions do we have to ask about n and m? |#
#| A: Three: (zero? m), (zero? n), and else |#

#| Q: Can you write the function  bigger-than? now using zero? and sub1 |#
#| A: Sure. |#

(define bigger-than??
  (λ (n m)
    (cond
      ((zero? m) #t)
      ((zero? n) #f)
      (else (bigger-than?? (sub1 n) (sub1 m))))))

(bigger-than?? 5 4) ; ==> #t
(bigger-than?? 4 5) ; ==> #f

; Book version is the same as mine.

#| Q: Is the way we wrote (bigger-than?? n m) correct |#
#| A: No, try it for the case where n and m are the same number. Let n and m be 3. |#
(bigger-than?? 3 3) ; ==> #t

#| Q: (zero? 3) |#
#| A: False, so move forwards to the next question. |#

#| Q: (zero? 3) |#
#| A: False, move to the next question. |#

#| Q: What is the meaning of (bigger-than?? (sub1 n) (sub1 m)) |#
#| A: Naturak recursion with both arguments reduced with one. |#

#| Q: (zero? 2) |#
#| A: False, so move forwards to the next question. |#

#| Q: (zero? 2) |#
#| A: False, move to the next question. |#

#| Q: What is the meaning of (bigger-than?? (sub1 n) (sub1 m)) |#
#| A: Natural recursion with both arguments reduced with one. |#

#| Q: (zero? 1) |#
#| A: False, so move forwards to the next question. |#

#| Q: (zero? 1) |#
#| A: False, move to the next question. |#

#| Q: What is the meaning of (bigger-than?? (sub1 n) (sub1 m)) |#
#| A: Natural recursion with both arguments reduced with one. |#

#| Q: (zero? 0) |#
#| A: True, so the value becomes #t |#

#| Q: IS this correct? |#
#| A: No, b/c 3 is not bigger than 3. |#

#| Q: Does the order of the two terminal conditions matter. |#
#| A: Think about it. |#

#| Q: Does the order of the two terminal conditions matter. |#
#| A: Yes. Think first then try.

      If (zero? n) is first and is true, the value becomes #f, but
      if (zero? m) is first and true, the value becomes #t |#

#| Q: How can we change the function bigger-than?? to take care of this subtle problem? |#
#| A: Switch the zero? lines |#

(define bigger-than?
  (λ (n m)
    (cond
      ((zero? n) #f)
      ((zero? m) #t)
      (else (bigger-than? (sub1 n) (sub1 m))))))

(bigger-than? 3 3) ; ==> #f
 
#| Q: What is (smaller-than? 4 6) |#
#| A: True. |#

#| Q: What is (smaller-than? 8 3) |#
#| A: False. |#

#| Q:  What is (smaller-than? 8 3) |#
#| A: False. |#

#| Q: Now try to write smaller-than? |#
#| A: Ok. |#

(define smaller-than? 
  (λ (n m) 
    (cond 
      ((zero? m) #f) 
      ((zero? n) #t ) 
      (else (smaller-than? (sub1 n) (sub1 m)))))) 

(smaller-than? 5 4) ; ==> #f
(smaller-than? 4 5) ; ==> #t
(smaller-than? 4 4) ; ==> #f

; or, using bigger-than?
(define smaller-than??
  (λ (n m )
    (bigger-than? m n)))

(smaller-than?? 5 4) ; ==> #f
(smaller-than?? 4 5) ; ==> #t
(smaller-than?? 4 4) ; ==> #f

#| Q: Here is the definition of same-num? |#

(define same-num?
  (λ (n m)
    (cond
      ((zero? m) (zero? n))
      ((zero? n) #f)
      (else
       (same-num? (sub1 n) (sub1 m))))))

#| A: Ok. |#


#| Q: Rewrite same-size? using smaller-than? and bigger-than? |#
#| A: Ok. |#

(define same-num??
  (λ (n m)
    (cond
      ((or (smaller-than? n m)
           (bigger-than? n m)) #f)
      (else #t))))

;; Note: The book version doesn't use the or.

#| Q: Does this mean we have two different 
      functions for testing equality of atoms?|#
#| A: Yes, they are same-num? for atoms that are numbers and eq? for the others. |#

#| Q: (raise-to-power 1 1) |#
#| A: 1. |#

#| Q: (raise-to-power 2 3) |#
#| A: 8. |#

#| Q: (raise-to-power 5 3) |#
#| A: 125. |#

#| Q: Now write the function to-power
      Hint: See the The First and Fifth Commandments. |#
#| A: Ok. |#

(define raise-to-power
  (λ (n m)
    (cond
      ((zero? m) 1)
      (else (times n (raise-to-power n (sub1 m)))))))

(raise-to-power 1 1) ; ==> 1
(raise-to-power 2 3) ; ==> 8
(raise-to-power 5 3) ; ==> 125
(raise-to-power 4 4) ; ==> 256

#| Q: What is a good name for this function? 
(define ??? 
    (λ ( n m) 
      (cond 
        ((< n m) 0) 
        (else (add1 (??? (- n m) m)))))) |#
#| A: We have never seen this kind of definition 
      before; the natural recursion also looks strange. |#

#| Q: What does the first question check? |#
#| A: It checks if the first argument is smaller than the second. |#

#| Q: And what happens in the second line? |#
#| A: We recur with a first argument from which 
      we subtract the second argument. When the 
      function returns, we add 1 to the result. |#

#| Q: So what does the function do? |#
#| A: It counts how many times the first argument fits into the second argument. |#

#| Q: And what do we call this? |#
#| A: Division. |#

(define divide 
  (λ (n m) 
    (cond 
      ((< n m) 0) 
      (else (add1 (divide (- n m) m))))))

(divide 10 5) ; ==> 2
(divide 15 5) ; ==> 3
(divide 36 5) ; ==> 7
; Note: this is like the function quotient

#| Q: What is (+ 15 4) |#
#| A: It is 3. |#

#| Q: How do we get there? |#
#| A: (divide 15 4)
      ==> (+ 1 (divide 11 4)
      ==> (+ 1 (+  1 (divide 7 4))) 
      ==> (+ 1 (+ 1 (+ 1 (divide 3 4)))) 
      ==> (+ 1 (+ 1 (+ 1 0))) |#



#|        Wouldn't a (ham and cheese on rye) be good right now? 
                        Don't forget the mustard!                         |#



#| Q: What is the value of (length lat) where lat is
      (hotdogs with mustard sauerkraut and pickles)? |#
#| A: 6. |#

#| Q: What is (length lat) where lat is (ham and cheese on rye) |#
#| A: 5. |#

#| Q: Now try to write the function length. |#
#| A: Ok. |#

(define len
  (λ (lat)
    (cond
      ((null? lat) 0)
      (else (add1 (len (cdr lat)))))))

(len '(1 2 3 4 5)) ; ==> 5
(len '()) ; ==> 0

#| Q: What is (pick n lat) where n is 4 and lat is
      (lasagna spaghetti ravioli macaroni meatball) |#
#| A: macaroni. |#

#| Q: What is (pick 0 lat) where lat is (a) |#
#| A: No answer. |#

#| Q: Try to write the function pick. |#
#| A: Ok. |#

(define pick
  (λ (n lat)
    (cond
      ((zero? (sub1 n)) (car lat))
      (else (pick (sub1 n) (cdr lat))))))

(pick 4 '(lasagna spaghetti ravioli macaroni meatball)) ; ==> 'macaroni

; Book has the same solution

#| Q: What is (rempick n lat) where n is 3 and lat is (hotdogs with hot mustard) |#
#| A: (hotdogs with mustard) |#

#| Q: Now try to write rempick. |#
#| A: Ok. |#

(define rempick
  (λ (n lat)
    (cond
      ((zero? (sub1 n)) (cdr lat))
      (else
       (cons (car lat) (rempick (sub1 n) (cdr lat)))))))

(rempick 3 '(hotdogs with hot mustard))

#| Q: Is (number? a) true or false where a is tomato? |#
#| A: False. |#

#| Q: Is (number? 76) true or false? |#
#| A: True. |#

#| Q: Can you write number? which is true if its argument
      is a numeric atom and false if it is anything else? |#  
#| A: No: number?, like add1, sub1, zero?, car, cdr, cons,
      null?, eq?, and atom?, is a primitive function. |#

#| Q: Now using number? write the function no-nums which gives
      as a final value a lat obtained by removing all the numbers
      from the lat. For example, where lat is (5 pears 6 prunes 9 dates) 
      the value of (no-nums lat) is (pears prunes dates) |#
#| A: Ok. |#

(define no-nums
  (λ (lat)
    (cond
      ((null? lat) '())
      ((number? (car lat))
       (no-nums (cdr lat)))
      (else
       (cons (car lat) (no-nums (cdr lat)))))))

(no-nums '(5 pears 6 prunes 9 dates)) ; ==> '(pears prunes dates)

#| Book version is more verbose
(define no-nums 
    (λ (lat) 
      (cond 
        ((null? lat) '()) 
        (else (cond 
                ((number? (car lat)) 
                 (no-nums (cdr lat))) 
                (else (cons (car lat) 
                            (no-nums 
                             (cdr lat))))))))) |#

#| Q: Now write all-nums which extracts a tup from a lat using all the numbers in the lat. |#
#| A: Ok, I got this. |#

(define all-nums
  (λ (lat)
    (cond
      ((null? lat) '())
      ((number? (car lat))
       (cons (car lat) (all-nums (cdr lat))))
      (else (all-nums (cdr lat))))))

(all-nums '(5 pears 6 prunes 9 dates)) ; ==> '(5 6 9)

#| Book version is again a more verbose version
(define all-nums 
    (λ ( lat) 
      (cond 
        ((null? lat) '()) 
        (else 
         (cond 
           ((number? (car lat)) 
            (cons (car lat) 
                  (all-nums (cdr lat)))) 
           (else (all-nums (cdr lat)))))) |#

#| Q: Write the function eqan? which is true if its two arguments
      (a1 and a2) are the same atom. Remember to use same-num? for numbers
      and eq? for all other atoms. |#
#| A: Ok. Let's try this. |#

(define eqan?
  (λ (a1 a2)
    (cond
      ((and (number? a1)
            (number? a2)
            (same-num? a1 a2)) #t)
      ((or (number? a1)
           (number? a2)) #f)
      (else (eq? a1 a2)))))

(eqan? 'a 1) ; ==> #f
(eqan? 'a 'b) ; ==> #f
(eqan? 5 4) ; ==> #f
(eqan? 7 7) ; ==> #t
(eqan? 'a 'a) ; ==> #t

; Book solution is identical. 

#| Q: Can we assume that all functions written using eq? can be
      generalized by replacing eq? by eqan? |#
#| A: Yes, all but eqan? itself. |#

#| Q: Now write the function occur which counts the number of times
      an atom a appears in a lat. |#
#| A: Ok. |#

(define occur
  (λ (a lat)
    (cond
      ((null? lat) 0)
      ((eqan? a (car lat))
       (add1 (occur a (cdr lat))))
      (else (occur a (cdr lat))))))

(occur 'a '()) ; ==> 0
(occur 'a '(a b c d e)) ; ==> 1
(occur 'a '(a b c d a e)) ; ==> 2
(occur 'a '(a b c a d a e a a d a)) ; ==> 6

#| Book version is verbose as always and uses eq? instead of eqan?.
(define occur 
    (λ (a lat) 
      (cond 
        ((null? lat) 0) 
        (else 
         (cond 
           ((eq? (car lat) a) 
            (add1 (occur a (cdr lat)))) 
           (else (occur a (cdr lat)))))))) |#

#| Q: Write the function one? where (one? n) is #t if n is 1
      and #f (i.e. , false) otherwise. |#
#| A: Ok, will do. |#

(define one?
  (λ (n)
    (zero? (sub1 n))))

(one? 2) ; ==> #f
(one? 0) ; ==> #f
(one? 5466734) ; ==> #f
(one? 1) ; ==> #t

#| Book gives many verbose versions
(define one? 
    (λ (n) 
      (cond 
        ((zero ? n) #f) 
        (else (zero ? (sub1 n))))))

               OR

(define one? 
    (λ (n) 
      (cond 
        (else (same-num? n 1))))) |#

#| Q: Guess how we can further simplify this function, making it a one-liner.
      By removing the ( cond ... ) clause:
 (define one? 
    (λ (n) 
      (same-num? n 1))) |#

#| A: I already made a very similar one-liner version above using (zero? (sub1 n))! |#

#| Q: Now rewrite the function rempick that removes the nth atom from a lat.
      For example, where n is 3 and lat is (lemon meringue salty pie) the value
      of (rem pick n lat) is (lemon meringue pie) Use the function one? in your answer. |#
#| A: Ok, this is simple. |#

(define rempick.v2
  (λ (n lat)
    (cond
      ((one? n) (cdr lat))
      (else
       (cons (car lat) (rempick.v2 (sub1 n) (cdr lat)))))))

(rempick.v2 3 '(lemon meringue salty pie)) ; ==> '(lemon meringue pie)

#| Book version is identical to mine. |#