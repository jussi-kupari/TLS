#lang racket

;; atom? : Any -> Boolean
;; Produces #true if input is an atom
(define atom? 
  (λ (x) 
    (and (not (pair? x)) (not (null? x)))))

#|                    Toys                    |#

#| Q: Is it true that this is an atom?  atom |#
#| A: Yes, because atom is a string of characters beginning with a letter |#
(atom? 'atom) ; ==> #t

#| Q: Is it true that this is an atom? turkey |#
#| A: Yes, because turkey is a string of characters beginning with a letter |#
(atom? 'turkey) ; ==> #t

#| Q: Is it true that this is an atom? 1492 |#
#| A: Yes, because 1492 is a string of digits |#
(atom? '1492) ; ==> #t

#| Q: Is it true that this is an atom? u |#
#| A: Yes, u is a string of letter characters length of one|#
(atom? 'u) ; ==> #t

#| Q: Is it true that this is an atom? *abc$ |#
#| A: Yes, *abc$ is also a string of characters including some special ones |#
(atom? '*abc$) ; ==> #t

#| Q: Is it true that this is a list? (atom) |#
#| A: Yes, (atom) is a list length of one because it is an atom enclosed in parentheses |#
(list? '(atom)) ; ==> #t

#| Q: Is it true that this is a list? (atom turkey or) |#
#| A: Yes, b/c this is three atoms enclosed in parentheses |#
(list? '(atom turkey or)) ; ==> #t

#| Q: Is it true that this is a list? (atom turkey) or |#
#| A: No, b/c these are two separate expressions: a list and an atom
   (list? '(atom turkey) 'or) ==>
   error (... the expected number of arguments does not match the given number) |#

#| Q: Is it true that this is a list? ((atom turkey) or) |#
#| A: Yes, this is a list containing a list and an atom |#
(list? '((atom turkey) or))

#| Q: Is it true that this is an S-expression? xyz |#
#| A: Yes, even atoms are expressions (everything is an expression) |#
(atom? 'xyz) ; ==> #t and therefore expression

#| Q: Is it true that this is an S-expression? (x y z) |#
#| A: Yes, all lists are expressions |#
(list? '(x y z)) ; ==> #t and therefore expression

#| Q: Is it true that this is an S-expression? ((x y) z) |#
#| A: Yes, b/c this is a valid list and lists are expressions |#
(list? '((x y) z)) ; ==> #t and therefore expression

#| Q: Is it true that this is a list? (how are you doing so far) |#
#| A: Yes, b/c a group of atoms enclosed in parenthesis is a valid list|#
(list? '(how are you doing so far)) ; ==> #t

#| Q: How many S-expressions are in the list (how are you doing so far) and what are they? |#
#| A: Each one of the atoms in the list is an expression, so six |#

#| Q: Is it true that this is a list? (((how) are) ((you) (doing so)) far) |#
#| A: Yes, It consists of valid expressions enclosed in parentheses|#
(list? '((((how) are) ((you) (doing so)) far))) ; ==> #t

#| Q: How many S-expressions are in the list (((how) are) ((you) (doing so)) far) and what are they? |#
#| A: There are 3 expressions in the list: two lists and an atom
     (note: all expression could be further divided into multiple expressions, right?) |#

#| Q: Is it true that this is a list? () |#
#| A: Yes, empty parentheses define an empty list |#
(list? '()) ; ==> #t

#| Q: Is it true that this is an atom? () |#
#| A: No, b/c () is a list as noted above |#
(atom? '()) ; ==> #f

#| Q: Is it true that this is a list? (() () () ()) |#
#| A: Yes, b/c this is four valid expressions enclosed in parentheses |#
(list? '(() () () ())) ; ==> #t

#| Q: What is the car of l where l is the argument (a b c) |#
#| A: a, b/c a is the first expression in the list |#
(car '(a b c)) ; ==> 'a

#| Q: What is the car of l where l is ((a b c) x y z) |#
#| A: (a b c), b/c (a b c) is the first expression in the list|#
(car '((a b c) x y z)) ; ==> '(a b c)

#| Q: What is the car of l where l is hotdog |#
#| A: Nothing, b/c hotdog is not a list but an atom
      (car 'hotdog) ==> 
      error car: contract violation
      expected: pair?
      given: 'hotdog |#

#| Q: What is the car of l where l is () |#
#| A: No answer, b/c there is no first element in an empty list
      (car '()) ==>
      first: contract violation
      expected: (and/c list? (not/c empty?))
      given: '() |#



#|            ** The Law of Car ** 
         The primitive car is defined 
           only for non-empty lists. |#



#| Q: What is the car of l where l is (((hotdogs)) (and) (pickle) relish) |#
#| A: The car of (((hotdogs)) (and) (pickle) relish) is ((hotdogs))
      This is the first expression in l
      read: "The list of the list of hotdogs" |#
(car '(((hotdogs)) (and) (pickle) relish)) ; ==> '((hotdogs))

#| Q: What is (car l) where l is (((hotdogs)) (and) (pickle) relish) |#
#| A: (car l) of (((hotdogs)) (and) (pickle) relish) is ((hotdogs)) like above
      (car l) is just another way of saying "car of l"|#
(car '(((hotdogs)) (and) (pickle) relish)) ; ==> '((hotdogs))

#| Q: What is (car (car l)) where l is (((hotdogs)) (and)) |#
#| A: (car (car l)) of (((hotdogs)) (and)) is (hotdogs) |#
 (car (car '(((hotdogs)) (and)))) ; ==> '(hotdogs)

#| Q: What is the cdr of l where l is (a b c) |#
#| A: The cdr of (a b c) is (b c), b/c car of (a b c) is a |#
(cdr '(a b c)) ; ==> '(b c)

#| Q: What is the cdr of l where l is ((a b c) x y z) |#
#| A: The cdr of ((a b c) x y z) is (x y z) |#
(cdr '((a b c) x y z)) ; ==> '(x y z)

#| Q: What is the cdr of l where l is (hamburger) |#
#| A: The cdr of (hamburger) is () |#
(cdr '(hamburger)) ; ==> '()

#| Q: What is (cdr l) where l is ((x) t r) |#
#| A: (cdr ((x) t r)) is (t r) |#
(cdr '((x) t r)) ; ==> '(t r)

#| Q: What is (cdr a) where a is hotdogs |#
#| A: No answer, b/c hotdogs is an atom and you can't ask and atom for a cdr
      (cdr 'hotdogs) ==>
      cdr: contract violation
      expected: pair?
      given: 'hotdogs|#

#| Q: What is (cdr l) where l is () |#
#| A: No answer, b/c only nonempty lists have one
      (cdr '()) ==>
      cdr: contract violation
      expected: pair?
      given: '() |#



#|            *** The Law of Cdr *** 
        The primitive cdr is defined only for 
      non-empty lists. The cdr of any nonempty
          list is always another list. |#



#| Q: What is (car (cdr l)) where l is ((b) (x y) ((c))) |#
#| A: (car (cdr ((b) (x y) ((c))))) is (x y), b/c (cdr l) is ((x y) ((c))) |#
(car (cdr '((b) (x y) ((c))))) ; ==> '(x y)

#| Q: What is (cdr (cdr l)) where l is ((b) (x y) ((c))) |#
#| A: (cdr (cdr ((b) (x y) ((c))))) is (((c))), b/c (cdr l) is ((x y) ((c))) |#
(cdr (cdr '((b) (x y) ((c))))) ; ==> '(((c)))  

; (car l) returns the first expression of l as it is
; (cdr l) returns l with the first expression removed 
(car '((a) (b))) ; ==> '(a)
(cdr '((a) (b))) ; ==> '((b))

#| Q: What is (cdr (car l)) where l is (a (b (c)) d) |#
#| A: No answer, b/c (car (a (b (c)) d)) is the atom 'a and you can't ask a cdr from an atom
      (cdr (car '(a (b (c)) d))) ==>
      cdr: contract violation
      expected: pair?
      given: 'a|#

#| Q: What does car take as an argument? |#
#| A: A non-empty list|#

#| Q: What does cdr take as an argument? |#
#| A: A non-empty list|#

#| Q: What is the cons of the atom a and the list l where a is peanut and l is (butter and jelly) 
      This can also be written "(cons a l)". Read: "cons the atom a onto the list l." |#
#| A: (cons peanut (butter and jelly)) is (peanut butter and jelly), b/c cons adds the expression
      as the first element to the beginning of a list |#
(cons 'peanut '(butter and jelly)) ; ==> '(peanut butter and jelly)

#| Q: What is the cons of s and l where s is (banana and) and l is (peanut butter and jelly) |#
#| A: (cons (banana and) (peanut butter and jelly) is ((banana and) peanut butter and jelly) |#
(cons '(banana and) '(peanut butter and jelly)) ;==> '((banana and) peanut butter and jelly)

#| Q: What is (cons s l) where s is ((help) this) and l is (is very ((hard) to learn)) |#
#| A: (((help) this) is very ((hard) to learn)), b/c cons just adds the expression at the
      beginning of the list |#
(cons '((help) this) '(is very ((hard) to learn))) ;==> '(((help) this) is very ((hard) to learn))

#| Q: What does cons take as its arguments? |#
#| A: It takes two arguments: an expression and a list |#

#| Q: What is (cons s l) where s is (a b (c)) and l is () |#
#| A: ((a b (c)))|#
(cons '(a b (c)) '()) ; ==> '((a b (c)))

#| Q: What is (cons s l) where s is a and l is () |#
#| A: (a) |#
(cons 'a '()) ; ==> '(a)

#| Q: What is (cons s l) where s is ((a b c)) and l is b |#
#| A: Not a list, b/c b is an atom and the second argument of cons must be a list |#
(cons '((a b c)) 'b) ; ==> '(((a b c)) . b)
(list? (cons '((a b c)) 'b)) ; ==> #f



#|           *** The Law of Cons *** 
      The primitive cons takes two arguments. 
       The second argument to cons must be a 
           list. The result is a list. |#



#| Q: What is (cons s (car l)) where s is a and l is ((b) c d). Why? |#
#| A: (a b), b/c (car ((b) c d)) is (b) and (cons a (b)) is (a b) |#
(car '((b) c d)) ; ==> '(b)
(cons 'a '(b)) ; == '(a b)
(cons 'a (car '((b) c d))) ; ==> '(a b)

#| Q: What is (cons s (cdr l)) where s is a and l is ((b) c d). Why? |#
#| A: (a c d), b/c (cdr ((b) c d)) is (c d) and (cons a (c d)) is (a c d) |#
(cdr '((b) c d)) ; ==> '(c d)
(cons 'a '(c d)) ; ==> '(a c d)
(cons 'a (cdr '((b) c d))) ; ==> '(a c d)

#| Q: Is it true that the list l is the null list where l is () |#
#| A: Yes, () is an empty list and therefore null |#
(null? '()) ; ==> #t

#| Q: What is (null? (quote ())) |#
#| A: This is true, b/c (quote ()) defines an empty list |#
(quote ()) ; ==> '()
(null? '()) ; ==> #t
(eq? '() (quote ())) ; ==> #t
(null? (quote ())) ; ==> #t

#| Q: Is (null? a) true or false where a is spaghetti |#
#| A: No answer, b/c you can't ask null? from an atom |#
; Note: actually this returns #f
(null? 'spaghetti) ; ==> #f



#|           *** The Law of Null? ***
    The primitive null? is defined only for lists. |#



#| Q: Is it true or false that s is an atom where s is Harry |#
#| A: True, because Harry is a string of characters starting with a letter |#
(atom? 'Harry) ; ==> #t

#| Q: Is (atom? s) true or false where s is Harry |#
#| A: True. See above. |#

#| Q: Is (atom? s) true or false where s is (Harry had a heap of apples) |#
#| A: False, b/c (Harry had a heap of apples) is a list |#
(atom? '(Harry had a heap of apples)) ; ==> #f

#| Q: How many arguments does atom? take and what are they? |#
#| A: I takes one argument that should be a valid expression |#

#| Q: Is (atom? (car l)) true or false where l is (Harry had a heap of apples) |#
#| A: True, b/c (car (Harry had a heap of apples)) is Harry and Harry is an atom |#
(atom? (car '(Harry had a heap of apples))) ; ==> #t

#| Q: Is (atom? (cdr l)) true or false where l is (Harry had a heap of apples)|#
#| A: False, b/c (cdr (Harry had a heap of apples)) is the list (had a heap of apples) |#
(cdr '(Harry had a heap of apples)) ; ==> '(had a heap of apples)
(atom? (cdr '(Harry had a heap of apples))) ; ==> #f

#| Q: Is (atom? (cdr l)) true or false where l is (Harry) |#
#| A: False, b/c (cdr (Harry))) is the null list '() and therefore not an atom |#
(cdr '(Harry)) ; ==> '()
(atom? (cdr '(Harry))) ; ==> #f

#| Q: Is (atom? (car (cdr l))) true or false where l is (swing low sweet cherry oat) |#
#| A: True, b/c (cdr (swing low sweet cherry oat)) is (low sweet cherry oat) and
      (car (low sweet cherry oat)) is low, which is an atom |#
(cdr '(swing low sweet cherry oat)) ; ==> '(low sweet cherry oat)
(car '(low sweet cherry oat)) ; ==> 'low
(atom? 'low) ; ==> #t

#| Q: Is (atom? (car (cdr l))) true or false where l is (swing (low sweet) cherry oat) |#
#| A: False, b/c (cdr (swing (low sweet) cherry oat)) is ((low sweet) cherry oat) and
      (car ((low sweet) cherry oat)) is (low sweet), which is a list |#
(cdr '(swing (low sweet) cherry oat)) ; ==> '((low sweet) cherry oat)
(car '((low sweet) cherry oat)) ; ==> '(low sweet)
(atom? '(low sweet)) ; ==> #f

#| Q: True or false: a1 and a2 are the same atom where a1 is Harry and a2 is Harry|#
#| A: True, b/c a1 is the atom Harry and a2 is the atom Harry |#

#| Q: Is (eq?1 a1 a2) true or false where a1 is Harry and a2 is Harry |#
#| A: True. See above |#
(eq? 'Harry 'Harry) ; ==> #t

#| Q: Is (eq? a1 a2) true or false where a1 is margarine and a2 is butter |#
#| A: False, b/c margarine and butter are two different atoms |#
(eq? 'margarine 'butter) ; ==> #f

#| Q: How many arguments does eq? take and what are they? |#
#| A: Two arguments that must be non-numeric atoms |#

#| Q: Is (eq ? l1 l2) true or false where l1 is () and l2 is (strawberry) |#
#| A: No answer, b/c eq? takes two atoms as arguments and () and (strawberry) are lists |#
; Note: (eq? '() '(strawberry)) returns #f
(eq? '() '(strawberry)) ; ==> #f

#| Q: Is (eq? n1 n2) true or false where n1 is 6 and n2 is 7 |#
#| A: No answer, b/c eq? works with non-numerical atoms and these are numbers |#
; Note: (eq? 6 7) returns #f, but (eq? 7 7) actually returns #t
(eq? 6 7) ; ==> #f



#|           *** The Law of Eq? ***
      The primitive eq? takes two arguments.
         Each must be a non-numeric atom. |#

#| Q: Is (eq? (car l) a) true or false where l is (Mary had a little lamb chop) and a is Mary |#
#| A: True, b/c (car (Mary had a little lamb chop)) is Mary and a is Mary|#
(car '(Mary had a little lamb chop)) ; ==> 'Mary
(eq? 'Mary 'Mary) ; ==> #t
(eq? (car '(Mary had a little lamb chop)) 'Mary) ; ==> #t

#| Q: Is (eq? (cdr l) a) true or false where l is (soured milk) and a is milk |#
#| A: No answer, b/c (cdr (soured milk)) returns the list (milk) and eq? doesn't work with lists |#
; Note: in reality this returns #f
(eq? (cdr '(soured milk)) 'milk) ; ==> #f

#| Q: Is (eq? (car l) (car (cdr l))) true or false where l is (beans beans we need jelly beans) |#
#| A: True, b/c (car (beans beans we need jelly beans)) is beans,
      (cdr (beans beans we need jelly beans)) is (beans we need jelly beans), and
      (car (beans we need jelly beans)) is beans|#
(eq? (car '(beans beans we need jelly beans)) (car (cdr '(beans beans we need jelly beans)))) ; ==> #t
(car '(beans beans we need jelly beans)) ; ==> 'beans
(cdr '(beans beans we need jelly beans)) ; ==> '(beans we need jelly beans)
(car '(beans we need jelly beans)) ; ==> 'beans
(eq? 'beans 'beans) ; ==> #t



#| ==> Now go make yourself a peanut butter and jelly sandwich. <== |#



#|        *** This space reserved for *** 
                 JELLY STAINS! |#





























