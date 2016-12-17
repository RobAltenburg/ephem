;;; ephem-constellation
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-constellation
        (get-constellation) 

    (import chicken scheme foreign)
    (use ephem-common)

;;; }}}

;;; Headers {{{1 
    (foreign-declare "#include <libnova/ln_types.h>")
    (foreign-declare "#include <libnova/constellation.h>")
;;; }}} 

;;; Constellation {{{1

    ;; returns 
    (define (get-constellation equ-in)
        ((foreign-lambda* nonnull-c-string ((double ra) (double dec))
                       "struct ln_equ_posn in = {.ra = ra, .dec = dec};
                       C_return(ln_get_constellation(&in));")
                       (equ-ra equ-in)
                       (equ-dec equ-in)))
                       

;; }}}

)              


