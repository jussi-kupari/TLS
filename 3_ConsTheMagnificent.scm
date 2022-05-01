#lang racket

(require "Atom.scm"
         "1_Toys.scm"
         "2_Doitdoitagainandagainandagain.scm")


#|               Cons the Magnificent               |#



#| Q: What is (rember a lat) where a is mint and lat is (lamb chops and mint jelly) |#
#| A: (lamb chops and jelly) "Rember" stands for remove a member. |#

#| Q: (rember a lat) where a is mint and lat is (lamb chops and mint flavored mint jelly) |#
#| A: (lamb chops and flavored mint jelly). |#

#| Q: (rember a lat) where a is toast and lat is (bacon lettuce and tomato) |#
#| A: (bacon lettuce and tomato). |#

#| Q: (rember a lat) where a is cup and lat is (coffee cup tea cup and hick cup) |#
#| A: (coffee tea cup and hick cup). |#

#| Q: What does (rember a lat) do? |#
#| A: It takes an atom and a lat as its arguments, and makes a new lat with the first
      occurrence of the atom in the old lat removed. |#

#| Q: What steps should we use to do this? |#
#| A: First we will test (null? lat) - The First Commandment. |#

#| Q: And if (null? lat) is true? |#
#| A: Return (). |#

#| Q: What do we know if (null? lat) is not true? |#
#| A:We know that there must be at least one atom in the lat. |#

#| Q: Is there any other question we should ask about the lat? |#
#| A: No. Either a lat is empty or it contains at least one atom. |#

#| Q: What do we do if we know that the lat contains at least one atom? |#
#| A: We ask whether a is equal to (car lat ). |#

#| Q: How do we ask questions? |#
#| A: By using
      (cond
        ((...) (...))
        ((...) (...))) |#

#| Q: How do we ask if a is the same as (car lat) |#
#| A: (eq? a (car lat)). |#

#| Q: What would be the value of (rember a lat) if a were the same as (car lat) |#
#| A: (cdr lat). |#

#| Q: What do we do if a is not the same as (car lat) |#
#| A: We want to keep (car lat), but also find out if a is somewhere in the rest of the lat. |#

#| Q: How do we remove the first occurrence of a in the rest of lat |#
#| A: (rember a (cdr lat)). |#

#| Q: Is there any other question we should ask? |#
#| A: No. |#

