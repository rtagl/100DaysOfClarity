
;; conditionals

;; asserts! 
;; use when you want the fail scenario in an error and the transaction itself to be cancelled

(define-constant ERR_TOO_LARGE (err u1))
(define-constant ERR_TOO_SMALL (err u2))
(define-constant ERR_NOT_AUTHORIZED (err u3))
(define-constant admin tx-sender)

(define-constant tup {age: 30, info: {name: 30, addr: "hello"}})

(define-read-only (show-asserts (num uint))
    (ok (asserts! (> num u2) (err u1)))
)

(define-read-only (check-admin)
    (ok (asserts! (is-eq tx-sender admin) ERR_NOT_AUTHORIZED))
)

(define-read-only (read-list)
    (len (list 1 2 3 4 5))
)