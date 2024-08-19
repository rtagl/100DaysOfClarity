;; optionals & parameters

;; requires all 3 parameters in contract call
(define-read-only (params (num uint) (string (string-ascii 48)) (boolean bool))
    num
) 

;; still requires all params in contract call, can be none or the value wrapped in (some)
(define-read-only (optional-params (num (optional uint)) (string (optional (string-ascii 48))) (boolean (optional bool)))
    num
)

;; optionals pt. 2

(define-read-only (is-some-example (num (optional uint)))
    (is-some num)
)

(define-read-only (is-none-example (num (optional uint)))
    (is-none num)
)

(define-read-only (optional-params-and (num (optional uint)) (string (optional (string-ascii 48))) (boolean (optional bool)))
    (and
        (is-some num)
        (is-some string)
        (is-some boolean)
    )
)

(define-data-var name (string-ascii 48) "Riccardo")
(define-constant age u3)

(define-data-var odd-num uint u3)
;; public functions & responses
(define-read-only (response-example)
    (var-get odd-num)
)

(define-read-only (read-age)
    age
)

(define-public (update-name (value (string-ascii 48)))
    (ok (var-set name value))
)

(define-read-only (read-name)
    (var-get name)
)

;; tx-sender & is-eq
(define-read-only (show-tx-sender)
    tx-sender
)

(define-constant admin 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM)

(define-read-only (check-admin)
    (is-eq admin tx-sender)
)

;; begin

;; @desc - This function allows a user to provide a name, which, if different, changes a name variable and returns "hello new name"
;; @param - new-name: (string-ascii 48) that represents the new name

(define-data-var current-name (string-ascii 48) "Alice")

(define-public (set-and-say-hello (new-name (string-ascii 48))) 
    (begin
        ;; assert name is not empty
        (asserts! (not (is-eq new-name "")) (err u1))
        ;; assert name is not equal to current name
        (asserts! (not (is-eq (var-get current-name) new-name)) (err u2))
        ;; var-set new name
        (var-set current-name new-name)
        ;; say hello new name
        (ok (concat "hello " (var-get current-name)))
    )
)

(define-read-only (read-hello-name)
    (var-get current-name)
)

;; counter
(define-data-var counter uint u0)
(define-read-only (read-count)
    (var-get counter)
)

;; @desc - This function allows the user to increase the counter only by an even amount
;; @params - num: uint

(define-public (add-even (num uint))
    (begin
        (asserts! (is-eq (mod num u2) u0) (err u1))
        (ok (var-set counter (+ (var-get counter) num)))
    )
)
