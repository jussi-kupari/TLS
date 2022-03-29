#lang racket

;; atom? : Any -> Boolean
;; Produces #true if input is an atom
(define atom? 
  (λ (x) 
    (and (not (pair? x)) (not (null? x)))))



#|               Cons the Magnificent               |#



#| Q: What is (rember a lat) where a is mint and lat is (lamb chops and mint jelly) |#
#| A: I don't know, but according to the book the answer is
      (lamb chops and jelly) and "Rember" stands for remove a member. |#

#| Q: (rember a lat) where a is mint and lat is (lamb chops and mint flavored mint jelly) |#
#| A: According to the book the answer is (lamb chops and flavored mint jelly).
      rember seems to remove the first occurrence of the given atom from the list |#

#| Q: (rember a lat) where a is toast and lat is (bacon lettuce and tomato) |#
#| A: toast is not a member of the list so the answer is (bacon lettuce and tomato) |#

#| Q: (rember a lat) where a is cup and lat is (coffee cup tea cup and hick cup) |#
#| A: (coffee tea cup and hick cup)|#

#| Q: What does (rember a lat) do? |#
#| A: It takes an atom and a list of atoms and removes the first occurrence
      of the given atom from the list. If the atom is not in the list, it
      produces the original list |#

#| Q: What steps should we use to do this? |#
#| A: We should start with the first commandment and test if the list is a null list |#

#| Q: And if (null? lat) is true? |#
#| A: We should return the original list, so a null list or () |#

#| Q: What do we know if (null? lat) is not true? |#
#| A: We know that lat contains at least one atom |#

#| Q: Is there any other question we should ask about the lat? |#
#| A: Not in general. If the list is not null then it has at least one atom |#

#| Q: What do we do if we know that the lat contains at least one atom? |#
#| A: We ask if the first atom in the list (car lat) is the same as our atom of interest a. |#

#| Q: How do we ask questions? |#
#| A: We use the conditional cond |#

#| Q: How do we ask if a is the same as (car lat) |#
#| A: (eq? a (car lat)) |#

#| Q: What would be the value of (rember a lat) if a were the same as (car lat) |#
#| A: (cdr lat) |#

#| Q: What do we do if a is not the same as (car lat) |#
#| A: We keep (car lat) and look further in the list using (rember a (cdr lat)) |#

#| Q: How do we remove the first occurrence of a in the rest of lat |#
#| A: As said above, by (rember a (cdr lat)) |#

#| Q: Is there any other question we should ask? |#
#| A: I can't think of any. No. |#

