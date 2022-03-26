#lang racket

;; atom? : Any -> Boolean
;; Produces #true if input is an atom
(define atom? 
  (λ (x) 
    (and (not (pair? x)) (not (null? x)))))

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

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#