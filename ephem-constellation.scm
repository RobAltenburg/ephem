;;; ephem-constellation
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-constellation
        (constellation) 

    (import chicken scheme foreign)
    (use ephem-common)
    (include "ephem-include.scm")

;;; }}}

;;; Constellation {{{1

    ;; returns 
    (define (constellation equ-in)
        ((foreign-lambda* nonnull-c-string ((double ra) (double dec))
                       "struct ln_equ_posn in = {.ra = ra, .dec = dec};
                       C_return(ln_get_constellation(&in));")
                       (equ-ra equ-in)
                       (equ-dec equ-in)))
                       

;; }}}

)              


