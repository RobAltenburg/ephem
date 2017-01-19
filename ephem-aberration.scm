;;; ephem-aberration
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-aberration
        (equ-aberration ecl-aberration)

        (import chicken scheme foreign)
        (use ephem-common)
        (foreign-declare "#include <libnova/aberration.h>")

        ;;; }}}

        ;;; Aberration {{{1

        ;; returns equ type
        (define (equ-aberration equ-in jd)
          (let ((equ (make-equ)))
            ((foreign-lambda void "ln_get_equ_aber"
                             nonnull-c-pointer
                             double
                             nonnull-c-pointer)
             equ-in
             jd
             equ)
            equ))

        ;; returns ecl type
        (define (ecl-aberration ecl-in jd)
          (let ((ecl (make-ecl)))
            ((foreign-lambda void "ln_get_ecl_aber"
                             nonnull-c-pointer
                             double
                             nonnull-c-pointer)
             ecl-in
             jd
             ecl)
            ecl))


        ;; }}}

        )              


