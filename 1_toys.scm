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
   (list? '(atom turkey) 'or)
   ==> error (... the expected number of arguments does not match the given number) |#

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
      (car 'hotdog)
      => error car: contract violation
      expected: pair?
      given: 'hotdog |#

#| Q: What is the car of l where l is () |#
#| A: Nothing, b/c there is no first element in an empty list
      (car '())
      first: contract violation
      expected: (and/c list? (not/c empty?))
      given: '() |#

#| ** The Law of Car ** 
The primitive car is defined 
only for non-empty lists. |#