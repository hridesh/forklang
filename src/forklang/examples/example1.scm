(define seq (lambda (f s) s))
(define example1 (lambda ()
    (let
       ((x (ref 0)))
       (seq 
           (fork
              (set! x (+ 1 (deref x)))
	          (set! x (+ 1 (deref x)))
           )
           (deref x)
       )
    )
))