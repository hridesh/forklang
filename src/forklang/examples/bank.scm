(define bankaccount
	 (lambda (balanceref) 
	 	(lambda (op) 
	 		(if op 
	 			balanceref 
	 			(deref balanceref)
	 		)
	 	)
	 )
)

(define account 
   	(lambda (x) 
         (bankaccount (ref x))
   	)
)

(define getbalance 
	(lambda (acc) 
		(acc #f)
	)
)

(define withdraw
	(lambda (acc amount) 
		(set! 
			(acc #t)
			(- (acc #f) amount) 
		)
	)
)

(define deposit
	(lambda (acc amount) 
		(set! 
			(acc #t)
			(+ (acc #f) amount) 
		)
	)
)

// Following two accounts help us test this program
(define A (account 200))
(define B (account 200))

(define seq2 (lambda (f1 f2) f2))
(define seq4 (lambda (f1 f2 f3 f4) f4))
(define banktest
	(lambda ()
		(seq2 
			(fork 
				(seq4 (withdraw A 99) (withdraw B 99) (deposit A 99) (deposit B 99))
				(seq4 (withdraw B 101) (withdraw A 101) (deposit B 101) (deposit A 101))
			)
			(list (getbalance A) (getbalance B))
		)
	)
)
   

