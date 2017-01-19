;;; ephem-precession
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-precession
        (equ-prec equ-prec2 ecl-prec)

    (import chicken scheme foreign)
    (use ephem-common)
    (foreign-declare "#include <libnova/precession.h>")

;;; }}}

;;; precession {{{1
    
;; returns equ type 
(define (equ-prec equ jd)
  (let ((equ-out (make-equ)))
    ((foreign-lambda void "ln_get_equ_prec" nonnull-c-pointer double nonnull-c-pointer)
     equ
     jd
     equ-out)
    equ-out))

;; returns equ type 
(define (equ-prec2 equ jd-from jd-to)
  (let ((equ-out (make-equ)))
    ((foreign-lambda void "ln_get_equ_prec2" nonnull-c-pointer double double nonnull-c-pointer)
     equ
     jd-from
     jd-to
     equ-out)
    equ-out))

;; returns ecl type 
(define (ecl-prec ecl jd)
  (let ((ecl-out (make-ecl)))
    ((foreign-lambda void "ln_get_ecl_prec" nonnull-c-pointer double nonnull-c-pointer)
     ecl
     jd
     ecl-out)
    ecl-out))

    ;;; }}}

)              


