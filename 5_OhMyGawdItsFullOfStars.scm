#lang racket

;; atom? : Any -> Boolean
;; Produces #true if input is an atom
(define atom? 
  (λ (x) 
    (and (not (pair? x)) (not (null? x)))))

;; lat? : List-of-Anything -> Boolean
;; Given list, produces true if it only contains atoms
(define lat? 
  (λ (l) 
    (cond 
      ((null? l) #t) 
      ((atom? (car l)) (lat? (cdr l))) 
      (else #f))))

;; plus : WN WN -> WN
;; Given two whole numbers (nonnegative integers), produces their sum
(define plus
  (λ (n m)
    (cond
      ((zero? m) n)
      (else
       (add1 (plus n (sub1 m)))))))

;; same-num? : WN WN -> Boolean
;; Given two whole numbers, produces true if they are the same.
(define same-num?
  (λ (n m)
    (cond
      ((zero? m) (zero? n))
      ((zero? n) #f)
      (else
       (same-num? (sub1 n) (sub1 m))))))

;; eqan? : Atom Atom -> Boolean
;; Given two atoms, produces true if they are the same atom.
(define eqan?
  (λ (a1 a2)
    (cond
      ((and (number? a1)
            (number? a2)
            (same-num? a1 a2)) #t)
      ((or (number? a1)
           (number? a2)) #f)
      (else (eq? a1 a2)))))



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
      (else (cons (rember* a (car l))        ; cons result of *rember on (car l) 
                  (rember* a (cdr l)))))))   ; on the result of *rember on (cdr l)

(rember* 'cup '((coffee) cup ((tea) cup) (and (hick)) cup))
; ==> ((coffee) ((tea)) (and (hick)))
(rember* 'sauce '(((tomato sauce)) ((bean) sauce) (and ((flying)) sauce)))
;==> '(((tomato)) ((bean)) (and ((flying))))

#| Book version of rember* is identical to mine. |#

#| Using arguments from one of our previous examples, follow through this to see how it 
   works. Notice that now we are recurring down the car of the list, instead of just the 
   cdr of the list. |#

#| Q: (lat ? l) where l is (((tomato sauce)) ((bean) sauce) (and ((flying)) sauce)) |#
#| A: False. |#
(lat? '(((tomato sauce)) ((bean) sauce) (and ((flying)) sauce))) ; ==> #f

#| Q: Is (car l) an atom where l is (((tomato sauce)) ((bean) sauce) (and ((flying)) sauce)) |#
#| A: No it is not. |#
(atom? (car '(((tomato sauce)) ((bean) sauce) (and ((flying)) sauce)))) ; ==> #f

#| Q: What is (insertR* new old l) where new is roast old is chuck and 
      l is ((how much (wood)) could ((a (wood) chuck)) (((chuck))) (if (a) ((wood chuck))) could chuck wood) |#
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
;; Given two atoms and a list, inserts the first atom on the right of any occurrecne of the second atom
(define insertR*
  (λ (new old l)
    (cond
      ((null? l) '())                        ; empty list returns empty of course
      ((atom? (car l))                       ; if first element in an atom
       (cond
         ((eq? (car l) old)                  ; and matches with 'old
          (cons old                          ; cons 'old to the cons of 'new and natural recursion
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
#| A: Both recur on the (car l) when it is a list and then recur with (cdr l). |#

#| Q: How are all *-functions similar? |#
#| A: They all ask three quesions and, in addition to recurring on (cdr l),
      they all recur on (car l) when it is a list. |#

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
#| A: occur* |#

#| Q: Write occur*
(define occur*
  (λ (a l)
    (cond
      ((...) ...)
      ((...) ...)
      ((...) ...)))) |#

#| A: Ok. |#

;; occur* : Atom List -> WN
;; Given atom and list, produces the sum of occurrences of atom in the list.
(define occur*
  (λ (a l)
    (cond
      ((null? l) 0)                                  ; if list is empty, zero occurrences
      ((atom? (car l))                               ; if the first element is an atom, then
       (cond
         ((eq? (car l) a)                            ; if the same as 'a
          (add1 (occur* a (cdr l))))                 ; add one and recur on (cdr l)
         (else (occur* a (cdr l)))))                 ; otherwse just skip over (car l) and recur on (cdr l) 
      (else                                          ; if (car l) is a list   
       (plus (occur* a (car l))
             (occur* a (cdr l)))))))                 ; add count of 'a in (car l) to recursion with (cdr l)


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
;; Given two atoms and list, substitutes each occurrece of first atom for the second atom in the list.
(define subst*
  (λ (new old l)
    (cond
      ((null? l) '())                             ; empty list returns empty
      ((atom? (car l))                            ; if the first element is an atom
       (cond
         ((eq? (car l) old)                       ; and same as old
          (cons new
                (subst* new old (cdr l))))        ; cons new to the result of recurring with (cdr l)
         (else (cons (car l)
                     (subst* new old (cdr l)))))) ; o/w cons first element to the result of recurring with (cdr l)) 
      (else                                       ; if first element is a list
       (cons (subst* new old (car l))             ; substitute in that list and cons the resulting list
             (subst* new old (cdr l)))))))        ; with the natural recursion with (cdr l)

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
;; Given two atoms and list, inserts the first atom on the left of each occurrence of the second atom.
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
#| A: True, b/c the atom chips appear in the list. |#

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

;; member* : Atom List -> Boolean
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

#| A: True. |#

#| Q: Which chips did it find? |#
#| A: (chips ((with) fish) |#

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
#| A: It finds the leftmost atom in a nonempty list of expressions
      that does not contain an empty list. |#

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

#| Q: Do you remember what (or ... ) does? |#
#| A: (or ...) asks questions one at a time until it finds one that is true.
      Then (or ...) stops, making its value true. If it cannot find a true 
      argument, the value of (or ...) is false. |#

#| Q: What is (and (atom? (car l)) (eq? (car l) x)) where x is pizza and 
      l is (mozzarella pizza) |#
#| A: False. |#

#| Q: Why is it false? |#
#| A: Because (and ...) all of the expressions inside to evaluate to true,
      but here the second evaluates to false (eq? mozzarella pizza) |#

#| Q: What is (and (atom? (car l)) (eq? (car l) x)) where x is pizza and 
      l is ((mozzarella mushroom) pizza) |#
#| A: False. |#

#| Q: Why is it false? |#
#| A: The first question already evaluates to false and therefore the whole
      (and ...) evaluates to false. |#

#| Q: Give an example for x and l where (and (atom? (car l)) (eq? (car l) x)) is true. |#
#| A: x is mozzarella and l is (mozzarella (and ham) pizza) |#
(and (atom? (car '(mozzarella (and ham) pizza)))
     (eq? (car '(mozzarella (and ham) pizza)) 'mozzarella)) ; ==> #t

#| Q: Put in your own words what (and . . . ) does. |#
#| A: (and ...) evaluates the expressions inside one at a time and produces
      false if it comes across even a single expression evaluates to false.
      If it finds no false, it evaluates to true. |#

#| Q: True or false: it is possible that one of the arguments of (and ...) and (or ...)
      is not considered? 1 |#
#| A: Yes, b/c (and ...) will stop and return false when encountering false and doesn't
      care about the remaining expressions. Similarly, (or ...) will evaluate to true
      and stop when finding the first true. |#

#| Q: (eqlist ? l1 l2) where l1 is (strawberry ice cream) and l2 is (strawberry ice cream) |#
#| A: True. |#

#| Q: (eqlist? l1 l2) where l1 is (strawberry ice cream) and l2 is (strawberry cream ice) |#
#| A: False. |#

#| Q: (eqlist? l1 l2) where l1 is (banana ((split))) and l2 is ((banana) (split)) |#
#| A: False. |#

#| Q: (eqlist? l1 l2) where l1 is (beef ((sausage)) (and (soda))) and 
      l2 is (beef ((salami)) (and (soda))) |#
#| A: False. |#

#| Q: (eqlist? l1 l2) where l1 is (beef ((sausage)) (and (soda))) and 
      l2 is (beef ((sausage)) (and (soda))) |#
#| A: True. |#

#| Q: What is eqlist? |#
#| A: A function that checks if two lists are equal. |#

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

(define eqlist?
  (λ (l1 l2)
    (cond
      ((and                                            ;if both lists empty lists are the same
        (null? l1)
        (null? l2)) #t)
      ((and                                            ;if both first elements atoms
        (atom? (car l1))
        (atom? (car l2)))
       (cond                                           ;then if
         ((eqan? (car l1) (car l2))                    ;first elements equal 
          (eqlist? (cdr l1) (cdr l2)))                 ;continue with comparing further
         (else #f)))                                   ;else elements not equal and false
      ((or                             
        (and (atom? (car l1))
             (not (atom? (car l2))))                   ;if one first element is atom and one list then false 
        (and (not (atom? (car l1)))                    ;note the use of (not ...) 
             (atom? (car l2)))) #f) 
      (else                                            ;else first elements are both lists
       (and
        (eqlist? (car l1) (car l2))                    ;and if not equal then evaluate to false 
        (eqlist? (cdr l1) (cdr l2)))))))               ;otherwise further in the list

(eqlist? '(strawberry ice cream) '(strawberry ice cream)) ; ==> #t
(eqlist? '(strawberry ice cream) '(strawberry cream ice)) ; ==> #f
(eqlist? '(strawberry ice cream) '(strawberry cream ice)) ; ==> #f
(eqlist? '(banana ((split))) '((banana) (split))) ; ==> #f
(eqlist? '(beef ((sausage)) (and (soda))) '(beef ((salami)) (and (soda)))) ; ==> #f
(eqlist? '(beef ((sausage)) (and (soda))) '(beef ((sausage)) (and (soda)))) ; ==> #t

#| Book version is somewhat different from mine:
(define eqlist?? 
    (λ (l1 l2) 
      (cond 
        ((and (null? l1) (null? l2)) #t)         
        ((and (null? l1) (atom? (car l2))) #f)    
        ((null? l1) #f) 
        ((and (atom? (car l1)) (null? l2)) #f) 
        ((and (atom? (car l1)) 
              (atom? (car l2))) 
         (and (eqan? (car l1) (car l2)) 
              (eqlist?? (cdr l1) (cdr l2)))) 
        ((atom? (car l1)) #f) 
        ((null? l2) #f) 
        ((atom? (car l2)) #f) 
        (else 
         (and (eqlist?? (car l1) (car l2)) 
              (eqlist?? (cdr l1) (cdr l2))))))) |#




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


