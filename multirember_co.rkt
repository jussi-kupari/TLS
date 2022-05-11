;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname multirember_co) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Use ISL-with-lambda and run the stepper on these to get some understanding of what is going on

; http://www.michaelharrison.ws/weblog/2007/08/unpacking-multiremberco-from-tls/
; https://stackoverflow.com/questions/7004636/explain-the-continuation-example-on-p-137-of-the-little-schemer/7005024#7005024
; https://stackoverflow.com/questions/2018008/help-understanding-continuations-in-scheme?rq=1

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


;(multirember&co 'tuna '() second-list-empty?)
;(multirember&co 'tuna '(tuna) second-list-empty?)
;(multirember&co 'tuna '(and tuna) second-list-empty?)
;(multirember&co 'tuna '(strawberries tuna and swordfish) second-list-empty?)
(multirember&co 'tuna '(strawberries tuna and swordfish) length-first?)


 