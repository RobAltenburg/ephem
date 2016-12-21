;;; ephem-atmospheric-refraction
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-atmospheric-refraction
        (refraction-adj)

    (import chicken scheme foreign)
    (use ephem-common)
    (include "ephem-include.scm")

;;; }}}

;;; Atmospheric Refraction {{{1
    (define refraction-adj
        (foreign-lambda double "ln_get_refraction_adj" double double double))
;;; }}}


)              


