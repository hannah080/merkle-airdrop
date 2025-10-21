;; --------------------------------------------
;; Merkle Airdrop Smart Contract
;; --------------------------------------------



;; ------------------
;; Constants & Errors
;; ------------------

(define-constant ERR_ALREADY_CLAIMED u100)
(define-constant ERR_INVALID_PROOF u101)
(define-constant ERR_TRANSFER_FAILED u102)
(define-constant ERR_NOT_OWNER u103)
(define-constant ERR_AIRDROP_EXPIRED u104)



;; ------------------
;;  Admin Controls
;; ------------------

(define-data-var owner principal tx-sender)
(define-data-var merkle-root (buff 32) 0x0000000000000000000000000000000000000000000000000000000000000000)
(define-data-var deadline uint u1000) ;; airdrop ends at block 1000
(define-data-var start-height uint (var-get deadline)) ;; initialized at deployment
(define-data-var total-claimed uint u0)

;; ------------------
;; Claim Tracking
;; ------------------

(define-map claimed { account: principal } bool)

;; ------------------

    


    


(define-private (verify-proof (leaf (buff 32)) (proof (list 20 (buff 32))) (root (buff 32)))
    (is-eq root (fold check-proof proof leaf)))

(define-private (check-proof (proof-element (buff 32)) (current-hash (buff 32)))
    (sha256 (if (< current-hash proof-element)
                (concat current-hash proof-element)
                (concat proof-element current-hash))))

;; ------------------
;; Claim Function
;; ------------------

(define-public (claim (account principal) (amount uint) (proof (list 20 (buff 32))))
  (begin
    ;; 1. Ensure airdrop is still active
     (<= stacks-block-height (var-get deadline)) (err ERR_AIRDROP_EXPIRED)))

    ;; 3. Hash leaf
  

;; ------------------
;; Admin-Only Functions
;; ------------------

(define-private (is-owner (caller principal))
  (is-eq caller (var-get owner)))

(define-public (set-deadline (new-deadline uint))
  (begin
    (asserts! (is-owner tx-sender) (err ERR_NOT_OWNER))
    (var-set deadline new-deadline)
    (ok new-deadline)))

(define-public (set-merkle-root (new-root (buff 32)))
  (begin
    (asserts! (is-owner tx-sender) (err ERR_NOT_OWNER))
    (var-set merkle-root new-root)
    (ok new-root)))

(define-public (transfer-ownership (new-owner principal))
  (begin
    (asserts! (is-owner tx-sender) (err ERR_NOT_OWNER))
    (var-set owner new-owner)
    (ok true)))



;; ------------------
;; Read-Only Functions
;; ------------------

(define-read-only (get-merkle-root) (ok (var-get merkle-root)))
(define-read-only (get-deadline) (ok (var-get deadline)))
(define-read-only (get-total-claimed) (ok (var-get total-claimed)))

(define-read-only (has-claimed (user principal))
  (is-some (map-get? claimed { account: user })))

(define-read-only (get-owner) (ok (var-get owner)))
