#lang racket

;; atom? : Any -> Boolean
;; Produces #true if input is an atom
(define atom? 
  (λ (x) 
    (and (not (pair? x)) (not (null? x)))))



#|                    Shadows                    |#



#| Q: Is 1 an arithmetic expression? |#
#| A: Yes. |#

#| Q: Is 3 an arithmetic expression? |#
#| A: Yes, of course. |#

#| Q: Is 1 + 3 an arithmetic expression? |#
#| A: Yes! |#

#| Q: Is 1 + 3 x 4 an arithmetic expression? |#
#| A: Definitely. |#

#| Q: Is cookie an arithmetic expression? |#
#| A: Yes. Are you almost ready for one? |#

#| Q: And, what about 3 exp y + 5 |#
#| A: Yes |#

#| Q: What is an arithmetic expression in your words? |#
#| A: In ours: "For the purpose of this chapter, an arithmetic expression is either an atom 
      (including numbers), or two arithmetic expressions combined by plus, times, or raise-to-power." |#

#| Q: What is (quote a)? |#
#| A: a. |#

#| Q: What is (quote +)? |#
#| A: The atom +, not the operation + |#

#| Q: What does (quote x) stand for? |#
#| A: The atom x, not the operation x |#

#| Q: Is (eq? (quote a) y) true or false where y is a? |#
#| A: True. a is the same as a. |#

#| Q: Is (eq? x y) true or false where x is a and y is a? |#
#| A: That's the same question again. And the answer is still true. |#

#| Q: Is (n + 3) an arithmetic expression? |#
#| A: Not really, since there are parentheses around n + 3. Our definition of arithmetic 
      expression does not mention parentheses. |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#

#| Q: |#
#| A: |#