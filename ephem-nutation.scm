;;; ephem-nutation
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-nutation
        (nutation)

        (import chicken scheme foreign)
        (use ephem-common)
        (foreign-declare "#include <libnova/nutation.h>")
        ;;; }}}

        ;;; nutation {{{1

        ;; returns nutation type
        (define (nutation jd)
          (let ((nutation (make-nutation)))
            ((foreign-lambda void "ln_get_nutation" double nonnull-c-pointer)
             jd
             nutation)
            nutation))
        ;; }}}

        )              


