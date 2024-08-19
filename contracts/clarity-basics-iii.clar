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