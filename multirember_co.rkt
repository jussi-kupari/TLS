#lang htdp/isl+

;; Run the stepper in ISL+

;; second-list-empty? : List List -> Boolean
;; Given two lists, produces true if the second is empty.
(define second-list-empty?
  (λ (x y)
    (null? y)))

;; length-first? : List List -> Boolean
;; Given two lists, produces the length of the first.
(define length-first? 
  (λ (x y) 
    (length x)))

(define multirember&co
   (lambda (a lat co)
     (cond
       ((null? lat)
        (co '() '()))
       ((eq? (car lat) a)
        (multirember&co a
                        (cdr lat)
                        (λ (newlat seen) 
                         (co newlat 
                              (cons (car lat) seen)))))
       (else
        (multirember&co a
                        (cdr lat)
                        (λ (newlat seen) 
                         (co (cons (car lat) newlat) 
                              seen)))))))

; (multirember&co 'tuna '() second-list-empty?)
; (multirember&co 'tuna '(tuna) second-list-empty?)
; (multirember&co 'tuna '(and tuna) second-list-empty?)
; (multirember&co 'tuna '(strawberries tuna and swordfish) second-list-empty?)
; (multirember&co 'tuna '(strawberries tuna and swordfish) length-first?)
; (multirember&co 'foo '(foo bar) list)

;; Run the stepper in ISL+
;; Below is the final collector for multirember&co


((lambda (newlat seen)
   ((lambda (newlat seen)
      ((lambda (newlat seen)
         ((lambda (newlat seen)
            ((lambda (x y) (length x)) (cons (car (list 'strawberries 'tuna 'and 'swordfish)) newlat) seen))
          newlat
          (cons (car (list 'tuna 'and 'swordfish)) seen)))
       (cons (car (list 'and 'swordfish)) newlat)
       seen))
    (cons (car (list 'swordfish)) newlat)
    seen))
 '()
 '())