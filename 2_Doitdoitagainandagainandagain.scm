#lang racket/base

(provide lat? member?)

(require (only-in "Atom.scm" atom?))

(module+ test
  (require rackunit))




#|     Do It, Do it Again, and Again, and Again...     |#



#| Q: True or false: (lat? l) where l is (Jack Sprat could eat no chicken fat) |#
#| A: True, because each S-expression in l is an atom. |#

#| Q: True or false: (lat ? l) where l is ((Jack) Sprat could eat no chicken fat) |#
#| A: False, since ( car l) is a list. |#

#| Q: True or false: (lat? l) where l is (Jack (Sprat could) eat no chicken fat) |#
#| A: False, since one of the S-expressions in l is a list. |#

#| Q: True or false: (lat ? l) where l is () |#
#| A: True, because it does not contain a list. |#

; Note: It is not entirely obvious to me why an empty list is considered a list of atoms.

#| Q: True or false: a lat is a list of atoms. |#
#| A: True! Every lat is a list of atoms! |#

#| Q: Write the function lat? using some, but not necessarily all, of the
      following functions: car cdr cons null? atom? and eq? |#
#| A: From the book:
      "You were not expected to be able to do this 
      yet, because you are still missing some 
      ingredients. Go on to the next question. 
      Good luck."

      Below are my attempts, called list-of-atoms? 1-2-3 (very similar),
      using some techniques not introduced yet. |#

