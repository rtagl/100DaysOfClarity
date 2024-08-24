
;; unwrapping fundamentals

(define-data-var list-day-21 (list 5 uint) (list u1 u2 u3 u4))

(define-read-only (find-length)
    (len (var-get list-day-21))
)

(define-read-only (show-list)
    (var-get list-day-21)
)

;; unwrapping functions 
;;;;;;;;;;;;;;;;;;;;;;;
;; unwrap! -> accepts optionals and response
;; unwrap-err! -> accepts only a response
;; unwrap-panic -> takes in optional and response 
;; unwrap-panic-err -> optional and response
;; try! -> optionals and response

;; unwrap! example
(define-public (unwrap-example (new-num uint))
;;  errors out because we could append an element to an already max length list  
;;  (ok (var-set list-day-21 (append (var-get list-day-21) new-num)))
    (ok (var-set list-day-21 
        (unwrap! 
            (as-max-len? (append (var-get list-day-21) new-num) u5) 
            (err "error max length list")
        ))
    )
)

;; unwrap-panic example
(define-public (unwrap-panic-example (new-num uint))
;;  errors out because we could append an element to an already max length list  
;;  (ok (var-set list-day-21 (append (var-get list-day-21) new-num)))
    (ok (var-set list-day-21 
        (unwrap-panic (as-max-len? (append (var-get list-day-21) new-num) u5)))
    )
)

;; unwrap-err! example
(define-public (unwrap-err-example (input (response uint uint)))
    (ok (unwrap-err! input (err u10)))
)

;; try! example
(define-public (try-example (input (response uint uint)))
    (ok (try! input))
)

(define-public (person-tuple-to-list (person (tuple (name (string-ascii 50)) (age uint))))
  (let
    (
      (person-name (get name person))
      (person-age-string (int-to-ascii (get age person)))
      (person-list (list person-name person-age-string))
    )
    (ok person-list)
  )
)

(define-data-var recentTodos (list 5 (string-ascii 50)) (list))
(define-constant ERR_MAX_LENGTH (err u1))

(define-public (add-todo (todo (string-ascii 50)))
    (ok 
        (var-set recentTodos
            (unwrap! (as-max-len? (append (var-get recentTodos) todo) u5) ERR_MAX_LENGTH))
    )
)




