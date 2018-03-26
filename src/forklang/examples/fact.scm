(define factorial
   (lambda (n) 
   	(if (= n 0) 1
   		(* n (factorial (- n 1)))
   	)
   )
)

(define seq (lambda (f s) s))

(let ((x (ref 2))(y (ref 3))) 
       (fork
       	   (factorial (+ (deref x) (deref y) )) 
       	   (factorial (* (deref x) (deref y) )) 
       )
)
