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

#| Q: What is the meaning of the cond-line ((null? l) #t) where l is (bacon and eggs) |#
#| A: This line sets up a conditional where we first ask if the list l is null. If the
      (null? l) question returns #t then the whole function returns #t. If (null? l)
      returns #f we continue to the next question. In this case (null? (bacon and eggs))
      returns #f and we continue onwards. |#
(null? '(bacon and egss)) ;  ==> #f

#| Q: What is the next question? |#
#| A: The next question is: Is the first expression in l an atom? (atom? (car l)). |#

#| Q: What is the meaning of the line ((atom? (car l)) (lat? (cdr l))) where l is (bacon and eggs) |#
#| A: This part first asks if the first expression of l is an atom. If this returns #t then
      we proceed to repeat the lat? function using the remaining part of l (cdr l). If the first
      expression is not an atom, we proceed to the next question. In this case (atom? (car l))
      returns #t and we continue to (lat? (and eggs)) |#

#| Q: What is the meaning of (lat? (cdr l)) |#
#| A: This asks if the remaining part of l is a list of atoms |#

#| Q: Now what is the argument l for lat ? |#
#| A: The argument is (cdr l) and therefore (and eggs) |#
(cdr '(bacon and eggs)) ; ==> '(and eggs)

#| Q: What is the next question? |#
#| A: If we reach the next part in the conditional, the function returns #f.
      However; In the case of (lat? (bacon and eggs)) we start from the beginning
      with (and eggs) so the next question is (null? l) |#

#| Q: What is the meaning of the line ((null? l) #t) where l is now (and eggs) |#
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
(null? '()) ; ==> #t

#| Q: Do you remember the question about (lat ? l) |#
#| A: No. Probably not. The application (lat? l) has the value #t if the list l is a
      list of atoms where l is (bacon and eggs) |#

#| Q: Can you describe what the function lat? does in your own words? |#
#| A: The function lat? tests if a list is a list of atoms by first testing if it
      is empty. If yes, then it returns #t. If it is not empty, it checks if the first
      element is an atom. If this is true, then it repeats lat+ with the remaining list.
      If the first element is not an atom, lat? return #f. If lat? reaches the end of the
      list, which is a null list, it returns #t meaning that the list was indeed a list
      of atoms

     From the book:
     "Here are our words: lat? looks at each S-expression in a list, in 
      turn, and asks if each S-expression is an atom, until it runs out
      of S-expressions. If it runs out without encountering a list, the 
      value is #t. If it finds a list, the value is #f. 

      To see how we could arrive at a value of #f, consider the next few questions." |#

#| Q: What is the value of (lat? l) where l is now (bacon (and eggs))|#
#| A: False, b/c l contains a list |#
(lat? '(bacon (and eggs))) ; ==> #f

#| Q: What is the first question? |#
#| A: (null? l) |#

#| Q: What is the meaning of the line ((null? l) #t) where l is (bacon (and eggs)) |#
#| A: This line asks if the list l is null list. If it is null, the application returns #t,
      and if it is #f in continues to the next question. In this case (null? (bacon (and eggs)))
      returns #f and the application continues onwards |#
(null? '(bacon (and eggs))) ; ==> #f

#| Q: What is the next question? |#
#| A: (atom? (car l)) |#

#| Q: What is the meaning of the line ((atom? (car l)) (lat? (cdr l))) where l is (bacon (and eggs))|#
#| A: This line first asks if the first expression in l is an atom. If this returns #t then the function
      lat? is repeated with the remaining part of the list, otherwise we continues to the next question.
      In this case (atom? (car l) returns #t and therefore lat? is repeated with (cdr l) to see if
      the remaining list is also composed only of atoms |#
(atom? (car '(bacon (and eggs)))) ; ==> #t

#| Q: What is the meaning of (lat? (cdr l)) |#
#| A: (lat? (cdr l)) asks if the rest of the list l is a list of atoms |#

#| Q: What is the meaning of the line ((null? l) #t) where l is now ((and eggs)) |#
#| A: ((null? l) #t) first asks is l is a null list. It it is null, then the application results
      in #t. If l in not a null list the application continues to the next question. In this case
      (null? ((and eggs))) results in #f and we continue onwards |#
(null? '((and eggs))) ; ==> #f

#| Q: What is the next question? |#
#| A: (atom? (car l)) |#

#| Q: What is the meaning of the line ((atom? (car l)) (lat? (cdr l))) where l is now ((and eggs)) |#
#| A: This line first checks if the first expression in l is an atom. If this returns true, the function
      lat? is repeated with the remaining list (cdr l). If (atom? (car l)) returns #f, the application
      continues to the conditional step. In this case, (atom? ((and eggs))) returns #f and we continue
      to the next conditional step |#
(atom? '((and eggs))) ; ==> #f

#| Q: What is the next question? |#
#| A: else |#

#| Q: What is the meaning of the question else |#
#| A: else asks if else is true. This is the final possible answer when all others have failed |#

#| Q: Is else true? |#
#| A: Yes, else is always true |#

#| Q: else |#
#| A: True |#

#| Q: Why is else the last question? |#
#| A: Because it is the only remaining one. No need to ask any more questions |#

#| Q: Why do we not need to ask any more questions? |#
#| A: Because we have depleted all possibilities: a null-list and a list with an atom at the start.
      The only remaining possibility is that the first element is a list. Therefore else. |#

#| Q: What is the meaning of the line (else #f)|#
#| A: This line asks if else returns #t and if it does, the application returns #f. else always
      returns #t, so the application returns #f |#

#| Q: What is ))) |#
#| A: These are closing parentheses of define, λ and cond |#

#| Q: Can you describe how we determined the value #f for (lat? l) where l is (bacon (and eggs))|#
#| A: We first determined that l is not empty. Then we determined that the first expression is an atom.
      We then repeated lat? with the rest of l and saw that it is not emtpy. Then we asked if the first
      expression is an atom. We saw that it is (and eggs), which is a list not an atom; therefore,
      the application resulted in #f |#

#| Q: Is (or (null? l1 ) (atom? l2)) true or false where l1 is () and l2 is (d e f g) |#
#| A: True, b/c l1 is () (null? ()) is #t |#
(or (null? '() ) (atom? '(d e f g))) ; ==> #t

#| Q: Is (or (null? l1) (null? l2)) true or false where l1 is (a b c) and l2 is () |#
#| A: True, b/c l2 is () (null? ()) is true |#
(or (null? '(a b c)) (null? '())) ; ==> #t

#| Q: Is (or (null? l1) (null? l2)) true or false where l1 is (a b c) and l2 is (atom) |#
#| A: False, b/c both (null? l1) and (null? l2) return #f |#
(null? '(a b c)) ; ==> #f
(null? '(atom)) ; ==> #f
(or (null? '(a b c)) (null? '(atom))) ; ==> #f

#| Q: What does (or ... ) do? |#
#| A: It evaluates the expressions inside one-by-one and returns #t if it finds a #t, else it returns #f |#

#| Q: Is it true or false that a is a member of lat where a is tea and lat is (coffee tea or milk) |#
#| A: True, b/c tea is an expression in the list (coffee tea or milk) |#

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




