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
(define rember
  (λ (a lat)
    (cond
      ((null? lat) '())
      (else
       (cond
         ((eq? (car lat) a) (cdr lat))
         (else (rember a (cdr lat))))))))

#| Q: What is the value of (rember a lat) where a is bacon and lat is (bacon lettuce and tomato) |#
#| A: (lettuce and tomato) |#
(rember 'bacon '(bacon lettuce and tomato)) ; ==> '(lettuce and tomato)

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
#| A: True, and is the same as and) |#
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