(define-constant ERR_NOT_AUTHORIZED (err u100))
(define-constant ERR_ALREADY_LOCKED (err u101))
(define-constant ERR_NOT_UNLOCKED (err u102))
(define-constant ERR_NO_VALUE (err u103))
(define-constant ERR_UNLOCK_IN_PAST (err u104))

(define-constant contract-owner tx-sender)

(define-data-var beneficiary (optional principal) none)
(define-data-var unlockHeight uint u0)
(define-data-var balance uint u0)

;; Public Functions

(define-public (lock (newBeneficiary principal) (unlockAt uint) (amount uint))
    (begin
        (asserts! (is-eq contract-caller contract-owner) ERR_NOT_AUTHORIZED)
        (asserts! (is-none (var-get beneficiary)) ERR_ALREADY_LOCKED)
        (asserts! (> unlockAt block-height) ERR_UNLOCK_IN_PAST)
        (asserts! (> amount u0) ERR_NO_VALUE)
        (try! (stx-transfer? amount tx-sender (as-contract tx-sender)))
        (var-set beneficiary (some newBeneficiary))
        (var-set unlockHeight unlockAt)
        (ok true)
    ) 
)

(define-public (claim)
      (begin
        (asserts! (is-eq (some contract-caller) (var-get beneficiary)) ERR_NOT_AUTHORIZED)
        (asserts! (>= block-height (var-get unlockHeight)) ERR_NOT_UNLOCKED)
        (as-contract (stx-transfer? (stx-get-balance tx-sender) tx-sender (unwrap-panic (var-get beneficiary))))
    )
)

(define-public (bestow (newBeneficiary principal))
    (begin
        (asserts! (is-eq (some contract-caller) (var-get beneficiary)) ERR_NOT_AUTHORIZED)
        (var-set beneficiary (some newBeneficiary))
        (ok true)
    )
)

;; Read-only Functions

(define-read-only (get-beneficiary)
  (ok (var-get beneficiary))
)

(define-read-only (get-unlock-height)
  (ok (var-get unlockHeight))
)

(define-read-only (get-balance)
  (ok (var-get balance))
)