;; list-of-atoms? : List-of-X -> Boolean
;; Produces true if lox only contains atoms
(define (list-of-atoms1? l)
  (cond
    ((null? l) #t)
    (else (if (atom? (car l))
              (list-of-atoms1? (cdr l))
              #f))))

; Using 'and' instead of 'if with else'
(define (list-of-atoms2? l)
  (cond
    ((null? l) #t)
    (else (and (atom? (car l))
               (list-of-atoms2? (cdr l))))))

; full λ style
(define list-of-atoms3?
  (λ (l)
    (cond
      ((null? l) #t)
      (else
       (and (atom? (car l))
            (list-of-atoms3? (cdr l)))))))

(module+ test
  (check-true (list-of-atoms1? '(Jack Sprat could eat no chicken fat))) 
  (check-false (list-of-atoms1? '((Jack) Sprat could eat no chicken fat)))
  (check-false (list-of-atoms1? '(Jack (Sprat could) eat no chicken fat)))
  (check-true (list-of-atoms1? '()))

  (check-true (list-of-atoms2? '(Jack Sprat could eat no chicken fat))) 
  (check-false (list-of-atoms2? '((Jack) Sprat could eat no chicken fat)))
  (check-false (list-of-atoms2? '(Jack (Sprat could) eat no chicken fat)))
  (check-true (list-of-atoms2? '()))

  (check-true (list-of-atoms3? '(Jack Sprat could eat no chicken fat))) 
  (check-false (list-of-atoms3? '((Jack) Sprat could eat no chicken fat)))
  (check-false (list-of-atoms3? '(Jack (Sprat could) eat no chicken fat)))
  (check-true (list-of-atoms3? '())))



#|          Are you rested?          |#



;; lat? : List-of-X -> Boolean
;; Produces true if lox only contains atoms
(define lat? 
  (λ (l) 
    (cond 
      ((null? l) #t) 
      ((atom? (car l)) (lat? (cdr l))) 
      (else #f)))) 

#| Q: What is the value of (lat? l) where l is the argument (bacon and eggs) |#
#| A: True. The application (lat? l) where l is (bacon and eggs) 
      has the value #t --true-- because l is a lat. |#
(module+ test
  (check-true (lat? '(bacon and eggs))))

#| Q: How do we determine the answer #t for the application (lat? l) |#
#| A: From the book:
      "You were not expected to know this one 
      either. The answer is determined by 
      answering the questions asked by lat? 
      Hint: Write down the definition of the 
      function lat? and refer to it for the next 
      group of questions. "

      My answer: First we check if the list is null, if yes, then the answer is #t.
      If the list is not null, we look at the first element. If that is
      an atom, then we proceed to repeat this process for the remaining part
      of the list. If we get to the end of the list - that is - to an empty
      list, we get #t. In any other case we get #f. |#

#| Q: What is the first question asked by (lat? l) |#
#| A: (null? l) 
       Note: 
      (cond ...) asks questions; 
      (lambda ...) creates a function; and 
      (define ...) gives it a name. |#

#| Q: What is the meaning of the cond-line ((null? l) #t) where l is (bacon and eggs) |#
#| A: (null? l) asks if the argument l is the null list. If it is, the value of the application is 
      true. If it is not, we ask the next question. In this case, l is not the null list,
      so we ask the next question. |#
(module+ test
  (check-false (null? '(bacon and egss))))

#| Q: What is the next question? |#
#| A: (atom? (car l)). |#

#| Q: What is the meaning of the line ((atom? (car l)) (lat? (cdr l))) where l is (bacon and eggs) |#
#| A: (atom? (car l)) asks if the first S-expression of the list l is an atom. If (car l) is an
      atom, we want to know if the rest of l is also composed only of atoms. If (car l) is not
      an atom, we ask the next question. In this case, (car l) is an atom, so the value of the 
      function is the value of (lat? (cdr l)). |#

#| Q: What is the meaning of (lat? (cdr l)) |#
#| A: (lat? (cdr l)) finds out if the rest of the list l is composed only of atoms,
      by referring to the function with a new argument.  |#

#| Q: Now what is the argument l for lat? |#
#| A: Now the argument l is (cdr l), which is (and eggs). |#
(module+ test
  (check-equal? (cdr '(bacon and eggs)) '(and eggs)))

#| Q: What is the next question? |#
#| A: (null? l) |#

#| Q: What is the meaning of the line ((null? l) #t) where l is now (and eggs) |#
#| A: (null? l) asks if the argument l is the null list. If it is, the value of
      the application is #t . If it is not, we ask the next question. In this case,
      l is not the null list, so we ask the next question. |#
(module+ test
  (check-false (null? '(and eggs))))

#| Q: What is the next question? |#
#| A: (atom? (car l)) |#

#| Q: What is the meaning of the line ((atom? (car l)) (lat? (cdr l))) where l is (and eggs) |#
#| A: (atom? (car l)) asks if (car l) is an atom. If it is an atom, the value of the application
      is (lat? (cdr l)). If not, we ask the next question. In this case, (car l) is an atom, so 
      we want to find out if the rest of the list l is composed only of atoms. |#
(module+ test
  (check-true (atom? (car '(and eggs))))) 

#| Q: What is the meaning of (lat? (cdr l)) |#
#| A: (lat? (cdr l)) finds out if the rest of l is composed only of atoms, by referring again 
      to the function lat?, but this time, with the argument (cdr l), which is (eggs). |#

#| Q: What is the next question? |#
#| A: (null? l) |#

#| Q: What is the meaning of the line ((null? l) #t) where l is now (eggs) |#
#| A: (null? l) asks if the argument l is the null list. If it is, the value of the application
      is #t --true. If it is not, move to the next question. In this case, l is not null, so we
      ask the next question. |#
(module+ test
  (check-false (null? '(eggs))))

#| Q: What is the next question? |#
#| A: (atom? (car l)). |#

#| Q: What is the meaning of the line ((atom? (car l)) (lat? (cdr l))) where l is now (eggs) |#
#| A: (atom? (car l)) asks if (car l) is an atom. If it is, the value of the application is 
      (lat? (cdr l)). If (car l) is not an atom, ask the next question. In this case, (car l)
      is an atom, so once again we look at (lat? (cdr l)). |#

#| Q: What is the meaning of (lat? (cdr l)) |#
#| A: (lat? (cdr l)) finds out if the rest of the list l is composed only of atoms, by referring
      to the function lat?, with l becoming the value of (cdr l). |#

#| Q: Now, what is the argument for lat? |#
#| A: () |#

#| Q: What is the meaning of the line ((null? l) #t) where l is now () |#
#| A: (null? l) asks if the argument l is the null list. If it is, the value of the application
      is the value of #t . If not, we ask the next question. In this case, () is the null list.
      So, the value of the application (lat? l) where l is (bacon and eggs), is #t --true. |#
(module+ test
  (check-true (null? '())))

#| Q: Do you remember the question about (lat? l) |#
#| A: Probably not. The application (lat? l) has the value #t if the list l is a
      list of atoms where l is (bacon and eggs). |#

#| Q: Can you describe what the function lat? does in your own words? |#
#| A: The function lat? tests if a list is a list of atoms by first testing if it
      is empty. If yes, then it returns #t. If it is not empty, lat? checks if the first
      element is an atom. If this is true, then lat? is called with the remaining list.
      If the first element is not an atom, lat? returns #f. If lat? reaches the end of the
      list, which is a null list, it returns #t, meaning the list was a list of atoms.

     From the book:
     "Here are our words: lat? looks at each S-expression in a list, in 
      turn, and asks if each S-expression is an atom, until it runs out
      of S-expressions. If it runs out without encountering a list, the 
      value is #t. If it finds a list, the value is #f. 

      To see how we could arrive at a value of #f, consider the next few questions." |#

#| Q: Here is the function lat? again:

      ;; lat? : List-of-X -> Boolean
      ;; Produces true if lox only contains atoms
      (define lat? 
        (λ (l) 
          (cond 
            ((null? l) #t) 
            ((atom? (car l)) (lat? (cdr l))) 
            (else #f))))

      What is the value of (lat? l) where l is now (bacon (and eggs)) |#

#| A: #f, since the list l contains an S-expression that is a list. |#
(module+ test
  (check-false (lat? '(bacon (and eggs)))))

#| Q: What is the first question? |#
#| A: (null? l). |#

#| Q: What is the meaning of the line ((null? l) #t) where l is (bacon (and eggs)) |#
#| A: (null? l) asks if l is the null list. If it is, the value is #t . If l is not null,
       move to the next question. In this case, it is not null, so we ask the next question. |#
(module+ test
  (check-false (null? '(bacon (and eggs)))))  

#| Q: What is the next question? |#
#| A: (atom? (car l)). |#

#| Q: What is the meaning of the line ((atom? (car l)) (lat? (cdr l))) where l is (bacon (and eggs)) |#
#| A: (atom? (car l)) asks if (car l) is an atom. If it is, the value is (lat? (cdr l)).
      If it is not, we ask the next question. In this case, (car l) is an atom, so we want to
      check if the rest of the list l is composed only of atoms. |#
(module+ test
  (check-true (atom? (car '(bacon (and eggs))))))

#| Q: What is the meaning of (lat? (cdr l)) |#
#| A: (lat? (cdr l)) checks to see if the rest of the list l is composed only of atoms,
      by referring to lat? with l replaced by (cdr l). |#

#| Q: What is the meaning of the line ((null? l) #t) where l is now ((and eggs)) |#
#| A: (null? l) asks if l is the null list. If it is null, the value is #t. If it is
      not null, we ask the next question. In this case, l is not null, so move to the next question. |#
(module+ test
  (check-false (null? '((and eggs)))))

#| Q: What is the next question? |#
#| A: (atom? (car l)). |#

#| Q: What is the meaning of the line ((atom? (car l)) (lat? (cdr l))) where l is now ((and eggs)) |#
#| A: (atom? (car l)) asks if (car l) is an atom. If it is, the value is (lat ? (cdr l)).
      If it is not, we move to the next question. In this case, (car l) is not an atom,
      so we ask the next question. |#
(module+ test
  (check-false (atom? '((and eggs)))))

#| Q: What is the next question? |#
#| A: else. |#

#| Q: What is the meaning of the question else |#
#| A: else asks if else is true. |#

#| Q: Is else true? |#
#| A: Yes, because the question else is always true! |#

#| Q: else |#
#| A: Of course. |#

#| Q: Why is else the last question? |#
#| A: Because we do not need to ask any more questions. |#

#| Q: Why do we not need to ask any more questions? |#
#| A: Because a list can be empty, can have an atom in the first position, or can have a list 
      in the first position. |#

#| Q: What is the meaning of the line (else #f) |#
#| A: else asks if else is true. If else is true --as it always is-- then the answer is #f --false. |#

#| Q: What is ))) |#
#| A: These are the closing or matching parentheses of
      (cond ... ,
      (λ ... , and 
      (define ... ,
      which appear at the beginning of a function definition.  |#

#| Q: Can you describe how we determined the value #f for (lat? l) where l is (bacon (and eggs)) |#
#| A: We first determined that l is not empty. Then we determined that the first expression is
      an atom. We then repeated lat? with the rest of l and saw that it is not emtpy. Then we
      asked if the first expression is an atom. We saw that it is (and eggs), which is a list
      not an atom; therefore, the application resulted in #f.

     Here is one way to say it: "(lat? l) looks at each item in its argument to see if it is an atom.
     If it runs out of items before it finds a list, the value of (lat? l) is #t. If it finds a list,
     as it did in the example (bacon (and eggs)), the value of (lat? l) is #f. " |#

#| Q: Is (or (null? l1 ) (atom? l2)) true or false where l1 is () and l2 is (d e f g) |#
#| A: True, because (null? l1 ) is true where l1 is (). |#
(module+ test
  (check-true (or (null? '() ) (atom? '(d e f g)))))

#| Q: Is (or (null? l1) (null? l2)) true or false where l1 is (a b c) and l2 is () |#
#| A: True, because (null? l2) is true where l2 is (). |#
(module+ test
  (check-true (or (null? '(a b c)) (null? '()))))

#| Q: Is (or (null? l1) (null? l2)) true or false where l1 is (a b c) and l2 is (atom) |#
#| A: False, because neither (null? l1 ) nor (null? l2) is true where l1 is (a b c) and 
      l2 is (atom). |#
(module+ test
  (check-false (null? '(a b c)))
  (check-false (null? '(atom)))
  (check-false (or (null? '(a b c)) (null? '(atom)))))

#| Q: What does (or ... ) do? |#
#| A: (or ...) asks two questions, one at a time. If the first one is true it stops and answers true. 
      Otherwise it asks the second question and answers with whatever the second question answers. |#

#| Q: Is it true or false that a is a member of lat where a is tea and lat is (coffee tea or milk) |#
#| A: True, because one of the atoms of the lat, (coffee tea or milk) is the same as the atom a-tea. |#

#| Q: Is (member? a lat) true or false where a is poached and lat is (fried eggs and scrambled eggs) |#
#| A: False, since a is not one of the atoms of the lat. |#

#| This is the function member? |#

;; member? : Atom LAT -> Boolean
;; Produces true if atom is found in lat
(define member? 
  (λ (a lat) 
    (cond 
      ((null? lat) #f) 
      (else (or (eq? (car lat) a) 
                (member? a (cdr lat))))))) 

#| Q: What is the value of (member? a lat) where a is meat and lat is (mashed potatoes and meat gravy) |#
#| A: #t, because the atom meat is one of the atoms of lat, (mashed potatoes and meat gravy). |#
(module+ test
  (check-true (member? 'meat '(mashed potatoes and meat gravy))))

#| Q: How do we determine the value #t for the above application? |#
#| A: The value is determined by asking the questions about (member? a lat). 
      Hint: Write down the definition of the function member? and refer to it while you 
      work on the next group of questions. |#

#| Q: What is the first question asked by (member? a lat) |#
#| A: (null? lat). This is also the first question asked by lat?. |#



#|          *** The First Commandment ***
                     (preliminary) 
                    Always ask null?
          as the first question in expressing 
                     any function.                   |#



#| Q: What is the meaning of the line ((null? lat) #f) where lat is (mashed potatoes and meat gravy) |#
#| A: (null? lat) asks if lat is the null list. If it is, the value is #f, since the atom meat was
      not found in lat. If not, we ask the next question. In this case, it is not null, so we ask
      the next question. |#
(module+ test
  (check-false (null? '(mashed potatoes and meat gravy))))

#| Q: What is the next question? |#
#| A: else. |#

#| Q: Why is else the next question? |#
#| A: Because we do not need to ask any more questions. |#

#| Q: Is else really a question? |#
#| A: Yes, else is a question whose value is always true. |#

#| Q: What is the meaning of the line
     (else (or (eq? (car lat) a) 
               (member? a (cdr lat)))) |#
#| A: Now that we know that lat is not null?, we have to find out whether the car of lat is the 
      same atom as a, or whether a is somewhere in the rest of lat. The answer 
      (or (eq? (car lat) a) (member? a ( cdr lat))) does this. |#

#| Q: True or false: 
       (or (eq? (car lat) a) 
           (member? a (cdr lat)))
      where a is meat and lat is (mashed potatoes and meat gravy) |#
#| A: True, b/c meat is an expression in the list (mashed potatoes and meat gravy).
      We will find out by looking at each question in turn. |#
(module+ test
  (check-true
   (or (eq? (car '(mashed potatoes and meat gravy)) 'meat) 
       (member? 'meat  (cdr '(mashed potatoes and meat gravy))))))

#| Q: Is (eq? (car lat) a) true or false where a is meat and lat is (mashed potatoes and meat gravy) |#
#| A: False, because meat is not eq? to mashed, the car of (mashed potatoes and meat gravy). |#
(module+ test
  (check-false (eq? (car '(mashed potatoes and meat gravy)) 'meat)))

#| Q: What is the second question of (or ...) |#
#| A: (member? a (cdr lat)). This refers to the function with the 
      argument lat replaced by (cdr lat). |#

#| Q: Now what are the arguments of member? |#
#| A: a is meat and lat is now (cdr lat), specifically (potatoes and meat gravy). |#

#| Q: What is the next question |#
#| A: (null? lat). Rememeber the first commandment |#

#| Q: Is (null? lat) true or false where lat is (potatoes and meat gravy) |#
#| A: #f --false. |#
(module+ test
  (check-false (null? '(potatoes and meat gravy))))

#| Q: What do we do now |#
#| A: Ask the next question. |#

#| Q: What is the next question |#
#| A: else. |#

#| Q: What is the meaning of (or (eq? (car lat) a) (member? a (cdr lat))) |#
#| A: (or (eq? (car lat) a) (member? a (cdr lat))) finds out if a is eq? to the car of lat
      or if a is a member of the cdr of lat by referring to the function. |#

#| Q: Is a eq? to the car of lat |#
#| A: No, because a is meat and the car of lat is potatoes. |#
(module+ test
  (check-false (eq? 'meat '(potatoes and meat gravy))))

#| Q: So what do we do next? |#
#| A: We ask (member? a (cdr lat)). |#

#| Q: Now, what are the arguments of member? |#
#| A: a is meat, and lat is (and meat gravy) . |#

#| Q: What is the next question? |#
#| A: (null? lat) |#

#| Q: What do we do now? |#
#| A: Ask the next question, since (null? lat) is false. |#

#| Q: What is the next question? |#
#| A: else. |#

#| Q: What is the value of (or (eq? (car lat) a) (member? a (cdr lat))) |#
#| A: The value of (member? a (cdr lat)). |#

#| Q: Why? |#
#| A: Because (eq? (car lat) a) is false. |#
(module+ test
  (check-false (eq? (car '(and meat gravy)) 'meat)))

#| Q: What do we do now? |#
#| A: Recur -- refer to the function with new arguments. |#

#| Q: What are the new arguments? |#
#| A: a is meat, and lat is (meat gravy). |#

#| Q: What is the next question? |#
#| A: (null? lat). |#

#| Q: What do we do now? |#
#| A: Since (null? lat) is false, ask the next question. |#

#| Q: What is the next question? |#
#| A: else. |#

#| Q: What is the value of (or (eq? (car lat) a) (member? a (cdr lat))) |#
#| A: #t, because (car lat), which is meat, and a, which is meat, are the same atom. 
      Therefore, (or ...) answers with #t. |#
(module+ test
  (check-true (eq? 'meat (car '(meat gravy)))))

#| Q: What is the value of the application (member? a lat) where a is meat and lat is (meat gravy) |#
#| A: #t, because we have found that meat is a member of (meat gravy). |#
(module+ test
  (check-true (member? 'meat '(meat gravy))))

#| Q: What is the value of the application (member? a lat) where a is meat and lat is (and meat gravy) |#
#| A: #t, because meat is also a member of the lat (and meat gravy). |#
(module+ test
  (check-true (member? 'meat '(and meat gravy))))

#| Q: What is the value of the application (member? a lat) where a is meat and
      lat is (potates and meat gravy) |#
#| A: #t, because meat is also a member of the lat (potatoes and meat gravy). |#
(module+ test
  (check-true (member? 'meat '(potatoes and meat gravy))))

#| Q: What is the value of the application (member? a lat) where a is meat and
      lat is (mashed potates and meat gravy) |#
#| A: #t, because meat is also a member of the lat (mashed potatoes and meat gravy). 
      Of course, this is our original lat. |#
(module+ test
  (check-true (member? 'meat '(mashed potatoes and meat gravy))))

#| Q: Just to make sure you have it right, let's quickly run through it again.
      What is the value of the application (member? a lat) where a is meat and
      lat is (mashed potates and meat gravy) |#
#| A: #t. Hint: Write down the definition of the function member? and its arguments and 
      refer to them as you go through the next group of questions. |#

#| Q: (null? lat) |#
#| A: No. Move to the next line. |#

#| Q: else |#
#| A: Yes. |#

#| Q: (or (eq? (car lat) a) (member? a (cdr lat))) |#
#| A: Perhaps. Let's see one expression at a time. |#

#| Q: (eq? (car lat) a) |#
#| A: No. Ask the next question. |#

#| Q: What next? |#
#| A: Recur with a and (cdr lat) where a is meat and (cdr lat) is (potatoes and meat gravy). |#

#| Q: (null? lat) |#
#| A: No. Move to the next line. |#

#| Q: else |#
#| A: Yes, but (eq? (car lat) a) is false. Recur with a and (cdr lat) where a is meat and (cdr lat) is (and meat gravy) . |#

#| Q: (null? lat) |#
#| A: No. Move to the next line. |#

#| Q: else |#
#| A: Yes, but (eq? (car lat) a) is false. Recur with a and (cdr lat) where a is meat and (cdr lat) is (meat gravy). |#

#| Q: (null? lat) |#
#| A: No. Move to the next line. |#

#| Q: (eq? (car lat) a) |#
#| A: Yes, the value is #t. |#

#| Q: (or (eq? (car lat) a) (member? a (cdr lat))) |#
#| A: #t.|#

#| Q: What is the value of (member? a lat) where a is meat and lat is (meat gravy) |#
#| A: #t. |#

#| Q: What is the value of (member? a lat) where a is meat and lat is (and meat gravy) |#
#| A: #t. |#

#| Q: What is the value of (member? a lat) where a is meat and lat is (potatoes and meat gravy) |#
#| A: #t. |#

#| Q: What is the value of (member? a lat) where a is meat and lat is (mashed potatoes and meat gravy) |#
#| A: #t. |#

#| Q: What is the value of (member? a lat) where a is liver and lat is (bagels and lox) |#
#| A: #f. |#
(module+ test
  (check-false (member? 'liver '(bagels and lox))))

#| Q: Let's work out why it is #f. What's the first question member? asks? |#
#| A: (null? lat). |#

#| Q: (null? lat) |#
#| A: No. Move to the next line. |#
(module+ test
  (check-false (null? '(bagels and lox))))

#| Q: else |#
#| A: Yes, but (eq? (car lat) a) is false. Recur with a and (cdr lat) where a is liver 
      and (cdr lat) is (and lox). |#
(module+ test
  (check-false (eq? (car '(bagels and lox)) 'liver)))

#| Q: (null? lat) |#
#| A: (No. Move to the next line. |#
(module+ test
  (check-false (null? '(and lox))))

#| Q: else |#
#| A: Yes, but (eq? (car lat) a) is false. Recur with a and (cdr lat) where a is liver 
      and (cdr lat) is (lox). |#
(module+ test
  (check-false (eq? (car '(and lox)) 'liver)))

#| Q: (null? lat) |#
#| A: No. Move to the next line. |#
(module+ test
  (check-false (null? '(lox))))

#| Q: else |#
#| A: Yes, but (eq? (car lat) a) is still false. Recur with a and (cdr lat) where a is liver 
      and (cdr lat) is (). |#
(module+ test
  (check-false (eq? (car '(lox)) 'liver)))

#| Q: (null? lat) |#
#| A: Yes. |#
(module+ test
  (check-true (null? '())))

#| Q: What is the value of (member? a lat) where a is liver and lat is () |#
#| A: #f. |#
(module+ test
  (check-false (member? 'liver '())))

#| Q: What is the value of (or (eq? (car lat) a) (member? a (cdr lat))) 
      where a is liver and lat is (lox) |#
#| A: #f. |#
(module+ test
  (check-false
   (or (eq? (car '(lox)) 'liver)
       (member? 'liver (cdr '(lox))))))

#| Q: What is the value of (member? a lat) where a is liver and lat is (lox) |#
#| A: #f. |#
(module+ test
  (check-false (member? 'liver '(lox))))

#| Q: What is the value of (or (eq? (car lat) a)  (member? a (cdr lat)))
      where a is liver and lat is (and lox) |#
#| A: #f. |#
(module+ test
  (check-false
   (or (eq? (car '(and lox)) 'liver)
       (member? 'liver (cdr '(and lox))))))

#| Q: What is the value of (member? a lat) where a is liver and lat is (and lox) |#
#| A: #f. |#
(module+ test
  (check-false (member? 'liver '(and lox))))

#| Q: What is the value of (or (eq? (car lat) a) (member? a (cdr lat)))
      where a is liver and lat is (bagels and lox) |#
#| A: #f. |#
(module+ test
  (check-false
   (or (eq? (car '(bagels and lox)) 'liver)
       (member? 'liver (cdr '(bagels and lox))))))

#| Q: What is the value of (member? a lat) where a is liver and lat is (bagels and lox) |#
#| A: #f. |#
(module+ test
  (check-false (member? 'liver '(bagels and lox))))



#|                          Do you believe all this? Then you may rest!                          |#






















#|                              *** This space for doodling ***                                 |#