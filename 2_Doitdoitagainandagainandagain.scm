#lang racket

;; atom? : Any -> Boolean
;; Produces #true if input is an atom
(define atom? 
  (λ (x) 
    (and (not (pair? x)) (not (null? x)))))



#|     Do It, Do it Again, and Again, and Again...     |#



#| Q: True or false: (lat? l) where l is (Jack Sprat could eat no chicken fat) |#
#| A: True, b/c (Jack Sprat could eat no chicken fat) is a list of only atoms |#

#| Q: True or false: (lat ? l) where l is ((Jack) Sprat could eat no chicken fat) |#
#| A: False, b/c the first element in ((Jack) Sprat could eat no chicken fat) is the list (Jack) |#

#| Q: True or false: (lat? l) where l is (Jack (Sprat could) eat no chicken fat) |#
#| A: False, b/c (Jack (Sprat could) eat no chicken fat) contains the list (Sprat could) |#

#| Q: True or false: (lat ? l) where l is () |#
#| A: True, b/c l does not contain any number of lists |#
; Note: It is not entirely obvious to me why an empty list is considered a list of atoms.

#| Q: True or false: a lat is a list of atoms. |#
#| A: True |#
; Note: An empty or null list is also a list of atoms

#| Q: Write the function lat? using some, but not necessarily all, of the following functions: 
      car cdr cons null? atom? and eq? |#
#| A: From the book:
      "You were not expected to be able to do this 
      yet, because you are still missing some 
      ingredients. Go on to the next question. 
      Good luck."

      Below is my attempt, called list-of-atoms?, using some techniques not introduced yet. |#

;; list-of-atoms? : List-of-Anything -> Boolean
;; Given list, produces true if it only contains atoms
(define (list-of-atoms? l)
  (cond
    [(null? l) true]
    [else (if (atom? (car l))
              (list-of-atoms? (cdr l))
              false)]))

(list-of-atoms? '(Jack Sprat could eat no chicken fat)) ; ==> #t
(list-of-atoms? '((Jack) Sprat could eat no chicken fat)) ; ==> #f
(list-of-atoms? '(Jack (Sprat could) eat no chicken fat)) ; ==> #f
(list-of-atoms? '()) ; ==> #t



#|          Are you rested?          |#



;; lat? : List-of-Anything -> Boolean
;; Given list, produces true if it only contains atoms
(define lat? 
  (λ (l) 
    (cond 
      ((null? l) #t) 
      ((atom? (car l)) (lat? (cdr l))) 
      (else #f)))) 

#| Q: What is the value of (lat ? l) where l is the argument (bacon and eggs) |#
#| A: True, b/c the list (bacon and eggs) only contains atoms |#
(lat? '(bacon and eggs)) ; ==> #t

#| Q: How do we determine the answer #t for the application (lat ? l) |#
#| A: From the book:
      "You were not expected to know this one 
      either. The answer is determined by 
      answering the questions asked by lat? 
      Hint: Write down the definition of the 
      function lat? and refer to it for the next 
      group of questions. "

      My answer: First we check if the list is null, if yes, then #t.
      If the list is not null, we look at the first element. If that is
      an atom, then we proceed to repeat this process for the remaining part
      of the list. If we get to the end of the list, that is, to an empty
      list, we get #t. In any other case we get #f |#

#| Q: What is the first question asked by (lat? l) |#
#| A: First question is: Is the list l null? (null? l) |#

#| Q: What is the meaning of the cond-line ((null? l) #t) where l is (bacon and eggs)|#
#| A: This line sets up a conditional where we first ask if the list l is null. If the
      (null? l) question returns #t then the whole function returns #t. If (null? l)
      returns #f we continue to the next question. In this case (null? (bacon and eggs))
      returns #f and we continue onwards. |#
(null? '(bacon and egss)) ;  ==> #f

#| Q: What is the next question? |#
#| A: The next question is: Is the first expression in l an atom? (atom? (car l)).|#

#| Q: What is the meaning of the line ((atom? (car l)) (lat? (cdr l))) where l is (bacon and eggs) |#
#| A: This part first asks if the first expression of l is an atom. If this returns #t then
      we proceed to repeat the lat? function using the remaining part of l (cdr l). If the first
      expression is not an atom, we proceed to the next question. In this case (atom? (car l))
      returns #t and we continue to (lat? (and eggs)) |#

#| Q: What is the meaning of (lat? (cdr l)) |#
#| A: Ths asks if the remaining part of l is a list of atoms |#

#| Q: Now what is the argument l for lat ? |#
#| A: The argument is (cdr l) and therefore (and eggs) |#
(cdr '(bacon and eggs)) ; ==> '(and eggs)

#| Q: What is the next question? |#
#| A: If we reach the next part in the conditional, the function returns #f.
      However; In the case of (lat? (bacon and eggs)) we start from the beginning
      with (and eggs) so the next question is (null? l) |#

#| Q: What is the meaning of the line ((null? l) #t) where l is now (and eggs)|#
#| A: This is the same as before. We first ask if the list l is null. If the
      (null? l) question returns #t then the whole function returns #t. If (null? l)
      returns #f we continue to the next question. In this case (null? (and eggs))
      returns #f and we continue onwards. |#
(null? '(and eggs)) ; ==> #f

#| Q: What is the next question? |#
#| A: (atom? (car l)) |#

#| Q: What is the meaning of the line ((atom? (car l)) (lat? (cdr l))) where l is (and eggs) |#
#| A: This is the same as before. We ask if the first expression of l is an atom. If this returns #t then
      we proceed to repeat the lat? function using the remaining part of l (cdr l). If the first
      expression is not an atom, we proceed to the next question. In this case (atom? (car (and eggs)))
      returns #t and we continue to (lat? (eggs)) |#

#| Q: What is the meaning of (lat? (cdr l)) |#
#| A: This asks if the remaining part of the list is a list of atoms using the function lat?.
      In this case, the remaining list is (eggs) |#

#| Q: What is the next question? |#
#| A: (null? l) |#

#| Q: What is the meaning of the line ((null? l) #t where l is now (eggs) |#
#| A: This is the same as before. We first ask if the list l is null. If the
      (null? l) question returns #t then the whole function returns #t. If (null? l)
      returns #f we continue to the next question. In this case (null? (eggs))
      returns #f and we continue onwards. |#
(null? '(eggs)) ; ==> #f

#| Q: What is the next question? |#
#| A: (atom? (car l))|#

#| Q: What is the meaning of the line ((atom? (car l)) (lat? (cdr l))) where l is now (eggs) |#
#| A: This is the same as before. We ask if the first expression of l is an atom. If this returns #t then
      we proceed to repeat the lat? function using the remaining part of l (cdr l). If the first
      expression is not an atom, we proceed to the next question. In this case (atom? (car (eggs)))
      returns #t and we continue to (lat? (cdr (eggs))) |#

#| Q: What is the meaning of (lat ? (cdr l)) |#
#| A: This asks if the remaining part of l is a list of atoms using the function lat?.
      In this case, the remaining list is () |#

#| Q: Now, what is the argument for lat ? |#
#| A: () |#

#| Q: What is the meaning of the line ((null ? l) #t) where l is now () |#
#| A: This is the same as before. We first ask if the list l is null. If the
      (null? l) question returns #t then the whole function returns #t. If (null? l)
      returns #f we continue to the next question. In this case (null? ())
      returns #t and the whole function returns #t. |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#



