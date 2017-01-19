;;; ephem-proper-motion
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-proper-motion
        (equ-pm)

        (import chicken scheme foreign)
        (use ephem-common)
        (foreign-declare "#include <libnova/proper_motion.h>")
        ;;; }}}

        ;;; Proper Motion {{{1

        ;; returns equ type 
        (define (equ-pm equm equp jd)
          (let ((equ (make-equ)))
            ((foreign-lambda void "ln_get_equ_pm" 
                             nonnull-c-pointer
                             nonnull-c-pointer
                             double
                             nonnull-c-pointer)
             equm equp jd equ)
            equ))

        ;;; }}}

        )              


