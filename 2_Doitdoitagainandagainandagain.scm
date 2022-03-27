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

      Below are two of my attempts, called list-of-atoms? and
      list-of-atoms2? (very similar), using some techniques not introduced yet. |#

;; list-of-atoms? : List-of-Anything -> Boolean
;; Given list, produces true if it only contains atoms
(define (list-of-atoms? l)
  (cond
    ((null? l) #t)
    (else (if (atom? (car l))
              (list-of-atoms? (cdr l))
              #f))))

(define (list-of-atoms2? l)
  (cond
    ((null? l) #t)
    (else (and (atom? (car l))
               (list-of-atoms2? (cdr l))))))

(list-of-atoms? '(Jack Sprat could eat no chicken fat)) ; ==> #t
(list-of-atoms? '((Jack) Sprat could eat no chicken fat)) ; ==> #f
(list-of-atoms? '(Jack (Sprat could) eat no chicken fat)) ; ==> #f
(list-of-atoms? '()) ; ==> #t

(list-of-atoms2? '(Jack Sprat could eat no chicken fat)) ; ==> #t
(list-of-atoms2? '((Jack) Sprat could eat no chicken fat)) ; ==> #f
(list-of-atoms2? '(Jack (Sprat could) eat no chicken fat)) ; ==> #f
(list-of-atoms2? '()) ; ==> #t



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

#| Q: Is (member? a lat) true or false where a is poached and lat is (fried eggs and scrambled eggs) |#
#| A: False, b/c poached is not an atom in the list (fried eggs and scrambled eggs) |#

;; member? : Atom LAT -> Boolean
;; Given atom and lat, produces true if atom is found in the lat
(define member? 
  (λ (a lat) 
    (cond 
      ((null? lat) #f) 
      (else (or (eq? (car lat) a) 
                (member? a (cdr lat))))))) 

#| Q: What is the value of (member? a lat) where a is meat and lat is (mashed potatoes and meat gravy) |#
#| A: True, b/c the atom meat is found in the lat (mashed potatoes and meat gravy) |#
(member? 'meat '(mashed potatoes and meat gravy)) ; ==> #t

#| Q: How do we determine the value #t for the above application? |#
#| A: We first ask if the lat is null. If it is not null, we ask if either the first element
      in the list is the one we look for (returning #t) or repeating the application from the beginning
      with the remaining list returns #t |#

#| Q: What is the first question asked by (member? a lat) |#
#| A: (null? lat) |#



#|          *** The First Commandment ***
                     (preliminary) 
                    Always ask null?
          as the first question in expressing 
                     any function.                   |#



#| Q: What is the meaning of the line ((null? lat) #f) where lat is (mashed potatoes and meat gravy) |#
#| A: This line asks if the list l is null. If it is null, the application returns #f. If l is not
      null, then the function proceeds to the next question. In this case (null? l) is #f and we
      continue on to the next question |#
(null? '(mashed potatoes and meat gravy)) ; ==> #f

#| Q: What is the next question? |#
#| A: else |#

#| Q: Why is else the next question? |#
#| A: All other needed questions are containded inside the following else question. |#

#| Q: Is else really a question? |#
#| A: Yes, apparently it is. It is a question that always returns true |#

#| Q: What is the meaning of the line
     (else (or (eq? (car lat) a) 
               (member? a (cdr lat)))) |#
#| A: This line asks if the first expression in lat is the same as the atom we look for or
      if the atom is a member of the remaining part of the list |#

#| Q: True or false: 
       (or (eq? (car lat) a) 
           (member? a  (cdr lat)))
      where a is meat and lat is (mashed potatoes and meat gravy) |#
#| A: True, b/c meat is an expression in the list (mashed potatoes and meat gravy) |#
(or (eq? (car '(mashed potatoes and meat gravy)) 'meat) 
    (member? 'meat  (cdr '(mashed potatoes and meat gravy)))) ; ==> #t

#| Q: Is (eq? (car lat) a) true or false where a is meat and lat is (mashed potatoes and meat gravy) |#
#| A: False, b/c mashed is not the same as meat |#
(car '(mashed potatoes and meat gravy)) ; ==> 'mashed
(eq? 'mashed 'meat) ; ==> #f
(eq? (car '(mashed potatoes and meat gravy)) 'meat) ; ==> #f

#| Q: What is the second question of (or ...) |#
#| A: (member? a (cdr lat)), which asks if a is a member of the remaining part of lat |#

#| Q: Now what are the arguments of member? |#
#| A: a and (cdr lat), which are meat and (potatoes and meat gravy) |#

#| Q: What is the next question |#
#| A: (null? lat) * rememeber the first commandment * |#

#| Q: Is (null? lat) true or false where lat is (potatoes and meat gravy) |#
#| A: False, b/c (potatoes and meat gravy) is not an null list |#

#| Q: What do we do now |#
#| A: Ask the next question |#

#| Q: What is the next question |#
#| A: else |#

#| Q: What is the meaning of
      (or (eq? (car lat) a) 
          (member? a (cdr lat)))|#
#| A: This is to find out if the first expression in the list is the atom we are looking for
      or if the atom is an expression in the remaining part of the list |#

#| Q: Is a eq? to the car of lat |#
#| A: False, b/c meat does not equal potatoes |#

#| Q: So what do we do next? |#
#| A: We ask the next question, which is: is meat a member of (and meat gravy)?
      (member? meat (and meat gravy)) |#

#| Q: What is the next question? |#
#| A: (null? lat) |#

#| Q: What do we do now? |#
#| A: (null? lat) returns #f, so we continue to the next question |#

#| Q: What is the next question? |#
#| A: else |#

#| Q: What is the value of
      (or (eq? (car lat) a) 
          (member? a (cdr lat))) |#
#| A: because (eq? (car (and meat gravy)) meat) returns #f, the value becomes
      the value of (member? meat (cdr (and meat gravy))) |#

#| Q: Why? |#
#| A: See above. B/c (eq? (car (and meat gravy)) meat) returns #f |#
(eq? (car '(and meat gravy)) 'meat) ; ==> #f

#| Q: What do we do now? |#
#| A: Run member? with new arguments - Recur |#

#| Q: What are the new arguments? |#
#| A: meat and (meat gravy) |#

#| Q: What is the next question? |#
#| A: (null? lat) |#

#| Q: What do we do now? |#
#| A: (null? (meat gravy)) returns #f, so we continue to the next question |#

#| Q: What is the next question? |#
#| A: else |#

#| Q: What is the value of 
      (or (eq? (car lat) a) 
          (member? a (cdr lat))) |#
#| A: True, b/c (eq? (car (meat gravy) meat) returns #t |#
 (car '(meat gravy)) ; ==> 'meat
 (eq? 'meat 'meat) ; ==> #t

#| Q: What is the value of the application (member? a lat) where a is meat and lat is (meat gravy) |#
#| A: True, because meat is a member of the list (meat gravy) |#

#| Q: What is the value of the application (member? a lat) where a is meat and lat is (and meat gravy) |#
#| A: True, because meat is a member of the list (and meat gravy) |#

#| Q: What is the value of the application (member? a lat) where a is meat and
      lat is (potates and meat gravy) |#
#| A: True, because meat is a member of the list (potatoes and meat gravy) |#

#| Q: What is the value of the application (member? a lat) where a is meat and
      lat is (mashed potates and meat gravy) |#
#| A: True, because meat is a member of the list (mashed potatoes and meat gravy).
      Note that this is our original lat. |#

#| Q: Just to make sure you have it right, let's quickly run through it again.
      What is the value of the application (member? a lat) where a is meat and
      lat is (mashed potates and meat gravy) |#
#| A: True |#

#| Q: (null? lat) |#
#| A: False. Move to the next question. |#

#| Q: else|#
#| A: True |#

#| Q: (or (eq? (car lat) a) 
          (member? a (cdr lat))) |#
#| A: Let's see one expression at a time |#

#| Q: (eq? (car lat) a) |#
#| A: False. Go to the next question. |#

#| Q: What next? |#
#| A: Recur with a and (cdr lat) where a is meat and (cdr lat) is (potatoes and meat gravy). |#

#| Q: (null? lat) |#
#| A: False. Move to the next question. |#

#| Q: else |#
#| A: True, but b/c (eq? (car lat) a) returns #f, we recur member? again with new arguments
      where a is meat and (cdr lat) is (and meat gravy). |#

#| Q: (null? lat) |#
#| A: False. Move to the next question. |#

#| Q: else |#
#| A: True, but b/c (eq? (car lat) a) returns #f, we recur member? again with new arguments
      where a is meat and (cdr lat) is (meat gravy). |#

#| Q: (null? lat) |#
#| A: False. Move to the next question. |#

#| Q: (eq? (car lat) a) |#
#| A: True |#
(eq? (car '(meat gravy)) 'meat) ; ==> #t

#| Q: (or (eq? (car lat) a) 
          (member? a (cdr lat))) |#
#| A: True |#

#| Q: What is the value of (member? a lat) where a is meat and lat is (meat gravy) |#
#| A: True |#

#| Q: What is the value of (member? a lat) where a is meat and lat is (and meat gravy) |#
#| A: True |#

#| Q: What is the value of (member? a lat) where a is meat and lat is (potatoes and meat gravy) |#
#| A: True |#

#| Q: What is the value of (member? a lat) where a is meat and lat is (mashed potatoes and meat gravy) |#
#| A: True |#

#| Q: What is the value of (member? a lat) where a is liver and lat is (bagels and lox) |#
#| A: False |#
(member? 'liver '(bagels and lox)) ; ==> #f

#| Q: Let's work out why it is #f. What's the first question member? asks?|#
#| A: (null? lat) |#

#| Q: (null? lat) |#
#| A: (null? (bagels and lox)) is #f, so we continue to the next question |#
(null? '(bagels and lox)) ; ==> #f

#| Q: else |#
#| A: True, but (eq? (car lat) a) is #f so we recur with (member? a (cdr lat))
      where a is liver and lat in (cdr lat) is (and lox) |#
(eq? (car '(bagels and lox)) 'liver) ; ==> #f

#| Q: (null? lat) |#
#| A: (null? (and lox)) is #f, so we continue to the next question |#
(null? '(and lox))  ; ==> #f

#| Q: else |#
#| A: True, but (eq? (car lat) a) is #f so we recur with (member? a (cdr lat))
      where a is liver and lat in (cdr lat) is (lox) |#
(eq? (car '(and lox)) 'liver) ; ==> #f

#| Q: (null? lat) |#
#| A: (null? (lox)) is #f, so we continue to the next question |#
(null? '(lox)) ; ==> #f

#| Q: else |#
#| A: True, but (eq? (car lat) a) is #f so we recur with (member? a (cdr lat))
      where a is liver and lat in (cdr lat) is () |#
(eq? (car '(lox)) 'liver) ; ==> #f

#| Q: (null? lat) |#
#| A: (null? ()) is #t, so the application returns #f |#
(null? '()) ; ==> #t

#| Q: What is the value of (member? a lat) where a is liver and lat is () |#
#| A: False |#
(member? 'liver '()) ; ==> #f

#| Q: What is the value of 
      (or (eq? (car lat) a) 
          (member? a (cdr lat))) 
      where a is liver and lat is (lox) |#
#| A: False |#
(or (eq? (car '(lox)) 'liver)
    (member? 'liver (cdr '(lox)))) ; ==> #f

#| Q: What is the value of (member? a lat) where a is liver and lat is (lox) |#
#| A: False |#
(member? 'liver '(lox)) ; ==> #f

#| Q: What is the value of
      (or (eq? (car lat) a) 
          (member? a (cdr lat)))
      where a is liver and lat is (and lox) |#
#| A: False |#
(or (eq? (car '(and lox)) 'liver)
    (member? 'liver (cdr '(and lox)))) ; ==> #f

#| Q: What is the value of (member? a lat) where a is liver and lat is (and lox) |#
#| A: False |#
(member? 'liver '(and lox)) ; ==> #f

#| Q: What is the value of
      (or (eq? (car lat) a) 
          (member? a (cdr lat)))
      where a is liver and lat is (bagels and lox) |#
#| A: False |#
(or (eq? (car '(bagels and lox)) 'liver)
    (member? 'liver (cdr '(bagels and lox)))) ; ==> #f

#| Q: What is the value of (member? a lat) where a is liver and lat is (bagels and lox) |#
#| A: False |#
(member? 'liver '(bagels and lox)) ; ==> #f


































#|          *** This space for doodling ***          |#