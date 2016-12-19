;;; ephem-heliocentric
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-heliocentric
        (heliocentric-time-diff)

    (import chicken scheme foreign)
    (use ephem-common)
    (include "ephem-include.scm")

;;; }}}

;;; Heliocentric {{{1

    (define (heliocentric-time-diff jd equ-in)
        ((foreign-lambda* double ((double jd) (double ra) (double dec))
                       "struct ln_equ_posn in_object = {.ra = ra, .dec = dec};
                       C_return(ln_get_heliocentric_time_diff(jd, &in_object));")
                       jd
                       (equ-ra equ-in) (equ-dec equ-in)))

;;; }}}

)



