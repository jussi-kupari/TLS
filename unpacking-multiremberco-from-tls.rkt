#lang racket
 #|

http://www.michaelharrison.ws/weblog/2007/08/unpacking-multiremberco-from-tls/



This is Michael Harrison's old blog. Recent posts are available.

Unpacking multirember&co from TLS

The purpose of The Little Schemer, its authors profess, is to teach you to think recursively, and to do so without presenting too much math or too many computer science concepts. The book is a ball to read. However, from the perspective of this reader, who is fairly new to functional programming and totally new to Scheme, the book gets almost asymptotically more difficult and complicated towards the end of chapter 8, when we hit the function multirember&co. Looking around on the web, I noticed quite a few people had also hit this speed bump and were scratching their heads about how to go on. I think I can offer some assistance. So, as threatened yesterday, I now unveil my initial contribution to the wild world of Lisp, my explication of multirember&co and the concept of currying. Here’s hoping I don’t embarrass myself too much.

The Little Schemer, (hereafter “TLS”) is the latest iteration of The Little LISPer, and is presented as a dialogue between teacher and student. If you take the roll of the student, and try to answer the teacher’s questions, especially those of the form “define this function whose behavior we’ve been describing,” you can really flex your neurons. Each chapter is a little more complicated than the previous, and within each chapter the questions get slightly harder as you go. It’s like walking up a steadily graded hill. Until you get to page 137 and they hit you with a long function definition, for a function you’ve never seen before, and they ask, “What does this do?”

Yikes!

Here is the code for the function. (Thank you, Geoffrey King, for transcribing it in your post.)

(define multirember&co
   (lambda (a lat col)
     (cond
       ((null? lat)
        (col '() '()))
       ((eq? (car lat) a)
        (multirember&co a
                        (cdr lat)
                        (lambda (newlat seen)
                          (col newlat
                               (cons (car lat) seen)))))
       (else
        (multirember&co a
                        (cdr lat)
                        (lambda (newlat seen)
                          (col (cons (car lat) newlat)
                               seen)))))))

The first clue to dealing with this function is its context. The previous pages of TLS deal with currying, in which you define a function like (lambda (x) (lambda(y) (eq? x y) )) — it takes one argument, parameter x, and then returns the inner function, which also takes one argument, parameter y. The value you pass as x acts to customize the inner function by binding the occurance of variable x in the inner function to the value you passed in. So chapter 8 is about the practice of wrapping functions in this way.

The chapter is also about passing functions as arguments. The first line of multirember&co, (lambda (a lat col) defines three parameters. The variables ‘a’ and ‘lat’ are by convention used for an atom and a list of atoms. But ‘col’ is a function–you have to pass multirember&co a function that it uses inside its own definition.

TLS admits that multirember&co is complicated. “That looks really complicated!” says the student. But it seeks to simplify the function by defining functions to stand in for a) the function that will be passed as ‘col’; b) the first inner function defined in the cond branch (eq? (car lat) a); and c) the inner function defined in the cond else branch. To try to make you feel better about being up to your eyelids in deep water, the TLS authors give their functions friendly names, like “a-friend” and “next-friend.” But I prefer names that tell me what roll the functions play, so here are my renamed functions:

a) the function that will be passed initially as ‘col’ (and will be executed last):
(define last-function
(lambda(x y) (length x)))

