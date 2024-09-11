
(define-read-only (test)
    (ok true)
)

(define-data-var balance uint u3)

(define-data-var total-fees uint u3)

;; Public function
(define-public (increment-balance (amount uint))
  (begin
    (asserts! (> amount u0) (err u1))
    (ok (+ (var-get balance) amount))))

;; Private function
(define-private (process-deposit (deposit-amount uint))
  (let ((fee (/ deposit-amount u10)))
    (begin
      (try! (increment-balance (- deposit-amount fee)))
      (var-set total-fees (+ (var-get total-fees) fee))
      (ok true))))

;; Public function that uses the private function
(define-public (deposit (amount uint))
  (begin
    (asserts! (>= amount u100) (err u2))
    (process-deposit amount)))

(define-data-var name (string-ascii 48) "Bob")

(define-data-var txLog (list 100 uint) (list))

(define-public (add-tx (amount uint))
    (begin
        (var-set txLog (unwrap! (as-max-len? (append (var-get txLog) amount) u5) (err u1)))
        (ok true)
    )
)

(define-read-only (get-last-tx)
  (let
    (
      (logLength (len (var-get txLog)))
    )
    (if (> logLength u0)
      (ok (element-at? (var-get txLog) (- logLength u1)))
      (err u0)
    )
  )
)

(define-private (clear-log)
    (begin
        (var-set txLog (list))
        (print "Log cleared")
    )
)

(define-public (get-tx-count)
  (ok (len (var-get txLog)))
)

(define-constant CONTRACT_OWNER tx-sender)

(define-private (check-owner)
  (begin
    (asserts! (is-eq tx-sender CONTRACT_OWNER) (err u1))
    (ok true)
  )
)

(define-public (withdraw (amount uint))
    (if (is-ok (check-owner))
        (as-contract (stx-transfer? amount tx-sender CONTRACT_OWNER))
        (err u2)
    )
)

(define-public (transfer (to principal) (amount uint))
  (begin
    (asserts! (is-eq tx-sender CONTRACT_OWNER) (err u401))
    (stx-transfer? amount tx-sender to)
  )
)
