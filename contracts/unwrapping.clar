
;; unwrapping fundamentals

(define-data-var list-day-21 (list 5 uint) (list u1 u2 u3 u4))

(define-read-only (find-length)
    (len (var-get list-day-21))
)

(define-read-only (show-list)
    (var-get list-day-21)
)

(define-public (add-to-list (new-num uint))
;;  errors out because we could append an element to an already max length list  
;;  (ok (var-set list-day-21 (append (var-get list-day-21) new-num)))

    (ok (var-set list-day-21 
        (unwrap! 
            (as-max-len? (append (var-get list-day-21) new-num) u5) 
            (err u0)
        ))
    )
)