; Now, let's write down what we have so far:
(define rember-proto
  (λ (a lat)
    (cond
      ((null? lat) '())
      (else
       (cond
         ((eq? (car lat) a) (cdr lat))
         (else (rember-proto a (cdr lat))))))))

#| Q: What is the value of (rember a lat) where a is bacon and lat is (bacon lettuce and tomato) |#
#| A: (lettuce and tomato) |#
(rember-proto 'bacon '(bacon lettuce and tomato)) ; ==> '(lettuce and tomato)

#| Q: Now, let's see if this function works. What is the first question? |#
#| A: (null? lat) |#

#| Q: What do we do now? |#
#| A: (null? lat) returns #f so we continue to the next question |#

#| Q: else |#
#| A: Yes, this is always true |#

#| Q: What next?|#
#| A: Go to the next question |#

#| Q: (eq? (car lat) a) |#
#| A: This returns true, so the value becomes (cdr lat), which is (lettuce and tomato) |#

#| Q: Is this the correct value? |#
#| A: Yes, it is the original list without the first occurrence of bacon |#

#| Q: But did we really use a good example? |#
#| A: Who knows? But the proof of the pudding is in the eating, so let's try another example. |#

#| Q: What does rember do? |#
#| A: Rember takes as arguments and atom and a list of atoms, and removes the first occurrence
      of the atom from the list. If the atom is not on the list, rember returns the original list. |#

#| Q: What do we do now? |#
#| A: We compare each atom of the lat with the atom a, and if the comparison fails we build 
      a list that begins with the atom we just compared.|#

#| Q: What is the value of (rember a lat) where a is 'and and lat is (bacon lettuce and tomato) |#
#| A: (bacon lettuce tomato) |#

#| Q: Let us see if our function rember works. What is the first question asked by rember |#
#| A: (null? lat) |#
(null? '(bacon lettuce and tomato)) ; ==> #f

#| Q: What do we do now? |#
#| A: We continue to the next question |#

#| Q: else |#
#| A: This is always true so we go to the next question |#

#| Q: (eq? (car lat) a) |#
#| A: False. Go to the next line. |#

#| Q: What is the meaning of (rember a (cdr lat)) |#
#| A: See if the atom and is in remaining part of lat.
      So, we recur where a is 'and and (cdr lat) is (lettuce and tomato). |#

#| Q: (null? lat) |#
#| A: False. Move to the next question. |#

#| Q: else |#
#| A: Always true, so we ask the next question |#

#| Q: (eq? (car lat) a) |#
#| A: False, and is not the same as lettuce |#

#| Q: What is the meaning of (else (rember a (cdr lat)))|#
#| A: else is always true, so we recur (rember a (cdr lat)) where
      a is 'and and (cdr lat) is (and tomato) |#

#| Q: (null? lat) |#
#| A: False, next question |#

#| Q: else |#
#| A: Of course |#

#| Q: (eq? (car lat) a) |#
#| A: True, and is the same as and |#
(car '(and tomato))  ; ==> 'and
(eq? 'and 'and) ; ==> #t

#| Q: So what is the result? |#
#| A: (cdr lat), which is (tomato) |#

#| Q: Is this correct? |#
#| A: No, b/c this not the original list (bacon lettuce and tomato) with just 'and removed |#

#| Q: What did we do wrong? |#
#| A: We discarded and but also all other atoms that came before it in the list |#

#| Q: How can we keep from losing the atoms bacon and lettuce |#
#| A: We use Cons the Magnificent. Remember cons, from chapter 1? |#



#|          *** The Second Commandment ***
                Use cons to build lists.              |#



; Let's see what happens when we use cons

;; rember.v1 : Atom LAT -> LAT
;; Given atom and lat, removes the first occurrence of atom from lat or if atom is not found returns lat
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
#| A: (bacon lettuce tomato) |#
(rember.v1 'and '(bacon lettuce and tomato)) ; ==> '(bacon lettuce tomato)

#| Q: What is the first question? |#
#| A: (null? lat) |#
(null? '(bacon lettuce and tomato)) ; ==> #f

#| Q: What do we do now? |#
#| A: Go to the next question |#

#| Q: else |#
#| A: Yes, True |#

#| Q: (eq? (car lat) a) |#
#| A: False. Go to next step. |#

#| Q: What is the meaning of (cons (car lat) (rember a (cdr lat)))
      where a is 'and and lat is (bacon lettuce and tomato) |#
#| A: Append and at the beginning of the list that is formed from
      recurring rember with a and (cdr lat) wehere a is 'and and (cdr lat) is (lettuce and tomato)

     from the book:
     It says to cons the car of lat -bacon- onto the value of (rember a (cdr lat)). 
     But since we don't know the value of (rember a (cdr lat)) yet, we must find it 
     before we can cons (car lat) onto it. |#

#| Q: What is the meaning of (rember a (cdr lat)) |#
#| A: Remove the first occurrence of a - if found - from (cdr lat) where a is 'and and
      (cdr lat) is (lettuce and tomato) |#

#| Q: (null? lat) |#
#| A: False |#
(null? '(lettuce and tomato)) ; ==> #f

#| Q: else |#
#| A: Yes, yes. Go to the next question |#

#| Q: (eq? (car lat) a) |#
#| A: False. onwards |#
(eq? (car '(lettuce and tomato)) 'and) ; ==> #f

#| Q: What is the meaning of (cons (car lat) (rember a (cdr lat))) |#
#| A: Cons the first atom of lat to the value of (rember a (cdr lat)), where
      a is 'and and (cdr lat) is (and tomato). This means to append lettuce
      at the beginning of a list that is the result of (rember and (and tomato)),
      so we first have to find the value of (rember and (and tomato)) |#

#| Q: What is the meaning of (rember a (cdr lat)) |#
#| A: This means running rember with 'and and (cdr lat) which is (and tomato) |#

#| Q: (null? lat) |#
#| A: False |#
(null? '(and tomato)) ; ==> #f

#| Q: else |#
#| A: True as always. So onwards. |#

#| Q: (eq? (car lat) a) |#
#| A: True |#
(eq? (car '(and tomato)) 'and) ; ==> #t

#| Q: What is the value of the line ((eq? (car lat) a) (cdr lat))|#
#| A: (cdr lat), which is (tomato) |#
(cdr '(and tomato)) ; ==> '(tomato)

#| Q: Are we finished? |#
#| A: From the book:
      Certainly not! We know what (rember a lat) is when lat is (and tomato), but we don't yet 
      know what it is when lat is (lettuce and tomato) or (bacon lettuce and tomato). |#

#| Q: We now have a value for (rember a (cdr lat)) where a is and and (cdr lat) is (and tomato) 
      This value is (tomato) What next? |#

#| A: From the book:
      Recall that we wanted to cons lettuce onto the value of (rember a (cdr lat)) 
      where a was 'and and (cdr lat) was (and tomato). Now that we have this value,
      which is (tomato), we can cons lettuce onto it. |#

#| Q: What is the result when we cons lettuce onto (tomato) |#
#| A: (lettuce tomato) |#

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
#| A: (bacon lettuce tomato) |#

#| Q: What does (bacon lettuce tomato) represent? |#
#| A: I represent the value of (cons (car lat) (rember a (cdr lat))),
      lat is (bacon lettuce and tomato), (car lat) is bacon and
      (rember a (cdr lat)) is (lettuce tomato) |#

#| Q: Are we finished yet? |#
#| A: Yes we have |#

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
#| A: Yes |#

;; rember : Atom LAT -> LAT
;; Given atom and lat, removes the first occurrence of atom from lat, if it finds the atom
(define rember
  (λ (a lat)
    (cond
      ((null? lat) '())
      ((eq? (car lat) a) (cdr lat))
      (else
       (cons (car lat) (rember a (cdr lat)))))))

#| Q: Do you think this is simpler? |#
#| A: book: Functions like rember can always be simplified in this manner. |#

#| Q: So why don't we simplify right away? |#
#| A: book: Because then a function's structure does not coincide with its argument's structure. |#

#| Q: Let's see if the new rember is the same as the old one. What is the value of the application 
      (rember a lat) where a is 'and and lat is (bacon lettuce and tomato) |#
#| A: (bacon lettuce tomato) |#

#| Q: (null? lat) |#
#| A: False |#
(null? '(bacon lettuce and tomato)) ; ==> #f

#| Q: (eq? (car lat) a) |#
#| A: False |#
(eq? (car '(bacon lettuce and tomato)) 'and) ; ==> #f

#| Q: else |#
#| A: True, so the value is (cons (car lat) (rember a (cdr lat))). |#

#| Q: What is the meaning of (cons (car lat) (rember a (cdr lat)))|#

#| A: Cons the first atom in lat to the value of (rember a (cdr lat)) when we find this value. |#

#| Q: (null? lat) |#
#| A: False |#
(null? '(lettuce and tomato)) ; ==> #f

#| Q: (eq? (car lat) a) |#
#| A: False |#
(eq? (car '(lettuce and tomato)) 'and) ; ==> #f

#| Q: else |#
#| A: True as always, so the value becomes (cons (car lat) (rember a (cdr lat))). |#

#| Q: What is the meaning of (cons (car lat) (rember a (cdr lat)))|#
#| A: We have to find the value of running rember with the remaining list and
      when we find this value, we must cons the first atom in the current list to this value. |#

#| Q: (null? lat) |#
#| A: False |#
(null? '(and tomato)) ; ==> #f

#| Q: (eq? (car lat) a) |#
#| A: True |#
(eq? (car '(and tomato)) 'and) ; ==> #t

#| Q: What is the value of the line ((eq? (car lat) a) (cdr lat)) |#
#| A: (cdr lat), which is (cdr (and tomato)), which is (tomato) |#
(cdr '(and tomato)) ; ==> '(tomato)

#| Q: Now what? |#
#| A: Now we can cons the previous atom, lettuce, to this result (tomato).
      This becomes (lettuce tomato). |#

#| Q: Now what? |#
#| A: Now we can cons the previous saved atom, bacon, to this result (lettuce tomato).
      This becomes (bacon lettuce tomato). |#

#| Q: Now that we have completed rember try this example: (rember a lat) 
      where a is sauce and lat is (soy sauce and tomato sauce) |#
#| A: (soy and tomato sauce) |#
(rember 'sauce '(soy sauce and tomato sauce)) ; ==> '(soy and tomato sauce)

#| Q: What is (firsts l)  where l is
    ((apple peach pumpkin) 
     (plum pear cherry) 
     (grape raisin pea) 
     (bean carrot eggplant)) |#

#| A: (apple plum grape bean) |#

#| Q: What is (firsts l) where l is
     ((a b)
      (c d)
      (e f))|#

#| A: (a c e) |#

#| Q: What is (firsts l) where l is () |#

#| A: () |#

#| Q: What is (firsts l) where l is
      ((five plums) 
       (four) 
       (eleven green oranges)) |#

#| A: (five four eleven) |#

#| Q: What is (firsts l) where l is
      (((five plums) four) 
       (eleven green oranges) 
       ((no) more)) |#

#| A: ((five plums) eleven (no)) |#

#| Q: In your own words, what does (firsts l) do? |#
#| A: It takes one argument, a list of non-empty lists, and returns a list composed of the first
      expression of each sublist. If the list main is null, it returns a null list.

      Book:
      "The function firsts takes one argument, a list, which is either a null list or contains 
       only non-empty lists. It builds another list composed of the first S-expression of each 
       internal list." |#

#| Q: See if you can write the function firsts. Remember the Commandments! |#
#| A: Ok, I'll give it a shot! |#

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

#| a template from the authors that I didn't use:
  (define firsts 
    (λ (l) 
      (cond 
        ((null? l) ... ) 
        (else (cons ... (firsts (cdr l))))))) |#

#| Q: Why 
     (define firsts 
        (λ (l) 
           ... )) |#
#| A: book: Because we always state the function name, 
      (lambda, and the argument(s) of the function . |#

#| Q: Why (cond ...) |#
#| A: Because we want to ask questions about the arguments to get the result. |#

#| Q: Why (null? l ...) |#
#| A: Always ask null? first. This is The First Commandment. |#

#| Q: Why (else |#
#| A: if the list is not null the it contains at least one non-null list.
      else is the only other question needed. |#

#| Q: Why (else |#
#| A: Else is always the last question and always true. |#

#| Q: Why (cons |#
#| A: Because the value of firsts is a list and lists are build using conses.
      The Second Commandment. |#

#| Q: Why (firsts (cdr l)) |#
#| A: Because we need also to look further into the list using recursion. |#

#| Q: Why ))) |#
#| A: We need the closing parentheses for define, λ, and cond|#

#| Q: Keeping in mind the definition of (firsts l) what is a typical element of the value 
      of (firsts l) where l is ((a b) (c d) (e f)) |#
#| A: a, c, or e |#

#| Q: What is another typical element? |#
#| A: any of the ones above |#

#| Q: Consider the function seconds. What would be a typical element of the value 
      of (seconds l) where l is ((a b) (c d) (e f)) |#
#| A: b, d, or f |#

#| Q: How do we describe a typical element for (firsts l) |#
#| A: First element of the first sublist or (car (car l)) |#

#| Q: When we find a typical element of (firsts l) what do we do with it? |#
#| A: Save it to be consed to the recursive result. |#



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
        (else ( cons (car (car l)) 
                     (firsts (cdr l)))))))

      where l is ((a b) (c d) (e f)) |#

#| A: It doesn't do anything yet, b/c it is missing the ((null? l) ... ) part that
      returns the value when l is a null list. |#

#| Q: (null? l) where l is ((a b) (c d) (e f)) |#
#| A: False. Move to the next question. |#
(null? '((a b) (c d) (e f))) ; ==> #f

#| Q: What is the meaning of (cons (car (car l)) (firsts (cdr l))) |#
#| A: Save the first element of the first sublist, (car (car l)), to be
      consed to the result of the natural recursion, (firsts (cdr l)). |#

#| Q: (null? l) where l is ((c d) (e f))|#
#| A: False, move to the next line. |#

#| Q: What is the meaning of (cons (car (car l)) (firsts (cdr l))) |#
#| A: As before. Save (car (car l)) to be consed to the result of the natural recursion. |#

#| Q: (null? l) where l is ((e f)) |#
#| A: False, so we continue. |#

#| Q: What is the meaning of (cons (car (car l)) (firsts (cdr l))) |#
#| A: Again. Save (car (car l)) to be consed to the result of the natural recursion. |#

#| Q: (null? ())|#
#| A: True |#

#| Q: Now, what is the value of the line ((null? l) ... ) |#
#| A: We are still missing the value when (null? l) is true |#

#| Q: What do we need to cons atoms onto? |#
#| A: A list. Remember The Law of Cons. |#

#| Q: For the purpose of consing, what value can we give when (null? l) is true? |#
#| A: An empty list, a null list. '() |#

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
#| A: Maybe the first. |#

#| Q: What is (insertR new old lat) where new is topping old is fudge
      and lat is (ice cream with fudge for dessert) |#
#| A: (ice cream with fudge topping for dessert). |#

#| Q: (insertR new old lat) where new is jalapeno old is and and lat is (tacos tamales and salsa) |#
#| A: (tacos tamales and jalapeno salsa) |#

#| Q: (insertR new old lat) where new is e old is d and lat is (a b c d f g d h) |#
#| A: (a b c d e f g d h) |#

#| Q: In your own words, what does (insertR new old lat) do?|#
#| A: It takes three arguments: two atoms, new and old, and a list of atoms and
      builds a new list where the new atom has been inserted after the old atom. |#

#| Q: See if you can write the first three lines of the function insertR |#
#| A: I'm gonna try to write the whole function |#

;; insertR : Atom Atom LAT -> LAT
;; Given two atoms and a list of atoms, inserts the first atom to the right of
;; the first occurrence of the second atom in the list
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

;; here is the template of the first three lines from the book
#|(define insertR 
     (λ (new old lat) 
       (cond ... ))) |#

#| Q: Which argument changes when we recur with insertR |#
#| A: lat. We look at its first element and then recur with the rest.
      Then we look at the first of the rest and recur with the rest of the rest ... |#
  
#| Q: How many questions can we ask about the lat? |#
#| A: In general? Two. Lat is either empty/null or non-empty. |#

#| Q: Now see if you can write the whole function insertR |#
#| A: I already did that above. |#

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
#| A: (ice cream with for dessert) |#
(insertR.v2 'topping 'fudge '(ice cream with fudge for dessert)) ; ==> '(ice cream with for dessert)

#| Q: So far this is the same as rember. What do we do in insertR when (eq? (car lat) old) is true? |#
#| A: We want to insert new on the right of old in the list. This is not what happens now |#

#| Q: How is this done? |#
#| A: I know how it is done, but let's try consing new onto (cdr lat) |#

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

#| Q: So what is (insertR new old lat) now where new is topping old is fudge
      and lat is (ice cream with fudge for dessert) |#
#| A: (ice cream with topping for dessert) |#
(insertR.v3 'topping 'fudge '(ice cream with fudge for dessert)) ; ==> '(ice cream with topping for dessert)

#| Q: Is this the list we wanted? |#
#| A: No. We have only replaced one atom for another. |#

#| Q: What still needs to be done? |#
#| A: We need to keep the old atom in addition to adding the new atom. |#

#| Q: How can we include old before new |#
#| A: Like this: (cons old (cons new (cdr lat))) |#

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
#| A: Ok, I will do it. |#

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

#| Q: Did you think of a different way to do it?

      ((eq? (car lat) old) 
        (cons new (cons old (cdr lat))))

     could have been

      ((eq? (car lat) old) 
        (cons new lat))

     since (cons old (cdr lat)) where old is eq? to 
     (car lat) is the same as lat. |#

#| A: I didn't think of that! Let's try it! |#

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

#| Obviously, this is the same as one of our incorrect attempts at insertR.

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
      ((or (eq? (car lat) o1) (eq? (car lat) o2)) (cons new (cdr lat))).

     Yes, sure |#

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