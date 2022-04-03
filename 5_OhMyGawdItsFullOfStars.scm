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

#| Q: |#
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


