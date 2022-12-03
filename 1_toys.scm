#lang racket

(require rackunit "Atom.scm")



#|                    Toys                    |#



#| Q: Is it true that this is an atom? atom |#
#| A: Yes, because atom is a string of characters beginning with the letter a. |#
(check-true (atom? 'atom))

#| Q: Is it true that this is an atom? turkey |#
#| A: Yes, because turkey is a string of characters beginning with a letter. |#
(check-true (atom? 'turkey))

#| Q: Is it true that this is an atom? 1492 |#
#| A: Yes, because 1492 is a string of digits. |#
(check-true (atom? '1492))

#| Q: Is it true that this is an atom? u |#
#| A: Yes, because u is a string of one character, which is a letter. |#
(check-true (atom? 'u))

#| Q: Is it true that this is an atom? *abc$ |#
#| A: Yes, because *abc$ is a string of characters beginning with a letter or special character 
      other than a left "(" or right ")" parenthesis. |#
(check-true (atom? '*abc$))

#| Q: Is it true that this is a list? (atom) |#
#| A: Yes, because (atom) is an atom enclosed by parentheses. |#
(check-true (list? '(atom)))

#| Q: Is it true that this is a list? (atom turkey or) |#
#| A: Yes, because it is a collection of atoms enclosed by parentheses. |#
(check-true (list? '(atom turkey or)))

#| Q: Is it true that this is a list? (atom turkey) or |#
#| A: No, because these are actually two S-expressions not enclosed by parentheses. 
      The first one is a list containing two atoms, and the second one is an atom. |#

#| Q: Is it true that this is a list? ((atom turkey) or) |#
#| A: Yes, because the two S-expressions are now enclosed by parentheses. |#
(check-true (list? '((atom turkey) or)))

#| Q: Is it true that this is an S-expression? xyz |#
#| A: Yes, because all atoms are S-expressions. |#
(check-true (atom? 'xyz)) ; and therefore S-expression

#| Q: Is it true that this is an S-expression? (x y z) |#
#| A: Yes, because it is a list. |#
(check-true (list? '(x y z))) ; and therefore S-expression

#| Q: Is it true that this is an S-expression? ((x y) z) |#
#| A: Yes, because all lists are S-expressions. |#
(check-true (list? '((x y) z)))

#| Q: Is it true that this is a list? (how are you doing so far) |#
#| A: Yes, because it is a collection of S-expressions enclosed by parentheses. |#
(check-true (list? '(how are you doing so far)))

#| Q: How many S-expressions are in the list (how are you doing so far) and what are they? |#
#| A: Six: how, are, you, doing, so, and far.

      Note: also the whole list is one S-expression |#

#| Q: Is it true that this is a list? (((how) are) ((you) (doing so)) far) |#
#| A: Yes, because it is a collection of S-expressions enclosed by parentheses. |#
(check-true (list? '((((how) are) ((you) (doing so)) far))))

#| Q: How many S-expressions are in the list (((how) are) ((you) (doing so)) far) and what are they? |#
#| A: Three: ((how) are), ((you) (doing so)), and far. 

      Note: all the S-expressions could be further divided into multiple expressions down
      to single atoms, right? |#

#| Q: Is it true that this is a list? () |#
#| A: Yes, because it contains zero S-expressions enclosed by parentheses. This special 
      S-expression is called the null (or empty) list. |#
(check-true (list? '()))

#| Q: Is it true that this is an atom? () |#
#| A: No, because() is just a list. |#
(check-false (atom? '()))

#| Q: Is it true that this is a list? (() () () ()) |#
#| A: Yes, because it is a collection of S-expressions enclosed by parentheses. |#
(check-true (list? '(() () () ())))

#| Q: What is the car of l where l is the argument (a b c) |#
#| A: a, because a is the first atom of this list. |#
(check-equal? (car '(a b c)) 'a) 

#| Q: What is the car of l where l is ((a b c) x y z) |#
#| A: (a b c), because (a b c) is the first S-expression of this non-empty list. |#
(check-equal? (car '((a b c) x y z)) '(a b c)) ; ==> '(a b c)

#| Q: What is the car of l where l is hotdog |#
#| A: No answer. You cannot ask for the car of an atom. |#
(check-exn exn:fail? (thunk (car 'hotdog)))

#| Q: What is the car of l where l is () |#
#| A: No answer. You cannot ask for the car of the empty list. |#
(check-exn exn:fail? (thunk (car '())))


#|            *** The Law of Car *** 
           The primitive car is defined 
             only for non-empty lists.            |#



#| Q: What is the car of l where l is (((hotdogs)) (and) (pickle) relish) |#
#| A: ((hotdogs)), read as: "The list of the list of hotdogs. " 
      ((hotdogs)) is the first S-expression of l.  |#
(check-equal? (car '(((hotdogs)) (and) (pickle) relish)) '((hotdogs)))

#| Q: What is (car l) where l is (((hotdogs)) (and) (pickle) relish) |#
#| A: ((hotdogs)), because ( car l) is another way to ask for 
      "the car of the list l." |#
(check-equal? (car '(((hotdogs)) (and) (pickle) relish)) '((hotdogs)))

#| Q: What is (car (car l)) where l is (((hotdogs)) (and)) |#
#| A: (hotdogs). |#
(check-equal? (car (car '(((hotdogs)) (and)))) '(hotdogs))

#| Q: What is the cdr of l where l is (a b c) |#
#| A: (b c), because (b c) is the list l without (car l). |#
(check-equal? (cdr '(a b c)) '(b c))

#| Q: What is the cdr of l where l is ((a b c) x y z) |#
#| A: (x y z). |#
(check-equal? (cdr '((a b c) x y z)) '(x y z))

#| Q: What is the cdr of l where l is (hamburger) |#
#| A: (). |#
(check-equal? (cdr '(hamburger)) '())

#| Q: What is (cdr l) where l is ((x) t r) |#
#| A: (t r), because (cdr l) is just another way to ask for "the cdr of the list l." |#
(check-equal? (cdr '((x) t r)) '(t r))

#| Q: What is (cdr a) where a is hotdogs |#
#| A: No answer. You cannot ask for the cdr of an atom. |#
(check-exn exn:fail? (thunk (cdr 'hotdogs)))

#| Q: What is (cdr l) where l is () |#
#| A: No answer. You cannot ask for the cdr of the null list. |#
(check-exn exn:fail? (thunk (cdr '())))


#|            *** The Law of Cdr *** 
        The primitive cdr is defined only for 
      non-empty lists. The cdr of any nonempty
          list is always another list.            |#



#| Q: What is (car (cdr l)) where l is ((b) (x y) ((c))) |#
#| A: (x y), because ((x y) ((c))) is (cdr l), and (x y) is the car of (cdr l). |#
(check-equal? (car (cdr '((b) (x y) ((c))))) '(x y)) 

#| Q: What is (cdr (cdr l)) where l is ((b) (x y) ((c))) |#
#| A: (((c))), because ((x y) ((c))) is (cdr l), and (((c))) is the cdr of (cdr l).  |#
(check-equal? (cdr (cdr '((b) (x y) ((c))))) '(((c)))) 
; Note
; (car l) returns the first expression of l as it is
; (cdr l) returns l with the first expression removed 
(check-equal? (car '((a) (b))) '(a))
(check-equal? (cdr '((a) (b))) '((b)))

#| Q: What is (cdr (car l)) where l is (a (b (c)) d) |#
#| A: No answer, since (car l) is an atom, and cdr does not take an atom as an argument;
      see The Law of Cdr.|#
(check-exn exn:fail? (thunk (cdr (car '(a (b (c)) d)))))

#| Q: What does car take as an argument? |#
#| A: It takes any non-empty list. |#

#| Q: What does cdr take as an argument? |#
#| A: It takes any non-empty list. |#

#| Q: What is the cons of the atom a and the list l where a is peanut and l is (butter and jelly) 
      This can also be written "(cons a l)". Read: "cons the atom a onto the list l." |#
#| A: (peanut butter and jelly), because cons adds an atom to the front of a list. |#
(check-equal? (cons 'peanut '(butter and jelly)) '(peanut butter and jelly))

#| Q: What is the cons of s and l where s is (banana and) and l is (peanut butter and jelly) |#
#| A: ((banana and) peanut butter and jelly), because cons adds any S-expression to the 
      front of a list. |#
(check-equal? (cons '(banana and) '(peanut butter and jelly)) '((banana and) peanut butter and jelly))

#| Q: What is (cons s l) where s is ((help) this) and l is (is very ((hard) to learn)) |#
#| A: (((help) this) is very ((hard) to learn)). |#
(check-equal? (cons '((help) this) '(is very ((hard) to learn))) '(((help) this) is very ((hard) to learn)))

#| Q: What does cons take as its arguments? |#
#| A: cons takes two arguments: the first one is any S-expression; 
      the second one is any list. |#

#| Q: What is (cons s l) where s is (a b (c)) and l is () |#
#| A: ((a b (c))), because () is a list.|#
(check-equal? (cons '(a b (c)) '()) '((a b (c))))

#| Q: What is (cons s l) where s is a and l is () |#
#| A: (a). |#
(check-equal? (cons 'a '()) '(a))

#| Q: What is (cons s l) where s is ((a b c)) and l is b |#
#| A: No answer, since the second argument l must be a list.  |#

;Note
(cons '((a b c)) 'b) ; ==> '(((a b c)) . b)
(list? (cons '((a b c)) 'b)) ; ==> #f

#| Q: What is (cons s l) where s is a and l is b? |#
#| A: No answer. Why?
      Because the second argument is not a list. |#

;Note
(cons 'a 'b) ; ==> '(a . b)
(list? (cons 'a 'b)) ; ==> #f



#|            *** The Law of Cons *** 
       The primitive cons takes two arguments. 
        The second argument to cons must be a 
            list. The result is a list.            |#



#| Q: What is (cons s (car l)) where s is a and l is ((b) c d). |#
#| A: (a b). Why?
      Because (car ((b) c d)) is (b) and (cons a (b)) is (a b) |#
(check-equal? (car '((b) c d)) '(b))
(check-equal? (cons 'a '(b)) '(a b))
(check-equal? (cons 'a (car '((b) c d))) '(a b))

#| Q: What is (cons s (cdr l)) where s is a and l is ((b) c d). |#
#| A: (a c d). Why?
      Because (cdr ((b) c d)) is (c d) and (cons a (c d)) is (a c d). |#
(check-equal? (cdr '((b) c d)) '(c d))
(check-equal? (cons 'a '(c d)) '(a c d))
(check-equal? (cons 'a (cdr '((b) c d))) '(a c d))

#| Q: Is it true that the list l is the null list where l is () |#
#| A: Yes, because it is the list composed of zero S-expressions. 
      This question can also be written: (null? l). |#
(check-true (null? '()))

#| Q: What is (null? (quote ())) |#
#| A: True, because (quote ()) is a notation for the null list. |#
(check-equal? (quote ()) '())
(check-true (null? '()))
(check-equal? '() (quote ()))
(check-true (null? (quote ())))

#| Q: Is (null? l) true or false where l is (a b c)  |#
#| A: False, because l is a non-empty list.  |#
(check-false (null? '(a b c)))

#| Q: Is (null? a) true or false where a is spaghetti |#
#| A: No answer, because you cannot ask null? of an atom.  |#

; Note
(check-false (null? 'spaghetti))



#|            *** The Law of Null? ***
    The primitive null? is defined only for lists.            |#



#| Q: Is it true or false that s is an atom where s is Harry |#
#| A: True, because Harry is a string of characters beginning with a letter. |#
(check-true (atom? 'Harry))

#| Q: Is (atom? s) true or false where s is Harry |#
#| A: True, because (atom? s) is just another way to ask "Is s is an atom?" |#
(check-true (atom? 'Harry))

#| Q: Is (atom? s) true or false where s is (Harry had a heap of apples) |#
#| A: False, since s is a list. |#
(check-false (atom? '(Harry had a heap of apples)))

#| Q: How many arguments does atom? take and what are they? |#
#| A: It takes one argument. The argument can be any S-expression. |#

#| Q: Is (atom? (car l)) true or false where l is (Harry had a heap of apples)? |#
#| A: True, because (car l) is Harry, and Harry is an atom. |#
(check-true (atom? (car '(Harry had a heap of apples))))

#| Q: Is (atom? (cdr l)) true or false where l is (Harry had a heap of apples)? |#
#| A: False. (cdr l) produces a list |#
(check-equal? (cdr '(Harry had a heap of apples)) '(had a heap of apples))
(check-false (atom? (cdr '(Harry had a heap of apples))))

#| Q: Is (atom? (cdr l)) true or false where l is (Harry)? |#
#| A: False, because the list () is not an atom. |#
(check-equal? (cdr '(Harry)) '())
(check-false (atom? (cdr '(Harry))))

#| Q: Is (atom? (car (cdr l))) true or false where l is (swing low sweet cherry oat)? |#
#| A: True, because (cdr l) is (low sweet cherry oat), and (car (cdr l)) is low, which is an atom. |#
(check-equal? (cdr '(swing low sweet cherry oat)) '(low sweet cherry oat))
(check-equal? (car '(low sweet cherry oat)) 'low)
(check-true (atom? 'low))

#| Q: Is (atom? (car (cdr l))) true or false where l is (swing (low sweet) cherry oat)? |#
#| A: False, since (cdr l) is ((low sweet) cherry oat), and (car (cdr l)) is (low sweet),
      which is a list. |#
(check-equal? (cdr '(swing (low sweet) cherry oat)) '((low sweet) cherry oat))
(check-equal? (car '((low sweet) cherry oat)) '(low sweet))
(check-false (atom? '(low sweet)))

#| Q: True or false: a1 and a2 are the same atom where a1 is Harry and a2 is Harry? |#
#| A: True, because a1 is the atom Harry and a2 is the atom Harry. |#

#| Q: Is (eq? a1 a2) true or false where a1 is Harry and a2 is Harry? |#
#| A: True, because (eq? a1 a2) is just another way to ask, "Are a1 and a2 the same 
      non-numeric atom?" |#
(check-true (eq? 'Harry 'Harry))

#| Q: Is (eq? a1 a2) true or false where a1 is margarine and a2 is butter? |#
#| A: False, since a1 and a2 are different atoms.  |#
(check-false (eq? 'margarine 'butter))

#| Q: How many arguments does eq? take and what are they? |#
#| A: It takes two arguments. Both of them must be non-numeric atoms.  |#

#| Q: Is (eq? l1 l2) true or false where l1 is () and l2 is (strawberry)? |#
#| A: No answer, () and (strawberry) are lists.  |#

;Note: In practice, lists m83' be arguments of eq?. Two lists are eq? if they are the same list. 
(check-false (eq? '() '(strawberry)))

#| Q: Is (eq? n1 n2) true or false where n1 is 6 and n2 is 7? |#
#| A: No answer, 6 and 7 are numbers. |#

; Note: In practice, some numbers may be arguments of eq?. 
(check-false (eq? 6 7))



#|            *** The Law of Eq? ***
      The primitive eq? takes two arguments.
         Each must be a non-numeric atom.            |#



#| Q: Is (eq? (car l) a) true or false where l is (Mary had a little lamb chop) and a is Mary? |#
#| A: True, because (car l) is the atom Mary, and the argument a is also the atom Mary.  |#
(check-equal? (car '(Mary had a little lamb chop)) 'Mary)
(check-true (eq? 'Mary 'Mary))
(check-true (eq? (car '(Mary had a little lamb chop)) 'Mary))

#| Q: Is (eq? (cdr l) a) true or false where l is (soured milk) and a is milk? |#
#| A: No answer, because (cdr (soured milk)) returns the list (milk) and
      eq? doesn't work with lists. See The Laws of Eq? and Cdr.  |#

; Note: in #lang racket this returns #f
(check-false (eq? (cdr '(soured milk)) 'milk))

#| Q: Is (eq? (car l) (car (cdr l))) true or false where l is (beans beans we need jelly beans) |#
#| A: True, because it compares the first and second atoms in the list. |#
(check-true (eq? (car '(beans beans we need jelly beans)) (car (cdr '(beans beans we need jelly beans)))))
(check-equal? (car '(beans beans we need jelly beans)) 'beans)
(check-equal? (cdr '(beans beans we need jelly beans)) '(beans we need jelly beans))
(check-equal? (car '(beans we need jelly beans)) 'beans)
(check-true (eq? 'beans 'beans))



#| ==> Now go make yourself a peanut butter and jelly sandwich. <== |#



#|          *** This space reserved for *** 
                     JELLY STAINS!                   |#





















