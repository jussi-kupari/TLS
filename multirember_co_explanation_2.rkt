#lang htdp/isl+

; https://stackoverflow.com/questions/7004636/explain-the-continuation-example-on-p-137-of-the-little-schemer/7005024#7005024


(define multirember&co
   (λ (a lat co)
     (cond
       ((null? lat)
        (co '() '()))
       ((eq? (car lat) a)
        (multirember&co a
                        (cdr lat)
                        (λ (new seen) 
                         (co new 
                              (cons (car lat) seen)))))
       (else
        (multirember&co a
                        (cdr lat)
                        (λ (new seen) 
                         (co (cons (car lat) new) 
                              seen)))))))


(multirember&co 'foo '(foo bar) list)


#|

(multirember&co 'foo '(foo bar) list)

At the start,

a = 'foo
lat = '(foo bar)
col = list

At the first iteration, the (eq? (car lat) a) condition matches,
since lat is not empty, and the first element of lat is 'foo.
This sets up the next recursion to multirember&co thusly:

a = 'foo
lat = '(bar)
col = (λ (new seen)
        (list new (cons 'foo seen))

At the next iteration, the else matches: since lat is not empty,
and the first element of lat is 'bar (and not 'foo).
Thus, for the next recursion, we then have:

a = 'foo
lat = '()
col = (lambda (new seen)
        ((lambda (new seen)
           (list new (cons 'foo seen)))
         (cons 'bar new)
         seen))

For ease of human reading (and avoid confusion), we can rename the
parameters (due to lexical scoping), without any change to the program's semantics:

col = (lambda (new1 seen1)
        ((lambda (new2 seen2)
           (list new2 (cons 'foo seen2)))
         (cons 'bar new1)
         seen1))

Finally, the (null? lat) clause matches, since lat is now empty. So we call

(col '() '())

which expands to:

((lambda (new1 seen1)
   ((lambda (new2 seen2)
      (list new2 (cons 'foo seen2)))
    (cons 'bar new1)
    seen1))
 '() '())

which (when substituting new1 = '() and seen1 = '()) becomes

((lambda (new2 seen2)
   (list new2 (cons 'foo seen2)))
 (cons 'bar '())
 '())

or (evaluating (cons 'bar '()))

((lambda (new2 seen2)
   (list new2 (cons 'foo seen2)))
 '(bar)
 '())

Now, substituting the values new2 = '(bar) and seen2 = '(), we get

(list '(bar) (cons 'foo '()))

or, in other words,

(list '(bar) '(foo))

to give our final result of

'((bar) (foo))

|#