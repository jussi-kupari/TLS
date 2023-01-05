#lang racket

(require (only-in "Atom.scm" atom?)
         (only-in "4_NumbersGames.scm" plus **))

(define Zero?
  (λ (numb)
      ((null? numb))))