; Now, let's write down what we have so far:
(define rember-proto ;This is rember-proto because the final version will be rember
  (λ (a lat)
    (cond
      ((null? lat) '())
      (else
       (cond
         ((eq? (car lat) a) (cdr lat))
         (else (rember-proto a (cdr lat))))))))

#| Q: What is the value of (rember a lat) where a is bacon and lat is (bacon lettuce and tomato) |#
#| A: (lettuce and tomato)

      Hint: Write down the function rember and 
      its arguments, and refer to them as you go 
      through the next sequence of questions. |#

(rember-proto 'bacon '(bacon lettuce and tomato)) ; ==> '(lettuce and tomato)

#| Q: Now, let's see if this function works. What is the first question? |#
#| A: (null? lat). |#

#| Q: What do we do now? |#
#| A: Move to the next line and ask the next question. |#

#| Q: else |#
#| A: Yes. |#

#| Q: What next?|#
#| A: Ask the next question. |#

#| Q: (eq? (car lat) a) |#
#| A: Yes, so the value is ( cdr lat). In this case, it is the list 
      (lettuce and tomato). |#

#| Q: Is this the correct value? |#
#| A: Yes, because it is the original list without the atom bacon. |#

#| Q: But did we really use a good example? |#
#| A: Who knows? But the proof of the pudding is in the eating, so let's try another example. |#

#| Q: What does rember do? |#
#| A: It takes an atom and a lat as its arguments, and makes a new lat with the first occurrence 
      of the atom in the old lat removed. |#

#| Q: What do we do now? |#
#| A: We compare each atom of the lat with the atom a, and if the comparison fails we build 
      a list that begins with the atom we just compared. |#

#| Q: What is the value of (rember a lat) where a is 'and and lat is (bacon lettuce and tomato) |#
#| A: (bacon lettuce tomato) |#

;Note
(rember-proto 'and '(bacon lettuce tomato)) ; ==> '()

#| Q: Let us see if our function rember works. What is the first question asked by rember |#
#| A: (null? lat). |#
(null? '(bacon lettuce and tomato)) ; ==> #f

#| Q: What do we do now? |#
#| A:Move to the next line, and ask the next question. |#

#| Q: else |#
#| A: Okay, so ask the next question. |#

#| Q: (eq? (car lat) a) |#
#| A: No, so move to the next line. |#

#| Q: What is the meaning of (else (rember a (cdr lat))) |#
#| A: else asks if else is true - as it always is - and the rest of the line
     says to recur with a and (cdr lat), where a is and and (cdr lat) is (lettuce and tomato). |#

#| Q: (null? lat) |#
#| A: No, so move to the next line. |#

#| Q: else |#
#| A: Sure. |#

#| Q: (eq? (car lat) a) |#
#| A: No, so move to the next line. |#

#| Q: What is the meaning of (rember a (cdr lat)) |#
#| A: Recur where a is and and (cdr lat) is (and tomato). |#

#| Q: (null? lat) |#
#| A: No, so move to the next line, and ask the next question. |#

#| Q: else |#
#| A: Of course. |#

#| Q: (eq? (car lat) a) |#
#| A: Yes. |#
(car '(and tomato))  ; ==> 'and
(eq? 'and 'and) ; ==> #t

#| Q: So what is the result? |#
#| A: ( cdr l at) - (tomato). |#

#| Q: Is this correct? |#
#| A: No, since (tomato) is not the list (bacon lettuce and tomato) with just a-and-removed. |#

#| Q: What did we do wrong? |#
#| A: We dropped and , but we also lost all the atoms preceding and. |#

#| Q: How can we keep from losing the atoms bacon and lettuce |#
#| A: We use Cons the Magnificent. Remember cons, from chapter 1? |#



#|          *** The Second Commandment ***
                Use cons to build lists.              |#



; Let's see what happens when we use cons

;; rember.v1 : Atom LAT -> LAT
;; Given atom and lat, removes the first occurrence of atom or if it is not found returns lat
(define rember.v1
  (λ (a lat)
    (cond
      ((null? lat) '())
      (else
       (cond
         ((eq? (car lat) a) (cdr lat))
         (else
          (cons (car lat) (rember.v1 a (cdr lat)))))))))

#| Q: What is the value of (rember a lat) where a is 'and and lat is (bacon lettuce and tomato) |#
#| A: (bacon lettuce tomato)
      Hint: Make a copy of this function with 
      cons and the arguments a and lat so you 
      can refer to it for the following questions. |#

(rember.v1 'and '(bacon lettuce and tomato)) ; ==> '(bacon lettuce tomato)

#| Q: What is the first question? |#
#| A: (null? lat). |#
(null? '(bacon lettuce and tomato)) ; ==> #f

#| Q: What do we do now? |#
#| A: Ask the next question. |#

#| Q: else |#
#| A: Yes, of course. |#

#| Q: (eq? (car lat) a) |#
#| A: No, so move to the next line. |#

#| Q: What is the meaning of (cons (car lat) (rember a (cdr lat)))
      where a is 'and and lat is (bacon lettuce and tomato) |#
#| A: It says to cons the car of lat -bacon- onto the value of (rember a (cdr lat)). 
      But since we don't know the value of (rember a (cdr lat)) yet, we must find it 
      before we can cons (car lat) onto it. |#

#| Q: What is the meaning of (rember a (cdr lat)) |#
#| A: This refers to the function with lat replaced by (cdr lat)-(lettuce and tomato). |#

#| Q: (null? lat) |#
#| A: No, so move to the next line. |#
(null? '(lettuce and tomato)) ; ==> #f

#| Q: else |#
#| A: Yes, ask the next question. |#

#| Q: (eq? (car lat) a) |#
#| A: No, so move to the next line. |#
(eq? (car '(lettuce and tomato)) 'and) ; ==> #f

#| Q: What is the meaning of (cons (car lat) (rember a (cdr lat))) |#
#| A: It says to cons the car of lat -lettuce- onto the value of (rember a (cdr lat)). 
      But since we don't know the value of (rember a (cdr lat)) yet, we must find it 
      before we can cons (car lat) onto it. |#

#| Q: What is the meaning of (rember a (cdr lat)) |#
#| A: This refers to the function with lat replaced by (cdr lat), that is, (and tomato). |#

#| Q: (null? lat) |#
#| A: No, so ask the next question. |#
(null? '(and tomato)) ; ==> #f

#| Q: else |#
#| A: Still. |#

#| Q: (eq? (car lat) a) |#
#| A: Yes. |#
(eq? (car '(and tomato)) 'and) ; ==> #t

#| Q: What is the value of the line ((eq? (car lat) a) (cdr lat))|#
#| A: (cdr lat) - (tomato). |#
(cdr '(and tomato)) ; ==> '(tomato)

#| Q: Are we finished? |#
#| A: From the book:
      Certainly not! We know what (rember a lat) is when lat is (and tomato), but we don't yet 
      know what it is when lat is (lettuce and tomato) or (bacon lettuce and tomato). |#

#| Q: We now have a value for (rember a (cdr lat)) where a is and and (cdr lat) is (and tomato) 
      This value is (tomato) What next? |#

#| A: Recall that we wanted to cons lettuce onto the value of (rember a (cdr lat)) 
      where a was 'and and (cdr lat) was (and tomato). Now that we have this value,
      which is (tomato), we can cons lettuce onto it. |#

#| Q: What is the result when we cons lettuce onto (tomato) |#
#| A: (lettuce tomato). |#

#| Q: What does (lettuce tomato) represent |#
#| A: It represents the value of (cons (car lat) (rember a (cdr lat))),
      when lat is (lettuce and tomato) and (rember a (cdr lat)) is (tomato). |#

#| Q: Are we finished yet? |#
#| A: Not quite. So far we know what (rember a lat) is when lat is (lettuce and tomato), 
      but we don't yet know what it is when lat is (bacon lettuce and tomato). |#

#| Q: We now have a value for (rember a (cdr lat)) where a is 'and and 
     (cdr lat) is (lettuce and tomato). This value is (lettuce tomato)
     This is not the final value, so what must we do again? |#

#| A: Recall that, at one time, we wanted to cons bacon onto the value of (rember a (cdr lat)), 
      where a was 'and and (cdr lat) was (lettuce and tomato). Now that we have this value, which is 
      (lettuce tomato), we can cons bacon onto it. |#

#| Q: What is the result when we cons bacon onto (lettuce tomato) |#
#| A: (bacon lettuce tomato). |#

#| Q: What does (bacon lettuce tomato) represent? |#
#| A: I represent the value of (cons (car lat) (rember a (cdr lat))),
      lat is (bacon lettuce and tomato), (car lat) is bacon and
      (rember a (cdr lat)) is (lettuce tomato) |#

#| Q: Are we finished yet? |#
#| A: Yes. |#

#| Q: Can you put in your own words how we determined the final value (bacon lettuce tomato) |#
#| A: Rember checks each atom of a list against a given atom-of-interest one at a time. If the
      list is null, it returns an empty list. If the list is not empty, it checks if the first atom
      is the same. If it is, it returns the list without the atom. If the atoms are not the same, it
      saves the first atom on the list to be consed with the result of running rember with the
      atom-of-interest and the rest of the list. Each round when the atoms are not the same it saves
      the first atom to be consed to the result of running with the remaining list. When it reaches
      the end - finds the atom or the end of the list - it conses the saved atoms to the
      result.

      from the book:
      "The function rember checked each atom of the lat, one at a time, to see if it was the 
       same as the atom and. If the car was not the same as the atom, we saved it to be 
       consed to the final value later. When rember found the atom and, it dropped it, 
       and consed the previous atoms back onto the rest of the lat."|#

#| Q: Can you rewrite rember so that it reflects the above description? |#
#| A: Yes, we can simplify it. |#

;; rember : Atom LAT -> LAT
;; Given atom and lat, removes the first occurrence of the atom, if it finds it in the lat.
(define rember
  (λ (a lat)
    (cond
      ((null? lat) '())
      ((eq? (car lat) a) (cdr lat))
      (else
       (cons (car lat) (rember a (cdr lat)))))))

#| Q: Do you think this is simpler? |#
#| A: Functions like rember can always be simplified in this manner. |#

#| Q: So why don't we simplify right away? |#
#| A: Because then a function's structure does not coincide with its argument's structure. |#

#| Q: Let's see if the new rember is the same as the old one. What is the value of the application 
      (rember a lat) where a is 'and and lat is (bacon lettuce and tomato) |#
#| A: (bacon lettuce tomato)
      Hint: Write down the function rember and 
      its arguments and refer to them as you go 
      through the next sequence of questions. |#
(rember 'and '(bacon lettuce tomato)); ==> '(bacon lettuce tomato)

#| Q: (null? lat) |#
#| A: No. |#
(null? '(bacon lettuce and tomato)) ; ==> #f

#| Q: (eq? (car lat) a) |#
#| A: No. |#
(eq? (car '(bacon lettuce and tomato)) 'and) ; ==> #f

#| Q: else |#
#| A: Yes, so the value is (cons (car lat) (rember a (cdr lat))). |#

#| Q: What is the meaning of (cons (car lat) (rember a (cdr lat)))|#

#| A: This says to refer to the function rember but with the argument lat replaced by ( cdr lat), 
      and that after we arrive at a value for (rember a (cdr lat)) we must cons 
      (car lat) -bacon- onto it. |#

#| Q: (null? lat) |#
#| A: No. |#
(null? '(lettuce and tomato)) ; ==> #f

#| Q: (eq? (car lat) a) |#
#| A: No. |#
(eq? (car '(lettuce and tomato)) 'and) ; ==> #f

#| Q: else |#
#| A: Yes, so the value is (cons (car lat) (rember a (cdr lat))). |#

#| Q: What is the meaning of (cons (car lat) (rember a (cdr lat)))|#
#| A: This says we recur using the function rember, with the argument lat replaced by 
      (cdr lat), and that after we arrive at a value for (rember a (cdr lat)), we must cons 
      (car lat) -lettuce- onto it. |#

#| Q: (null? lat) |#
#| A: No. |#
(null? '(and tomato)) ; ==> #f

#| Q: (eq? (car lat) a) |#
#| A: Yes. |#
(eq? (car '(and tomato)) 'and) ; ==> #t

#| Q: What is the value of the line ((eq? (car lat) a) (cdr lat)) |#
#| A: It is (cdr lat) - (tomato). |#
(cdr '(and tomato)) ; ==> '(tomato)

#| Q: Now what? |#
#| A: Now cons ( car lat) -lettuce- onto (tomato). |#

#| Q: Now what? |#
#| A: Now cons (car lat) -bacon- onto (lettuce tomato). |#

#| Q: Now that we have completed rember try this example: (rember a lat) 
      where a is sauce and lat is (soy sauce and tomato sauce) |#
#| A: ( rember a lat) is (soy and tomato sauce). |#
(rember 'sauce '(soy sauce and tomato sauce)) ; ==> '(soy and tomato sauce)

#| Q: What is (firsts l)  where l is
    ((apple peach pumpkin) 
     (plum pear cherry) 
     (grape raisin pea) 
     (bean carrot eggplant)) |#
#| A: (apple plum grape bean). |#

#| Q: What is (firsts l) where l is
     ((a b)
      (c d)
      (e f))|#
#| A: (a c e). |#

#| Q: What is (firsts l) where l is () |#
#| A: (). |#

#| Q: What is (firsts l) where l is
      ((five plums) 
       (four) 
       (eleven green oranges)) |#
#| A: (five four eleven). |#

#| Q: What is (firsts l) where l is
      (((five plums) four) 
       (eleven green oranges) 
       ((no) more)) |#

#| A: ((five plums) eleven (no)). |#

#| Q: In your own words, what does (firsts l) do? |#
#| A: It takes one argument, a list of non-empty lists, and returns a list composed of the first
      expression of each sublist. If the list main is null, it returns a null list.

      Book:
      "The function firsts takes one argument, a list, which is either a null list or contains 
       only non-empty lists. It builds another list composed of the first S-expression of each 
       internal list." |#

#| Q: See if you can write the function firsts. Remember the Commandments! |#
#| A: This much is easy:
(define firsts 
    (λ (l) 
      (cond 
        ((null? l) ... ) 
        (else (cons ... (firsts (cdr l))))))) |#

; Here is my attempt
;; firsts : List-of-lists -> List-of-expressions
;; Given a list-of-lists, produces alist composed of the first expression of each list internal list.
(define firsts
  (λ (lol)
    (cond
      ((null? lol) '())
      ((null? (car lol)) (firsts (cdr lol))) ; guarding agains having null-lists inside
      (else
       (cons (car (car lol)) (firsts (cdr lol)))))))

(firsts '((apple peach pumpkin) 
          (plum pear cherry) 
          (grape raisin pea) 
          (bean carrot eggplant))) ; ==> '(apple plum grape bean)

(firsts ' ((a b)
           (c d)
           (e f))) ; ==> '(a c e)

(firsts '()) ; ==> '()

(firsts '((five plums) 
          (four) 
          (eleven green oranges))) ; ==> '(five four eleven)

(firsts '(((five plums) four) 
          (eleven green oranges) 
          ((no) more))) ; ==> '((five plums) eleven (no))

(firsts '(((five plums) four) 
          () 
          ((no) more))) ; ==> '((five plums) (no))

#| Q: Why 
     (define firsts 
        (λ (l) 
           ... )) |#
#| A: Because we always state the function name, 
      (λ, and the argument(s) of the function. |#

#| Q: Why (cond ...) |#
#| A: Because we need to ask questions about the actual arguments. |#

#| Q: Why (null? l ...) |#
#| A: The First Commandment. |#

#| Q: Why (else |#
#| A: Because we only have two questions to ask about the list l: either it is
      the null list, or it contains at least one non-empty list. |#

#| Q: Why (else |#
#| A: See above. And because the last question is always else. |#

#| Q: Why (cons |#
#| A: Because we are building a list - The Second Commandment. |#

#| Q: Why (firsts (cdr l)) |#
#| A: Because we can only look at one S-expression at a time.
      To look at the rest, we must recur. |#

#| Q: Why ))) |#
#| A: Because these are the matching parentheses for (cond, (λ, and (define, and
      they always appear at the end of a function definition. |#

#| Q: Keeping in mind the definition of (firsts l) what is a typical element of the value 
      of (firsts l) where l is ((a b) (c d) (e f)) |#
#| A: a. |#

#| Q: What is another typical element? |#
#| A: c, or even e. |#

#| Q: Consider the function seconds. What would be a typical element of the value 
      of (seconds l) where l is ((a b) (c d) (e f)) |#
#| A: b, d, or f. |#

#| Q: How do we describe a typical element for (firsts l) |#
#| A: As the car of an element of l  -(car (car l)). See chapter 1. |#

#| Q: When we find a typical element of (firsts l) what do we do with it? |#
#| A: cons it onto the recursion-(firsts (cdr l)). |#



#|          *** The Third Commandment *** 
                 When building a list,
          describe the first typical element,
      and then cons it onto the natural recursion.    |#



#| Q: With The Third Commandment, we can now fill in more of the function firsts 
      What does the last line look like now? |#
#| A: (else (cons (car (car l)) (firsts (cdr l))))

      build list -> (cons 
      typical element -> (car (car l)
      natural recursion -> (firsts (cdr l)) |#

#| Q: What does (firsts l) do
  (define firsts 
      (λ (l) 
        (cond 
          ((null? l) ... ) 
          (else (cons (car (car l)) 
                      (firsts (cdr l)))))))

      where l is ((a b) (c d) (e f)) |#

#| A: Nothing yet. We are still missing one important ingredient in our recipe.
      The first line ((null ? l) ...) needs a value for the case where l is the
      null list. We can, however, proceed without it for now. |#

#| Q: (null? l) where l is ((a b) (c d) (e f)) |#
#| A: No, so move to the next line. |#
(null? '((a b) (c d) (e f))) ; ==> #f

#| Q: What is the meaning of (cons (car (car l)) (firsts (cdr l))) |#
#| A: It saves ( car ( car l)) to cons onto (firsts (cdr l)) .
      To find (firsts (cdr l)), we refer to the function with the new argument 
      (cdr l). |#

#| Q: (null? l) where l is ((c d) (e f))|#
#| A: No, so move to the next line. |#

#| Q: What is the meaning of (cons (car (car l)) (firsts (cdr l))) |#
#| A: Save (car (car l)), and recur with (firsts (cdr l)). |#

#| Q: (null? l) where l is ((e f)) |#
#| A: No, so move to the next line. |#

#| Q: What is the meaning of (cons (car (car l)) (firsts (cdr l))) |#
#| A: Save (car (car l)), and recur with (firsts (cdr l)). |#

#| Q: (null? ()) |#
#| A: Yes. |#

#| Q: Now, what is the value of the line ((null? l) ... ) |#
#| A: There is no value; something is missing. |#

#| Q: What do we need to cons atoms onto? |#
#| A: A list. Remember The Law of Cons. |#

#| Q: For the purpose of consing, what value can we give when (null? l) is true? |#
#| A: Since the final value must be a list, we cannot use #t or #f. Let's try (). |#

#| Q: With () as a value, we now have three cons 
      steps to go back and pick up. We need to: 
      I. either 
      1. cons e onto () 
      2. cons c onto the value of 1 
      3. cons a onto the value of 2 
      II. or 
      1. cons a onto the value of 2 
      2. cons c onto the value of 3 
      3. cons e onto () 
      III. or 
     cons a onto 
       the cons of c onto 
         the cons of e onto 
           () 
In any case, what is the value of (firsts l) |#

#| A: (a c e) |#

#| Q: With which of the three alternatives do you feel most comfortable? |#
#| A: [choose one] Correct! Now you should use that one. |#

#| Q: What is (insertR new old lat) where new is topping old is fudge
      and lat is (ice cream with fudge for dessert) |#
#| A: (ice cream with fudge topping for dessert). |#

#| Q: (insertR new old lat) where new is jalapeno old is and and lat is (tacos tamales and salsa) |#
#| A: (tacos tamales and jalapeno salsa). |#

#| Q: (insertR new old lat) where new is e old is d and lat is (a b c d f g d h) |#
#| A: (a b c d e f g d h). |#

#| Q: In your own words, what does (insertR new old lat) do?|#
#| A: It takes three arguments: two atoms, new and old, and a list of atoms and
      builds a new list where the new atom has been inserted after the old atom.

      In our words: 
      "It takes three arguments: the atoms new 
      and old , and a lat. The function insertR 
      builds a lat with new inserted to the right 
      of the first occurrence of old." |#

#| Q: See if you can write the first three lines of the function insertR
(define insertR 
    (λ (new old lat) 
      (cond ... ))) |#
#| A: I'm gonna try to write the whole function |#

;; insertR : Atom Atom LAT -> LAT
;; Given two atoms and a lat, inserts the first atom to the right of
;; the first occurrence of the second atom.
(define insertR.v1
  (λ (new old lat)
    (cond
      ((null? lat) '())
      ((eq? (car lat) old)
       (cons old (cons new (cdr lat))))
      (else
       (cons (car lat) (insertR.v1 new old (cdr lat)))))))

(insertR.v1 'topping 'fudge '(ice cream with fudge for dessert)) ; ==> '(ice cream with fudge topping for dessert)
(insertR.v1 'jalapeno 'and '(tacos tamales and salsa)) ; == > '(tacos tamales and jalapeno salsa)
(insertR.v1 'e 'd '(a b c d f g d h)) ; ==> '(a b c d e f g d h)

#| Q: Which argument changes when we recur with insertR |#
#| A: lat, because we can only look at one of its atoms at a time. |#
  
#| Q: How many questions can we ask about the lat? |#
#| A: Two. A lat is either the null list or a non-empty list of atoms.|#

#| Q: Which questions do we ask? |#
#| A: First, we ask (null? lat). Second, we ask else,
      because else is always the last question. |#

#| Q: What do we know if (null? lat) is not true? |#
#| A: We know that lat has at least one element. |#

#| Q: What do we know if (null? lat) is not true? |#
#| A: We know that lat has at least one element. |#

#| Q: Which questions do we ask about the first element? |#
#| A: First, we ask ( eq? ( car lat) old). Then we ask else,
      because there are no other interesting cases. |#

#| Q: Now see if you can write the whole function insertR
(define insertR
    (λ new old lat)
    (cond
      ((...) (...))
      (else
       (cond
         ((...) (...))
         ((...) (...))))))

|#
#| A: I alredy did that above. |#

;; Here is our first attempt. 
(define insertR.v2 
  (λ (new old lat) 
    (cond 
      ((null? lat) '()) 
      (else 
       (cond 
         ((eq? (car lat) old) (cdr lat)) 
         (else (cons (car lat) 
                     (insertR.v2 new old 
                                 (cdr lat))))))))) 

#| Q: What is the value of the application (insertR new old lat) that we just determined 
      where new is topping old is fudge and lat is (ice cream with fudge for dessert) |#
#| A: (ice cream with for dessert). |#
(insertR.v2 'topping 'fudge '(ice cream with fudge for dessert))
; ==> '(ice cream with for dessert)

#| Q: So far this is the same as rember. What do we do in insertR when (eq? (car lat) old) is true? |#
#| A: When (car lat) is the same as old, we want to insert new to the right. |#

#| Q: How is this done? |#
#| A: Let's try consing new onto ( cdr lat). |#

#| Q: Now we have |#

(define insertR.v3 
  (λ (new old lat) 
    (cond 
      ((null? lat) '()) 
      (else (cond 
              ((eq? (car lat) old) 
               (cons new (cdr lat))) 
              (else (cons (car lat) 
                          (insertR.v3 new old 
                                      (cdr lat)))))))))

#| A: Yes. |#

#| Q: So what is (insertR new old lat) now where new is topping old is fudge
      and lat is (ice cream with fudge for dessert) |#
#| A: (ice cream with topping for dessert). |#
(insertR.v3 'topping 'fudge '(ice cream with fudge for dessert)) ; ==> '(ice cream with topping for dessert)

#| Q: Is this the list we wanted? |#
#| A: No, we have only replaced fudge with topping. |#

#| Q: What still needs to be done? |#
#| A: Somehow we need to include the atom that is the same as old before the atom new. |#

#| Q: How can we include old before new |#
#| A: Try consing old onto (cons new (cdr lat)). |#

#| Q: Now let's write the rest of the function insertR |#

(define insertR.v4 
  (λ (new old lat) 
    (cond 
      ((null? lat) '()) 
      (else
       (cond 
         ((eq? (car lat) old) 
          (cons old (cons new (cdr lat)))) 
         (else
          (cons (car lat) (insertR.v4 new old (cdr lat)))))))))

#| When new is topping, old is fudge, and lat is (ice cream with fudge for dessert), the value of 
   the application, (insertR new old lat), is (ice cream with fudge topping for dessert). 
   If you got this right, have one. |#

(insertR.v4 'topping 'fudge '(ice cream with fudge for dessert))
; ==> '(ice cream with fudge topping for dessert)
(insertR.v1 'topping 'fudge '(ice cream with fudge for dessert))
; ==> '(ice cream with fudge topping for dessert)

#| Q: Now try insertL 
      Hint: insertL inserts the atom new to the left of the first occurrence of the atom old in lat |#
#| A: This much is easy, right? |#

;; insertL : Atom Atom LAT -> LAT
;; Given two atoms and a list of atoms, inserts the first atom to the left of
;; the first occurrence of the second atom in the list
(define insertL.v1
  (λ (new old lat)
    (cond
      ((null? lat) '())
      ((eq? (car lat) old)
       (cons new (cons old (cdr lat))))
      (else
       (cons (car lat) (insertL.v1 new old (cdr lat)))))))

(insertL.v1 'topping 'fudge '(ice cream with fudge for dessert))
; ==> '(ice cream with topping fudge for dessert)

#| Q: Did you think of a different way to do it? |#

#| A: For example,

 ((eq? (car lat) old) 
        (cons new (cons old (cdr lat))))

     could have been

      ((eq? (car lat) old) 
        (cons new lat))

     since (cons old (cdr lat)) where old is eq? to 
     (car lat) is the same as lat. |#

(define insertL.v2
  (λ (new old lat)
    (cond
      ((null? lat) '())
      ((eq? (car lat) old)
       (cons new lat))
      (else
       (cons (car lat) (insertL.v2 new old (cdr lat)))))))

(insertL.v2 'topping 'fudge '(ice cream with fudge for dessert))
; ==> '(ice cream with topping fudge for dessert)

#| Q: Now try subst 
      Hint: (subst new old lat) replaces the first occurrence of old in the lat with new 
      For example, where new is topping old is fudge and lat is (ice cream with fudge for dessert) 
      the value is (ice cream with topping for dessert). Now you have the idea. |#

#| A: Ok. |#

;; subst : Atom Atom LAT -> LAT
;; Given two atoms and a list of atoms, substitutes the first occurrence
;; of the second atom in the list with the first atom 
(define subst
  (λ (new old lat)
    (cond
      ((null? lat) '())
      ((eq? (car lat) old)
       (cons new (cdr lat)))
      (else
       (cons (car lat) (subst new old (cdr lat)))))))

(subst 'topping 'fudge '(ice cream with fudge for dessert))
; ==> '(ice cream with topping for dessert)

#| This is the same as one of our incorrect attempts at insertR.

(define subst 
    (λ (new old lat) 
      (cond 
        ((null? lat) '()) 
        (else (cond 
                ((eq? (car lat) old) 
                 (cons new (cdr lat))) 
                (else (cons (car lat) 
                             (subst new old 
                                     (cdr lat)))))))))  |#

#| Q: Now try subst2 
      Hint: (subst2 new o1 o2 lat) replaces either the first occurrence of o1 or 
      the first occurrence of o2 by new 
      For example, where new is vanilla o1 is chocolate o2 is banana and 
      lat is (banana ice cream with chocolate topping) the value is
      (vanilla ice cream with chocolate topping)

      (subst2 'vanilla 'chocolate 'banana '(banana ice cream with chocolate topping))
      ==> '(vanilla ice cream with chocolate topping) |#

#| A: Ok. |#

;; subst2.v1 : Atom Atom LAT -> LAT
;; Given three atoms and a list of atoms, substitutes the first occurrence
;; of either the second or third atom in the list with the first atom
(define subst2.v1
  (λ (new o1 o2 lat)
    (cond
      ((null? lat) '())
      ((eq? (car lat) o1)
       (cons new (cdr lat)))
      ((eq? (car lat) o2)
       (cons new (cdr lat)))
      (else
       (cons (car lat) (subst2.v1 new o1 o2 (cdr lat)))))))

(subst2.v1 'vanilla 'chocolate 'banana '(banana ice cream with chocolate topping))
; ==> '(vanilla ice cream with chocolate topping)

#|

define subst2 
(λ (new o1 o2 lat) 
  (cond 
    ((null? lat) '()) 
    (else (cond 
            ((eq? (car lat) o1 ) 
             (cons new (cdr lat))) 
            ((eq? (car lat) o2) 
             (cons new (cdr lat))) 
            (else (cons (car lat) 
                        (subst2 new o1 o2 
                                (cdr lat))))))))) |#

#| Q: Did you think of a better way? |#
#| A: Replace the two eq? lines about the (car lat) by 
      ((or (eq? (car lat) o1) (eq? (car lat) o2)) (cons new (cdr lat))). |#

;; subst2.v2 : Atom Atom LAT -> LAT
;; Given three atoms and a list of atoms, substitutes the first occurrence
;; of either the second or third atom in the list with the first atom
(define subst2.v2
  (λ (new o1 o2 lat)
    (cond
      ((null? lat) '())
      ((or
        (eq? (car lat) o1)
        (eq? (car lat) o2))
       (cons new (cdr lat)))
      (else
       (cons (car lat) (subst2.v2 new o1 o2 (cdr lat)))))))

(subst2.v2 'vanilla 'chocolate 'banana '(banana ice cream with chocolate topping))
; ==> '(vanilla ice cream with chocolate topping)



#|          If you got the last function, go and repeat the cake-consing.          |#



#| Q: Do you recall what rember does? |#
#| A: The function rember looks at each atom of a lat to see if it is the same as
      the atom a. If it is not, rember saves the atom and proceeds. When it finds
      the first occurrence of a, it stops and gives the value ( cdr lat), or the 
      rest of the lat, so that the value returned is the original lat, with only
      that occurrence of a removed. |#

#| Q: Write the function multirember which gives as its final value the lat
      with all occurrences of a removed.

      Hint: What do we want as the value when (eq? (car lat) a) is true? Consider the example 
      where a is cup and lat is (coffee cup tea cup and hick cup).

(define multirember
  (λ (a lat)
    (cond
      ((...) (...))
      (else
       (cond
         ((...) (...))
         ((...) (...))))))) |#

#| A: Ok. See below. |#

;; multirember : Atom LAT -> LAT
;; Given atom and lat, produces the lat with all occurrences of the atom removed.
(define multirember.v1
  (λ (a lat)
    (cond
      ((null? lat)
       '())
      ((eq? (car lat) a)
       (multirember.v1 a (cdr lat)))
      (else
       (cons (car lat) (multirember.v1 a (cdr lat)))))))

(multirember.v1 'cup '(coffee cup tea cup and hick cup)) ; ==> '(coffee tea and hick)

#| After the first occurrence of a, we now recur with (multirember a (cdr lat)), in 
   order to remove the other occurrences. |#

#| Q: Can you see how multirember works? |#
#| A: Possibly not, so we will go through the steps necessary to arrive at the value 
      (coffee tea and hick). |#

#| Note that my version is streamlined and without the extra else and cond,
   but I follow the book verbose version below. |#
(define multirember 
  (λ (a lat) 
    (cond 
      ((null? lat) (quote ())) 
      (else 
       (cond 
         ((eq? (car lat) a) 
          (multirember a (cdr lat))) 
         (else (cons (car lat) 
                     (multirember a 
                                  (cdr lat)))))))))

#| Q: (null? lat) |#
#| A: No, so move to the next line. |#

#| Q: else |#
#| A: Yes.|#

#| Q: (eq? (car lat) a) |#
#| A: No, so move to the next line. |#

#| Q: What is the meaning of (cons (car lat) (multirember a (cdr lat))) |#
#| A: Save the first atom of lat 'coffee to be consed to the beginning of
      the result from recurring multirember with the remaining list.

      per book:
      Save (car lat) - coffee - to be consed onto the value of (multirember a (cdr lat)) later. 
      Now determine (multirember a (cdr lat)). |#

#| Q: (null? lat) |#
#| A: No, so move to the next line. |#

#| Q: else |#
#| A: Naturally. |#

#| Q: (eq? (car lat) a) |#
#| A: Yes, so forget (car lat), and determine (multirember a (cdr lat)). |#

#| Q: (null ? lat) |#
#| A: No, so move to the next line. |#

#| Q: else |#
#| A: Yes! |#

#| Q: (eq? (car lat) a) |#
#| A: No, so move to the next line. |#

#| Q: What is the meaning of (cons (car lat) (multirember a (cdr lat))) |#
#| A: Save the first atom of lat 'tea to be consed to the beginning of
      the result from recurring multirember with the remaining list.

      per book:
      Save (car lat) - tea - to be consed onto the value of (multirember a (cdr lat)) later. 
      Now determine (multirember a (cdr lat)). |#

#| Q: (null? lat) |#
#| A: No, so move to the next line. |#

#| Q: else |#
#| A: Okay, move on. |#

#| Q: (eq? (car lat) a) |#
#| A: Yes, so forget (car lat), and determine (multirember a (cdr lat)). |#

#| Q: (null ? lat) |#
#| A: No, so move to the next line. |#

#| Q: (eq? (car lat) a)  |#
#| A: No, so move to the next line. |#

#| Q: What is the meaning of (cons (car lat) (multirember a (cdr lat))) |#
#| A: Save (car lat) -and- to be consed onto the value of (multirember a (cdr lat)) later. 
      Now determine (multirember a (cdr lat)). |#

#| Q: (null? lat) |#
#| A: No, so move to the next line. |#

#| Q: (eq? (car lat) a) |#
#| A: No, so move to the next line. |#

#| Q: What is the meaning of (cons (car lat) (multirember a (cdr lat))) |#
#| A: Save (car lat) -hick- to be consed onto the value of
      (multirember a (cdr lat)) later. Now determine (multirember a (cdr lat)). |#

#| Q: (null? lat) |#
#| A: No, so move to the next line. |#

#| Q: (eq? (car lat) a) |#
#| A: Yes, so forget (car lat), and determine (multirember a (cdr lat)). |#

#| Q: (null? lat) |#
#| A: Yes, so the value is (). |#

#| Q: Are we finished? |#
#| A: No, we still have several conses to pick up. |#

#| Q: What do we do next? |#
#| A: We cons the most recent (car lat) we have -hick- onto (). |#

#| Q: What do we do next? |#
#| A: We cons and onto (hick). |#

#| Q: What do we do next? |#
#| A: We cons tea onto (and hick). |#

#| Q: What do we do next? |#
#| A: We cons coffee onto (tea and hick). |#

#| Q: Are we finished now? |#
#| A: Yes. |#

#| Q: Now write the function multiinsertR
(define multiinsertR
    (λ (new old lat)
      (cond
        ((...) (...))
        (else
         (cond
           ((...) (...))
           ((...) (...))))))) |#
#| A: Ok. See below. |#

;; multiinsertR.v1 : Atom Atom LAT -> LAT 
;; Given two atoms and a lat, inserts the first atom on the right of all occurrences
;; of the second atom in the lat.
(define multiinsertR.v1
  (λ (new old lat)
    (cond
      ((null? lat) '())
      ((eq? (car lat) old)
       (cons old
             (cons new
                   (multiinsertR.v1 new old (cdr lat)))))
      (else
       (cons (car lat) (multiinsertR.v1 new old (cdr lat)))))))

(multiinsertR.v1 'fried 'fish '(chips and fish or fish and fried))
; ==> '(chips and fish fried or fish fired and fried)

; from the book:
(define multiinsertR 
  (lambda (new old lat) 
    (cond 
      ((null? lat) '()) 
      (else 
       (cond 
         ((eq? (car lat) old) 
          (cons (car lat) 
                (cons new 
                      (multiinsertR new old (cdr lat))))) 
         (else
          (cons (car lat) (multiinsertR new old (cdr lat)))))))))
#| It would also be correct to use old in place of (car lat) because we know that 
   (eq? (car lat) old). |#

(multiinsertR 'fried 'fish '(chips and fish or fish and fried))
; ==> '(chips and fish fried or fish fired and fried)

#| Q: Is this function defined correctly? |#
(define multiinsertL.v1 
  (λ (new old lat) 
    (cond 
      ((null? lat) '()) 
      (else 
       (cond 
         ((eq? (car lat) old) 
          (cons new 
                (cons old 
                      (multiinsertL.v1 new old lat)))) 
         (else (cons (car lat) 
                     (multiinsertL.v1 new old (cdr lat)))))))))

; (multiinsertL.v1 'fried 'fish '(chips and fish or fish and fried)) ==> out of memory!

#| A: Not quite. To find out why, go through (multiinsertL new old lat) 
      where new is fried old is fish and lat is (chips and fish or fish and fried). |#

#| Q. Was the terminal condition ever reached? |#
#| A: No, because we never get past the first occurrence of old. |#

#| Q: Now, try to write the function multiinsertL again:
(define multiinsertL
    (λ (new old lat)
      (cond
        ((...) (...))
        (else
         (cond
           ((...) (...))
           ((...) (...))))))) |#

#| A: Ok, here it is |#

;;  multiinsertL : Atom Atom LAT -> LAT 
;; Given two atoms and a lat, inserts the first atom on the left of all occurrences
;; of the second atom in the lat.
(define multiinsertL 
  (λ (new old lat) 
    (cond 
      ((null? lat) '()) 
      (else 
       (cond 
         ((eq? (car lat) old) 
          (cons new 
                (cons old 
                      (multiinsertL new old (cdr lat))))) 
         (else (cons (car lat) 
                     (multiinsertL new old (cdr lat)))))))))

(multiinsertL 'fried 'fish '(chips and fish or fish and fried))
; ==> '(chips and fried fish or fried fish and fried)

;; A sleek version without extra conds and elses
(define multiinsertL-sleek
  (λ (new old lat)
    (cond
      ((null? lat) '())
      ((eq? (car lat) old)
       (cons new
             (cons old
                   (multiinsertL-sleek new old (cdr lat)))))
      (else
       (cons (car lat) (multiinsertL-sleek new old (cdr lat)))))))

(multiinsertL-sleek 'fried 'fish '(chips and fish or fish and fried))
; ==> '(chips and fried fish or fried fish and fried)



#|            *** The Fourth Commandment *** 
                      (preliminary) 
      Always change at least one argument while recurring.
        It must be changed to be closer to termination.
 The changing argument must be tested in the termination condition: 
         when using cdr, test termination with null?.       |#



#| Q: Now write the function multisubst |#
#| A: Ok, I will. |#

;; multisubst-sleek : Atom Atom LAT -> LAT 
;; Given two atoms and a lat, substitutes the first atom for all occurrences
;; of the second atom in the lat.
(define multisubst-sleek
  (λ (new old lat)
    (cond
      ((null? lat) '())
      ((eq? (car lat) old)
       (cons new (multisubst-sleek new old (cdr lat))))
      (else
       (cons (car lat) (multisubst-sleek new old (cdr lat)))))))

(multisubst-sleek 'fried 'fish '(chips and fish or fish and fried))
; ==> '(chips and fried or fried and fried)

;; book version
(define multisubst 
  (λ (new old lat) 
    (cond 
      ((null? lat) '()) 
      (else
       (cond 
         ((eq? (car lat) old) 
          (cons new (multisubst new old  (cdr lat)))) 
         (else (cons (car lat) (multisubst new old (cdr lat)))))))))

(multisubst 'fried 'fish '(chips and fish or fish and fried))
; ==> '(chips and fried or fried and fried)