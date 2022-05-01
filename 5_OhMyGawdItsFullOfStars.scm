#lang racket

;; Require
(require
  "Atom.scm"
  "1_Toys.scm"
  "2_Doitdoitagainandagainandagain.scm"
  "3_ConsTheMagnificent.scm"
  "4_NumbersGames.scm")

;; Provide
(provide )




#|              *Oh My Gawd*: It's Full of Stars               |#



#| Q: What is (rember* a l) where a is cup and l is ((coffee) cup ((tea) cup) (and (hick)) cup) 
      note: "rember*" is pronounced "rember-star." |#
#| A: ((coffee) ((tea)) (and (hick))). |#

#| Q: What is (rember* a l) where a is sauce and l is (((tomato sauce)) ((bean) sauce) (and ((flying)) sauce)) |#
#| A: (((tomato)) ((bean)) (and ((flying)))) |#

#| Q: Now write rember* 
      Here is the skeleton:
(define rember*
  (λ (a l)
    (cond
      ((...) ...)
      ((...) ...)
      ((...) ...)))) |#

#| A: Ok. |#

;; rember* : Atom List -> List
;; Given atom and a list, removes all occurrences of the atom from the list
(define rember*
  (λ (a l)
    (cond
      ((null? l) '())                        ; empty list just returns empty
      ((atom? (car l))
       (cond
         ((eq? (car l) a)
          (rember* a (cdr l)))               ; remove matching atom from list
         (else
          (cons (car l)
                (rember* a (cdr l))))))      ; keep unmatching atom in list
      (else (cons (rember* a (car l))        ; cons result of (rember* a (car l)) 
                  (rember* a (cdr l)))))))   ; on the result of (rember* a (cdr l))

(rember* 'cup '((coffee) cup ((tea) cup) (and (hick)) cup))
; ==> '((coffee) ((tea)) (and (hick)))
(rember* 'sauce '(((tomato sauce)) ((bean) sauce) (and ((flying)) sauce)))
;==> '(((tomato)) ((bean)) (and ((flying))))

#| Book version of rember* is identical to mine. |#

#| Using arguments from one of our previous examples, follow through this to see how it 
   works. Notice that now we are recurring down the car of the list, instead of just the 
   cdr of the list. |#

#| Q: (lat? l) where l is (((tomato sauce)) ((bean) sauce) (and ((flying)) sauce)) |#
#| A: #f. |#
(lat? '(((tomato sauce)) ((bean) sauce) (and ((flying)) sauce))) ; ==> #f

#| Q: Is (car l) an atom where l is (((tomato sauce)) ((bean) sauce) (and ((flying)) sauce)) |#
#| A: No. |#
(atom? (car '(((tomato sauce)) ((bean) sauce) (and ((flying)) sauce)))) ; ==> #f

#| Q: What is (insertR* new old l) where new is roast old is chuck and l is
      ((how much (wood)) could ((a (wood) chuck)) (((chuck))) (if (a) ((wood chuck))) could chuck wood) |#
#| A:
'((how much (wood))
  could
  ((a (wood) chuck roast))
  (((chuck roast)))
  (if (a) ((wood chuck roast)))
  could chuck roast wood) |#

#| Q: Now write the function insertR* which inserts the atom new to the right of old 
      regardless of where old occurs.

(define insertR*
  (λ (new old l)
    (cond
      ((...) ...)
      ((...) ...)
      ((...) ...)))) |#

#| A: Ok. |#

;; insertR* : Atom Atom List -> List
;; Given two atoms and a list, inserts the first atom to the right of the second atom
(define insertR*
  (λ (new old l)
    (cond
      ((null? l) '())                        ; empty list returns empty of course
      ((atom? (car l))                       ; if first element in an atom
       (cond
         ((eq? (car l) old)                  ; and matches with old
          (cons old                          ; cons old to the cons of new and natural recursion
                (cons new
                      (insertR* new old
                                (cdr l)))))
         (else (cons (car l)                 ; if no match just cons (car l) to natural recursion
                     (insertR* new old
                               (cdr l))))))
      (else                                  ; if (car l) is a list 
       (cons (insertR* new old               ; run insertR* on it 
                       (car l))
             (insertR* new old               ; and cons in to the natural recursion with (cdr l)
                       (cdr l)))))))

(insertR* 'roast 'chuck
          '((how much (wood)) could ((a (wood) chuck)) (((chuck))) (if (a) ((wood chuck))) could chuck wood))
#| ==> '((how much (wood))
          could
          ((a (wood) chuck roast))
          (((chuck roast)))
          (if (a) ((wood chuck roast)))
          could chuck roast wood) |#

#| Book version of insertR* is identical to mine. |#

#| Q: How are insertR* and rember* similar? |#
#| A: Each function asks three questions. |#



#|                        *** The First Commandment *** 
                                  (final version) 
         When recurring on a list of atoms, lat, ask two questions about it:
                               (null? lat) and else. 
              When recurring on a number, n, ask two questions about it:
                                (zero? n) and else. 
       When recurring on a list of S-expressions, l, ask three question about it:
                       (null? l), (atom? (car l)), and else.                               |#



#| Q: How are insertR * and rember* similar? |#
#| A: Each function recurs on the car of its argument when it finds out that the 
      argument's car is a list. |#

#| Q: How are rember* and multirember different? |#
#| A: The function multirember does not recur with the car. The function rember* recurs 
      with the car as well as with the cdr. It recurs with the car when it finds out that 
      the car is a list. |#

#| Q: How are insertR* and rember* similar? |#
#| A: They both recur with the car, whenever the car is a list, as well as with the cdr. |#

#| Q: How are all *-functions similar? |#
#| A: They all ask three questions and recur with the car as well as with the cdr, whenever the 
      car is a list. |#

#| Q: Why? |#
#| A: Because all *-functions work on lists that are either: 
      - empty, 
      - an atom consed onto a list, or 
      - a list consed onto a list. |#



#|                       *** The Fourth Commandment ***
                                 (final version) 
                Always change at least one argument while recurring. 
               When recurring on a list-of-atoms, lat, use (cdr lat).
                    When recurring on a number, n, use (sub1 n).
      And when recurring on a list of S-expressions, l, use (car l) and (cdr l) if 
                  neither (null? l) nor (atom? (car l)) are true.

                   It must be changed to be closer to termination.
        The changing argument must be tested in the termination condition:

                    when using cdr, test termination with null?
                 and when using sub1, test termination with zero?.                     |#



#| Q: (occursomething a l) where a is banana and l is
 '((banana)
    (split ((((banana ice))) 
            (cream (banana)) 
            sherbet)) 
    (banana) 
    (bread) 
    (banana brandy)) |#
#| A: 5. |#

#| Q: What is a better name for occursomething? |#
#| A: occur*. |#

#| Q: Write occur*

(define occur*
  (λ (a l)
    (cond
      ((...) ...)
      ((...) ...)
      ((...) ...)))) |#

#| A: Ok. |#

;; occur* : Atom List -> WN
;; Given atom and list, produces the sum of atom's occurrences in the list.
(define occur*
  (λ (a l)
    (cond
      ((null? l) 0)                                  ; if list is empty, zero occurrences
      ((atom? (car l))                               ; if the first element is an atom, then
       (cond
         ((eq? (car l) a)                            ; if same as atom
          (add1 (occur* a (cdr l))))                 ; add one and recur on (cdr l)
         (else (occur* a (cdr l)))))                 ; otherwse skip over (car l) and recur on (cdr l) 
      (else                                          ; if (car l) is a list   
       (plus (occur* a (car l))
             (occur* a (cdr l)))))))                 ; add count of aotm in (car l) to recursion with (cdr l)


(occur* 'banana '((banana)
                  (split ((((banana ice))) 
                          (cream (banana)) 
                          sherbet)) 
                  (banana) 
                  (bread) 
                  (banana brandy))) ; ==> 5

#| Book solution is identical to mine. |#

#| Q: (subst* new old l) where new is orange old is banana and l is
 ((banana)
   (split ((((banana ice))) 
           (cream (banana)) 
           sherbet)) 
   (banana) 
   (bread) 
   (banana brandy)) |#

#| A:
((orange)
   (split ((((orange ice))) 
           (cream (orange)) 
           sherbet)) 
   (orange) 
   (bread) 
   (orange brandy)) |#

#| Q: Write subst*

(define subst*
  (λ (new old l)
    (cond
      ((...) ...)
      ((...) ...)
      ((...) ...)))) |#

#| A: Ok. |#

;; subst* : Atom Atom List -> List
;; Given two atoms and list, substitutes each first atom for the second atom in the list.
(define subst*
  (λ (new old l)
    (cond
      ((null? l) '())                             ; empty list returns empty
      ((atom? (car l))                            ; if the first element is an atom
       (cond
         ((eq? (car l) old)                       ; and same as old
          (cons new
                (subst* new old (cdr l))))        ; cons new to result of recurring with (cdr l)
         (else (cons (car l)
                     (subst* new old (cdr l)))))) ; else cons first element to result of recurring with (cdr l)) 
      (else                                       ; if first element is a list
       (cons (subst* new old (car l))             ; subst* in that list and cons resulting list
             (subst* new old (cdr l)))))))        ; to the natural recursion with (cdr l)

(subst* 'orange 'banana
        '((banana)
          (split ((((banana ice))) 
                  (cream (banana)) 
                  sherbet)) 
          (banana) 
          (bread) 
          (banana brandy)))
; ==> '((orange) (split ((((orange ice))) (cream (orange)) sherbet)) (orange) (bread) (orange brandy))

#| Book solution is identical to mine. |#

#| Q: What is (insertL* new old l) where new is pecker old is chuck and l is
((how much (wood))
    could 
    ((a (wood) chuck)) 
    (((chuck))) 
    (if (a) ((wood chuck))) 
    could chuck wood) |#
#| A:
((how much (wood))
    could 
    ((a (wood) pecker chuck)) 
    (((pecker chuck))) 
    (if (a) ((wood pecker chuck))) 
    could pecker chuck wood)|#

#| Q: Write insertL*

(define insertL*
  (λ (new old l)
    (cond
      ((...) ...)
      ((...) ...)
      ((...) ...)))) |#

#| A: Ok. |#

;; insertL* : Atom Atom List -> List
;; Given two atoms and list, inserts the first atom on the left of each second atom.
(define insertL*
  (λ (new old l)
    (cond
      ((null? l) '())
      ((atom? (car l))
       (cond
         ((eq? (car l) old)
          (cons new
                (cons old
                      (insertL* new old (cdr l)))))
         (else
          (cons (car l)
                (insertL* new old (cdr l))))))
      (else
       (cons (insertL* new old (car l))
             (insertL* new old (cdr l)))))))

(insertL* 'pecker 'chuck
          '((how much (wood))
            could 
            ((a (wood) chuck)) 
            (((chuck))) 
            (if (a) ((wood chuck))) 
            could chuck wood))
#| ==>
'((how much (wood))
  could
  ((a (wood) pecker chuck))
  (((pecker chuck)))
  (if (a) ((wood pecker chuck)))
  could
  pecker
  chuck
  wood) |#

#| Book solution is identical to mine. |#

#| Q: (member* a l) where a is chips and l is
      ((potato) (chips ((with) fish) (chips))) |#
#| A: #t, because the atom chips appears in the list l. |#

#| Q: Write member*

(define member*
  (λ (a l)
    (cond
      ((...) ...)
      ((...) ...)
      ((...) ...)))) |#

#| A: Alright. |#

;; my version uses a more awkward structure of cond -> predicate -> else
;; that could be substituted with and or-structure like the book version does.

;; member** : Atom List -> Boolean
;; Given atom and list, produces true if atom is found in the list.
(define member**
  (λ (a l)
    (cond
      ((null? l) #f)
      ((atom? (car l))
       (cond
         ((eq? (car l) a) #t)
         (else (member** a (cdr l)))))
      (else
       (cond
         ((member** a (car l)) #t)
         (else (member** a (cdr l))))))))

(member** 'chips '((potato) (chips ((with) fish) (chips)))) ; ==> #t
(member** 'chips '((potato) (fries ((with) fish) (chips)))) ; ==> #t
(member** 'chips '((potato) (fries ((with) fish) (fries)))) ; ==> #f

;; book version uses or instead of my cond -> predicate -> else

;; member* : Atom List -> Boolean
;; Given atom and list, produces true if atom is found in the list.
(define member* 
  (λ (a l) 
    (cond 
      ((null? l) #f) 
      ((atom? (car l)) 
       (or (eq? (car l) a) 
           (member* a (cdr l)))) 
      (else (or (member* a (car l)) 
                (member* a (cdr l)))))))

(member* 'chips '((potato) (chips ((with) fish) (chips)))) ; ==> #t
(member* 'chips '((potato) (fries ((with) fish) (chips)))) ; ==> #t
(member* 'chips '((potato) (fries ((with) fish) (fries)))) ; ==> #f

#| Book version is the same. |#

#| Q: What is (member* a l) where a is chips and l is
      ((potato) (chips ((with) fish) (chips))) |#
#| A: #t. |#

#| Q: Which chips did it find? |#
#| A: ((potato) (>>chips<< ((with) fish) (chips))). |#

#| Q: What is (leftmost l) where l is
      ((potato) (chips ((with) fish) (chips))) |#
#| A: potato. |#

#| Q: What is (leftmost l) where l is
      (((hot) (tuna (and))) cheese) |#
#| A: hot. |#

#| Q: What is (leftmost l) where l is
      (((() four)) 17 (seventeen)) |#
#| A: No answer. |#

#| Q: What is (leftmost '())|#
#| A: No answer. |#

#| Q: Can you describe what leftmost does? |#
#| A: Here is our description: 
      "The function leftmost finds the leftmost atom in a non-empty list of S-expressions 
      that does not contain the empty list."|#

#| Q: Is leftmost a *-function? |#
#| A: It works on lists of S-expressions, but it only recurs on the car. |#

#| Q: Does leftmost need to ask questions about all three possible cases? |#
#| A: No, it only needs to ask two questions. We agreed that leftmost works on non-empty 
      lists that don't contain empty lists. |#

#| Q: Now see if you can write the function leftmost

(define leftmost
  (λ (l)
    (cond
      ((...) ...)
      ((...) ...)))) |#

#| A: Ok. |#

;; leftmost : List -> Atom
;; Given list, produces the leftmost atom in a nonempty list that does not contain an empty list.
(define leftmost
  (λ (l)
    (cond
      ((null? l) "No answer.")      ; This is when an empty list is found instead of an atom
      ((atom? (car l)) (car l))
      (else (leftmost (car l))))))

(leftmost '(((hot) (tuna (and))) cheese)) ; ==> 'hot
(leftmost '((potato) (chips ((with) fish) (chips)))) ; ==> 'potato
(leftmost '(((() four)) 17 (seventeen))) ; ==> "No answer."
(leftmost '()) ; ==> "No answer."

#| Book version does not guard for finding an empty list and produces an error in that case:

(define leftmost 
    (λ (l) 
      (cond 
        ((atom? (car l)) (car l)) 
        (else (leftmost (car l)))))) |#

#| Q: Do you remember what (or ...) does? |#
#| A: (or ...) asks questions one at a time until it finds one that is true.
      Then (or ...) stops, making its value true. If it cannot find a true 
      argument, the value of (or ...) is false. |#

#| Q: What is (and (atom? (car l)) (eq? (car l) x)) where x is pizza and 
      l is (mozzarella pizza) |#
#| A: #f. |#

#| Q: Why is it false? |#
#| A: Since (and ...) asks (atom? (car l)), which is true, it then asks (eq? (car l) x),
      which is false; hence it is #f. |#

#| Q: What is (and (atom? (car l)) (eq? (car l) x)) where x is pizza and 
      l is ((mozzarella mushroom) pizza) |#
#| A: #f. |#

#| Q: Why is it false? |#
#| A: Since (and ... ) asks (atom? (car l)), and (car l) is not an atom; so it is #f. |#

#| Q: Give an example for x and l where (and (atom? (car l)) (eq? (car l) x)) is true. |#
#| A: Here's one: x is pizza and l is (pizza (tastes good)). |#
(and (atom? (car '(pizza (tastes good))))
     (eq? (car '(pizza (tastes good))) 'pizza)) ; ==> #t

#| Q: Put in your own words what (and ... ) does. |#
#| A: (and ...) evaluates the expressions inside one at a time and stops to produce
      false if it comes across even a single expression that evaluates to false.
      If it finds no false, it evaluates to true.

      We put it in our words: 
      "(and ... ) asks questions one at a time until it finds one whose value is false.
      Then (and ... ) stops with false. If none of the expressions are false, (and ... ) is true." |#

#| Q: True or false: it is possible that one of the arguments of (and ...) and (or ...)
      is not considered? |#
#| A: True, because (and ...) stops if the first argument has the value #f, and (or ...) 
      stops if the first argument has the value #t . |#

#|    Note: (cond ...) also has the property of not considering all of 
      its arguments. Because of this property, however, neither (and ...) nor (or ...)
      can be defined as functions in terms of (cond ...), though both (and ...) and (or ...)
      can be expressed as abbreviations of (cond ...)-expressions: 
         (and a b) = (cond (a b) (else #f)) 
      and 
         (or a b) = (cond (a #t) (else b)) |#

#| Q: (eqlist? l1 l2) where l1 is (strawberry ice cream) and l2 is (strawberry ice cream) |#
#| A: #t. |#

#| Q: (eqlist? l1 l2) where l1 is (strawberry ice cream) and l2 is (strawberry cream ice) |#
#| A: #f. |#

#| Q: (eqlist? l1 l2) where l1 is (banana ((split))) and l2 is ((banana) (split)) |#
#| A: #f. |#

#| Q: (eqlist? l1 l2) where l1 is (beef ((sausage)) (and (soda))) and 
      l2 is (beef ((salami)) (and (soda))) |#
#| A: #f, but almost #t. |#

#| Q: (eqlist? l1 l2) where l1 is (beef ((sausage)) (and (soda))) and 
      l2 is (beef ((sausage)) (and (soda))) |#
#| A: #t. That's better. |#

#| Q: What is eqlist? |#
#| A: A function that determines if two lists are equal. |#

#| Q: How many questions will eqlist? have to ask about its arguments? |#
#| A: Nine. |#

#| Q: Can you explain why there are nine questions? |#
#| A: Here are our words: 
      "Each argument may be either 
      - empty, 
      - an atom consed onto a list, or 
      - a list consed onto a list. 
      For example, at the same time as the first argument may be the empty list, the 
      second argument could be the empty list or have an atom or a list in the car position." |#

#| Q: Write eqlist? using eqan? |#
#| A: Ok. |#

;; eqlist???? : List List -> Boolean
;; Given two lists, produces true if they are identical.
(define eqlist????
  (λ (l1 l2)
    (cond
      ((and (null? l1) (null? l2)) #t)             ;both lists are null and therefore the same
      ((and (atom? (car l1)) (atom? (car l2)))     ;both lists start with an atom and
       (cond                                         
         ((eqan? (car l1) (car l2))                ;atoms are the same      
          (eqlist???? (cdr l1) (cdr l2)))          ;look further in the lists. Else return false      
         (else #f)))                                   
      ((or (atom? (car l1)) (atom? (car l2))) #f)  ;atom still found as first then lists are not same 
      (else                                        ;first elements are both lists   
       (and                                        
        (eqlist???? (car l1) (car l2))             ;check if first elements are equal and if they are    
        (eqlist???? (cdr l1) (cdr l2)))))))        ;look further in the lists 

(eqlist???? '(strawberry ice cream) '(strawberry ice cream)) ; ==> #t
(eqlist???? '(strawberry ice cream) '(strawberry cream ice)) ; ==> #f
(eqlist???? '(strawberry ice cream) '(strawberry cream ice)) ; ==> #f
(eqlist???? '(banana ((split))) '((banana) (split))) ; ==> #f
(eqlist???? '(beef ((sausage)) (and (soda))) '(beef ((salami)) (and (soda)))) ; ==> #f
(eqlist???? '(beef ((sausage)) (and (soda))) '(beef ((sausage)) (and (soda)))) ; ==> #t

#| Book version is somewhat different from mine:
   I will keep it as the default function here |#

;; eqlist??? : List List -> Boolean
;; Given two lists, produces true if they are identical.
(define eqlist??? 
  (λ (l1 l2) 
    (cond 
      ((and (null? l1) (null? l2)) #t)         ;both list empty means they are the same
      ((and (null? l1) (atom? (car l2))) #f)   ;first list empty and second starts with atom means different 
      ((null? l1) #f)                          ;first still empty means they are different
      ((and (atom? (car l1)) (null? l2)) #f)   ;first starts with atom and second empty means different
      ((and (atom? (car l1)) (atom? (car l2))) 
       (and (eqan? (car l1) (car l2)) 
            (eqlist??? (cdr l1) (cdr l2))))    ;lists start with equal atoms. Look further in the lists
      ((atom? (car l1)) #f)                    ;first still starts with atom so they are different     
      ((null? l2) #f)                          ;second is empty means they are different   
      ((atom? (car l2)) #f)                    ;second starts with atom means they are different 
      (else                                    ;if we get here then 
       (and (eqlist??? (car l1) (car l2))      ;check if the first element lists 
            (eqlist??? (cdr l1) (cdr l2))))))) ;and the remaining lists are equal


#| Q: Is it okay to ask (atom? (car l2)) in the second question? |#
#| A: Yes, because we know that the second list cannot be empty.
      Otherwise the first question would have been true. |#

#| Q: And why is the third question (null? l1)? |#
#| A: At that point, we know that when the first argument is empty, the second argument is 
      neither the empty list nor a list with an atom as the first element. If (null? l1) is true now, 
      the second argument must be a list whose first element is also a list.|#

#| Q: True or false: if the first argument is () eqlist? responds with #t in only one case. |#
#| A: True. For (eqlist? '() l2) to be true, l2 must also be the empty list. |#

#| Q: Does this mean that the questions (and (null? 11 ) (null? l2)) and 
      (or (null? 11 ) (null? 12)) suffice to determine the answer in the first three cases? |#
#| A: Yes. If the first question is true, eqlist? responds with #t; otherwise, the answer is #f. |#

#| Q: Rewrite eqlist? |#
#| A: Yes. |#

;; eqlist?? : List List -> Boolean
;; Given two lists, produces true if they are identical.
(define eqlist?? 
  (λ (l1 l2) 
    (cond 
      ((and (null? l1) (null? l2)) #t)           ;both are empty so the same
      ((or (null? l1) (null? l2)) #f)            ;one empty then they are not the same 
      ((and (atom? (car l1)) (atom? (car l2))) 
       (and (eqan? (car l1) (car l2)) 
            (eqlist?? (cdr l1) (cdr l2))))       ;start with equal atoms so we look futher in the lists 
      ((or (atom? (car l1 ))                     ;one still starts with atom means they are different
           (atom? (car l2))) #f) 
      (else                              
       (and (eqlist?? (car l1 ) (car l2))        ;check if first elements lists are the same and 
            (eqlist?? (cdr l1 ) (cdr l2)))))))   ;the remaining lists are the same

#| Q: What is an S-expression? |#
#| A: An S-expression is either an atom or a (possibly empty) list of S-expressions. |#

#| Q: How many questions does equal? ask to determine whether two S-expressions are the same? |#
#| A: Four. The first argument may be an atom or a list of S-expressions at the same time as 
      the second argument may be an atom or a list of S-expressions. |#

#| Q: Write equal? |#
#| A: Ok. |#

;; equal : Sexp Sexp -> Boolean
;; Given two S-expressions, produces true if they are identical.
(define equal?
  (λ (s1 s2)
    (cond
      ((and (atom? s1) (atom? s2))      ;if both are atoms and
       (eqan? s1 s2))                   ;if equal, then true
      ((or (atom? s1)                   ;if atom still found then 
           (atom? s2)) #f)              ;obviously one is not an atom 
      (else (eqlist? s1 s2)))))         ;final alternative is that they are both lists, so compare

; Note that this function calls eqlist? that itself is below rewritten to call equal? !!

#| Book version doesn't use (or ...)

(define equal? 
    (λ (s1 s2) 
      (cond 
        ((and (atom? s1 ) (atom? s2)) 
         (eqan? s1 s2)) 
        ((atom? s1 ) #f) 
        ((atom? s2) #f) 
        (else (eqlist? s1 s2))))) |#

#| Q: Why is the second question (atom? s1) |#
#| A: If it is true, we know that the first argument is an atom and the second argument is a list. |#

#| Q: And why is the third question (atom? s2) |#
#| A: By the time we ask the third question we know that the first argument is not an atom. 
      So all we need to know in order to distinguish between the two remaining cases is whether
      or not the second argument is an atom. The first argument must be a list. |#

#| Q: Can we summarize the second question and the third question as (or (atom? s1) (atom? s2)) |#
#| A: Yes we can! |#

#| Q: Simplify equal? |#
#| A: See my version above. |#

#| Q: Does equal? ask enough questions? |#
#| A: Yes, all the four questions are covered. |#

#| Q: Now, rewrite eqlist? using equal? |#
#| A: Ok. |#

;; eqlist? : List List -> Boolean
;; Given two lists, produces true if they are identical.
(define eqlist? 
  (λ (l1 l2) 
    (cond 
      ((and (null? l1)
            (null? l2)) #t) 
      ((or (null? l1)
           (null? l2)) #f) 
      (else 
       (and (equal? (car l1) (car l2))    ; We call equal? here that itself uses eqlist? !!
            (eqlist? (cdr l1) (cdr l2)))))))

#| Book solution is identical. |#



#|               *** The Sixth Commandment ***

         Simplify only after the function is correct.       |#



#| Q: Here is rember after we replace lat by a list l of S-expressions and a by any S-expression.
      Can we simplify it?

(define rember 
    (λ (s l) 
      (cond 
        ((null? l) '()) 
        ((atom? (car l)) 
         (cond 
           ((equal? (car l) s) (cdr l)) 
           (else
            (cons (car l) 
                  (rember s (cdr l)))))) 
        (else
         (cond 
           ((equal? (car l) s) (cdr l)) 
           (else
            (cons (car l) 
                  (rember s 
                          (cdr l))))))))) |#

#| A: Obviously!
      Note: equal? works for both atoms and lists, so
      we can remove the redundant part that first asks ((atom? (car l)). |#

;; rember : Sexp List -> List
;; Given S-expression and list, produces a list with occurrences of S-expression removed.
(define rember 
  (λ (s l) 
    (cond 
      ((null? l) '())  
      (else
       (cond 
         ((equal? (car l) s) (cdr l)) 
         (else
          (cons (car l) 
                (rember s 
                        (cdr l)))))))))

#| Q: And how does that differ? |#
#| A: The function rember now removes the first matching S-expression s in l,
      instead of the first matching atom a in lat. |#

#| Q: Is rember a "star" function now? |#
#| A: No. |#

#| Q: Why not? |#
#| A: Because it only recurs on the cdr of l. |#

#| Q: Can rember be further simplified? |#
#| A: Yes. The inner (cond ...) asks question the outer (cond ...) could ask! |#

#| Q: Do it! |#
#| A: Ok. |#

;; rember.v2 : Sexp List -> List
;; Given S-expression and list, produces a list with occurrences of S-expression removed.
(define rember.v2
  (λ (s l)
    (cond
      ((null? l) '())
      ((equal? (car l) s)
       (cdr l))
      (else
       (cons (car l) (rember.v2 s (cdr l)))))))

#| Book solution is identical to mine. |#

#| Q: Does this new definition look simpler? |#
#| A: Yes, it does! |#

#| Q: And does it work just as well? |#
#| A: Yes, because we knew that all the cases and all the recursions were right
      before we simplified. |#

#| Q: Simplify insertL* |#
#| A: We can't. Before we can ask (eq? (car l) old) we need to know that (car l) is an atom. |#

#| Q: When functions are correct and well-designed, we can think about them easily. |#
#| A: And that saved us this time from getting it wrong. |#

#| Q: Can all functions that use eq? and =? be generalized by replacing eq? and =? by the 
      function equal? |#
#| A: Not quite; this won't work for eqan?, but will work for all others.
      In fact, disregarding the trivial example of eqan?, that is exactly what 
      we shall assume. |#