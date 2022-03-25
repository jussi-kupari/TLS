#lang racket
(require test-engine/racket-tests)

;; atom? : Any -> Boolean
;; Produces #true if input is an atom
(define atom? 
  (λ (x) 
    (and (not (pair? x)) (not (null? x)))))

#| Q: Is it true that this is an atom?  atom |#
#| A: Yes, because atom is a string of characters beginning with a letter|#
(atom? 'atom) ; ==> #t

#| Q: Is it true that this is an atom? turkey |#
#| A: Yes, because turkey is a string of characters beginning with a letter|#
(atom? 'turkey) ; ==> #t

#| Q: Is it true that this is an atom? 1492 |#
#| A: Yes, because 1492 is a string of digits |#
(atom? '1492) ; ==> #t

#| Q: Is it true that this is an atom? u |#
#| A: Yes, u is a string of letter characters length of one|#
(atom? 'u) ; ==> #t

#| Q: Is it true that this is an atom? *abc$ |#
#| A: Yes, *abc$ is also a string of characters |#
(atom? '*abc$) ; ==> #t

#| Q: Is it true that this is a list? '(atom) |#
#| A: Yes, '(atom) is a list length of one because it is an atom enclosed in parentheses |#
(list? '(atom)) ; ==> #t

#| Q: Is it true that this is a list? '(atom turkey or) |#
#| A: Yes, b/c this is three atoms enclosed in parentheses |#
(list? '(atom turkey or)) ; ==> #t