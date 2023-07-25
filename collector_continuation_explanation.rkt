#lang htdp/isl+

; https://stackoverflow.com/questions/2018008/help-understanding-continuations-in-scheme?rq=1

#|
Try something simpler to see how this works.
For example, here's a version of a list-sum function
that receives a continuation argument (which is often called k):

(define (list-sum l k)
  (if (null? l)
    ???
    (list-sum (cdr l) ???)))


The basic pattern is there, and the missing parts are where the
interesting things happen. The continuation argument is a function
that expects to receive the result -- so if the list is null, it's
clear that we should send it 0, since that is the sum:

(define (list-sum l k)
  (if (null? l)
    (k 0)
    (list-sum (cdr l) ???)))


Now, when the list is not null, we call the function recursively with
the list's tail (in other words, this is an iteration), but the question
is what should the continuation be. Doing this:

(define (list-sum1 l k)
  (if (null? l)
    (k 0)
    (list-sum1 (cdr l) k)))


is clearly wrong -- it means that k will eventually receive the the
sum of (cdr l) instead of all of l. Instead, use a new function there,
which will sum up the first element of l too along with the value that it receives:

(define (list-sum2 l k)
  (if (null? l)
    (k 0)
    (list-sum2 (cdr l) (λ (sum) (+ (car l) sum)))))


This is getting closer, but still wrong. But it's a good point to think about
how things are working -- we're calling list-sum with a continuation that will
itself receive the overall sum, and add the first item we see now to it.
The missing part is evident in the fact that we're ignoring k. What we need
is to compose k with this function -- so we do the same sum operation,
then send the result to k:


(define (list-sum3 l k)
  (if (null? l)
    (k 0)
    (list-sum3 (cdr l) (λ (sum) (k (+ sum (car l)))))))


which is finally working. (BTW, remember that each of these lambda functions has its own "copy" of l.)
You can try this with:

(list-sum3 '(1 2 3 4 5) (lambda (x) x))

|#

;; The final collector function is below 
  ((lambda (s)
     ((lambda (s)
        ((lambda (s)
           ((lambda (s)
              ((lambda (s)
                 ((lambda (x) x)
                  (+ s (car (list 1 2 3 4 5)))))
               (+ s (car (list 2 3 4 5)))))
            (+ s (car (list 3 4 5)))))
         (+ s (car (list 4 5)))))
      (+ s (car (list 5)))))
   0)



