(define resource1 (ref 42))
(define resource2 (ref 342))

(define factorial
   (lambda (n) 
   	(if (= n 0) 1
   		(* n (factorial (- n 1)))
   	)
   )
)

(define lock12 
	(lambda (f arg)
		(let 
			((l1 (lock resource1)) 
			 (l2 (lock resource2)) 
			 (result (f arg))
			 (ul1 (unlock resource1))
			 (ul2 (unlock resource2)))
			result
		)
	)
)

(define lock21 
	(lambda (f arg)
		(let 
			((l1 (lock resource2)) 
			 (l2 (lock resource1)) 
			 (result (f arg)) 
			 (ul1 (unlock resource2))
			 (ul2 (unlock resource1)))
			result
		)
	)
)

(define lockit
	(lambda ()
		(fork 
			(lock12 factorial 2) 
			(lock21 factorial 3)
		)
	)
)



