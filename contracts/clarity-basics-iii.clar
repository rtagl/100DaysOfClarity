(define-read-only (list-bool)
    (list true true false
    )
)

(define-data-var num-list (list 10 uint) (list u1 u2))
(define-data-var principal-list (list 3 principal) (list tx-sender 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM 'ST1SJ3DTE5DN7X54YDH5D64R3BCB6A2AG2ZQ8YPD5))

;; element at
(define-read-only (find-element (index uint))
    (element-at? (var-get principal-list) index)
)

;; index-of
(define-read-only (find-index (item principal))
    (index-of? (var-get principal-list) item)
)

;; default-to & get

(define-constant example-tuple {
    example-bool: true,
    example-num: none,
    example-string: none,
    example-principal: tx-sender
})

(define-read-only (read-example-tuple)
    (get example-num example-tuple)
)

(define-read-only (read-example-bool)
    (get example-bool example-tuple)
)

;; returns none
(define-read-only (read-example-num)
    (get example-num example-tuple)
)

;; returns default value
(define-read-only (read-example-num-dt)
    (default-to u10 (get example-num example-tuple))
)

;; ;; returns (some "example")
(define-read-only (read-example-string)
    (get example-string example-tuple)
)

(define-read-only (read-example-string-dt)
    (default-to "foo" (get example-string example-tuple))
)

;; Conditionals continued - Match & if