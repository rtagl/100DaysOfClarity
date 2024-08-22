

;; begin vs let
(define-data-var counter uint u0)

(define-map counter-history uint {user: principal, count: uint})

(define-public (increase-count-begin (increase-by uint))
    (begin
        (asserts! (not (is-eq (some tx-sender) (get user (map-get? counter-history (var-get counter))))) (err u0))
        (map-set counter-history (var-get counter) {
            user: tx-sender,
            count: (+ (get count (unwrap! (map-get? counter-history (var-get counter)) (err u1))) increase-by)
        })
        (ok (var-set counter (+ (var-get counter) u1)))
    )
)

(define-public (increase-count-let (increase-by uint))
    (let
        (
            (current-counter (var-get counter))
            (current-counter-history (default-to {user: tx-sender, count: u0} (map-get? counter-history current-counter)))
            (previous-counter-user (get user current-counter-history))
            (previous-counter-count (get count current-counter-history))
        )
        (asserts! (not (is-eq tx-sender previous-counter-user)) (err u3))
        (map-set counter-history current-counter {
            user: tx-sender,
            count: (+ increase-by previous-counter-count)
        })
        (ok (var-set counter (+ current-counter u1)))
    )
)

(define-data-var count int 0)

;; (define-public (add-number (list expr-1 expr-2)))
;;     (let 
;;         (
;;             (current-count (var-get count))
;;         )
;;         (var-set count (+ current-count number))
;;         (ok (var-get count))
;;   )
;; )

(define-public (add-number-let (number int))
    (begin
        (var-set count (+ (var-get count) number))
        (ok (var-get count))
    )
)

(define-map UserData { userId: principal } { data: uint })

(map-set UserData { userId: 'STNHKEPYEPJ8ET55ZZ0M5A34J0R3N5FM2CMMMAZ6} {data: u3})


(define-read-only (get-user-data (user principal))
  (map-get? UserData { userId: user })
)


(define-public (calculate-average (numbers (list 10 uint)))
    (let
        (
            (length (len numbers))
            (total (fold + numbers u0))
        )
        (asserts! (not (is-eq length u0)) (err u1))
        (ok (/ total length))
    )
)


(define-public (say-hello)
    (ok "Hello")
)

(define-public (execute)
    (let 
        (
            (response (say-hello))
        )
        (if (is-ok response)
            response
            (err "Unexpected error")
        )
    )
)