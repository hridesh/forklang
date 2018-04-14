(define obj (ref 0))
(define olock (ref 0))
(define getobj (lambda ()
		(if (= (deref obj) 0)
			(let 
					((l (lock olock))
					 (r (set! obj 42))
					 (u (unlock olock)))
					obj
			)
			obj
		)
	)
)
(fork (getobj) (getobj))