b) the function called when a matches (car lat):
(define when-match
(lambda (newlat seen) (col newlat (cons (car lat) seen)))

c) the function called when the cond else branch executes:
(define when-differ
(lambda (newlat seen) (col (cons (car lat) newlat) seen))

TLS walks you through an execution of multirember&co, and so will I. To further simplify things, and reduce the amount of typing I have to do, I’ll change the example in the book. Instead of a four-word lat with some longer words, let’s use (berries tuna fish) for our list, and we’ll keep tuna as our atom argument.

Here’s multirember&co, with the two inner functions replaced by the pre-defined helper functions:

(define multirember&co
   (lambda (a lat col)
     (cond
       ((null? lat)
        (col '() '()))
       ((eq? (car lat) a)
        (multirember&co a
                        (cdr lat)
                        (when-match)))
       (else
        (multirember&co a
                        (cdr lat)
                        (when-differ))))))

When the function is called the first time, a is tuna, lat is (berries tuna fish), and col is last-function. (car lat) is berries, which does NOT eq tuna, so the else branch executes: multirember&co is called with tuna as a, (tuna fish) as lat because we pass (cdr lat) and so we lose the berries atom at the front of the list, and when-differ as col.

But wait. Actually, we’re not just passing the when-differ function we defined above. Here is that definition:

(lambda (newlat seen) (col (cons (car lat) newlat) seen))

This definition contains a variable, lat, that has a value at the time multirember&co is called recursively: (berries tuna fish). So (car lat) is (quote berries). What we’ve got here is a version, or an instance, of when-differ that has a value bound to one of its variables.

This is like currying, this binding of values to the variable of a function and then using this altered function to do something. I think that currying, however, refers to wrapping functions so that only one variable at a time is given a value. What this apparent creation of a specific instance of the function when-differ DOES have in common with currying is this: both use closures to encapsulate the instance of the function with bound variables, or, to be precise, to make a copy of the function with its own scope that will persist so long as there are references to the closure. I didn’t realize this on my own, of course. I owe this insight to Richard P. Gabriel’s essay The Why of Y, which you can read in this Dr. Dobb’s article or download as a PDF.

There’s something else in when-differ that will bind to a value: col. The function passed, remember, is last-function. So we can (and should) substitute that in for col.

Let’s give a unique name to the instance (technically the closure) of the function when-differ that has these two values bound to it: when-differ-1. Let’s write it out, and set it aside for later use:

(define when-differ-1
(lambda (newlat seen) (last-function (cons (quote berries) newlat) seen))
)

Now, on to iteration two, which we can summarize like this:
(multirember&co (quote tuna) (tuna fish) when-differ-1)

OK, so this time, (eq? (car lat) a) yields true, and the other branch of the condexecutes: multirember&co is called with tuna as a, (fish) as lat, and when-match as col. Once again, thanks to currying, the definition of when-match contains expressions to which values are bound:(car lat), which becomes (quote tuna) , and col, which becomes when-differ-1. Remember, we just recurred by calling multirember&co with when-differ-1 as the function argument for the parameter col. So now let’s define the resulting instance of when-match as when-match-1:

(define when-match-1
(lambda (newlat seen) (when-differ-1 newlat (cons (quote tuna) seen)))
)

On on to iteration three–we’re nearly there–which we can summarize like this:
(multirember&co (quote tuna) (fish) when-match-1)

This time, tuna and fish don’t match, which means we’re going to recur with another version of when-differ, when-differ-2:

(define when-differ-2
(lambda (newlat seen) (when-match-1 (cons (quote fish) newlat) seen))
)

Finally, iteration four:
(multirember&co (quote tuna) () when-differ-2)

This time lat is an empty list, which means (null? lat) is true, and the terminating line (col (quote()) (quote())) is executed. Yay! We’re done!

Except…

The result of the completed execution (col (quote()) (quote())) has to be evaluated. Here’s where everything turns inside out, or rightside out if you like.

First of all, the value of col in the final iteration was when-differ-2. So we’ll start there.

(when-differ-2 (quote()) (quote()))

Now, look back up and get the definition of when-differ-2 and substitute it.
((lambda (newlat seen) (when-match-1 (cons (quote fish) newlat) seen)) (quote()) (quote()))

OK, so the parameters newlat and seen both get assigned the value of an empty list:
(when-match-1 (cons (quote fish) (quote())) (quote()))

We can simplify this by consing fish onto the empty list:
(when-match-1 (fish) (quote()))

We have a definition for when-match-1 too. Let’s substitute that in now.
((lambda (newlat seen) (when-differ-1 newlat (cons (quote tuna) seen))) (fish) (quote())) )

And again assign values, this time (fish) and () to newlat and seen:
(when-differ-1 (fish) (tuna))

We’re getting somewhere now. Do you see how at each step we’re consing a value onto either seen or newlat? seen has gotten the instance of tuna, which was the atom we passed to multirember&co at the start, whereas newlat has gotten the other atom, fish. Guess where berries is going to go when we get to it.

Now, let’s substitute our definition of when-differ-1:
((lambda (newlat seen) (last-function (cons (quote berries) newlat) seen)) (fish) (tuna))

Which becomes….
(last-function (berries fish) (tuna) )

And now we’re back where we started, with last-function.

( (lambda(x y) (length x)) (berries fish) (tuna) )

(length (berries fish) )

2

So that’s how multirember&co works. What does it accomplish? It seems to separate occurrences of the atom a in the list of atoms lat from the other atoms in lat, and then it executes last-function using the list of occurrences and the list of other atoms.

In an imperative language like C or Java, you would probably define two variables, one for each list, and then loop through the list of atoms, testing each element in the list for equality with a, and then pushing the element onto either of the two lists. Finally, you would call the final function with the two lists you built.

Consider the differences in this approach. Throughout the loop, you have several variables remaining in scope, which means you have an opportunity to munge one of them accidentally. Also, how modular is this hypothetical code? In C, you could pass the last-function function as an argument to a procedure that encapsulates the loop, but try it in Java. No sir, in Java you’d have to call a method to get the two lists (which would have to come back wrapped into one object, probably a String[] array) and then call last-function with returnval[0] and returnval[1]. Not terrible, but not elegant either.

That’s just scratching the surface, I’m sure. If the example were more complicated, other implications of the recursive approach might become clear, at least to smarter people than me. But there is one other thing to point out.

As TLS points out, the function you supply for use with the two lists is assigned to a parameter names col because “col” stands for “collector” by convention. What is this function collecting? The two lists, of course. But more than that each use of col, as it changes from when-differ to when-match, is persisting the values of the lists from one step to the next. And that’s important because as of page 136, there has been no mention in TLS of an assignment operator. So even if we wanted to define variables to reference while looping through the list, we could not. Not yet. After all, such code would produce what functional programmers refer to, with a sniff, as side effects.


|#