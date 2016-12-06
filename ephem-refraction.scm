;;; ephem-refraction
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-refraction
        (refraction-adj)

    (import chicken scheme foreign)

;;; }}}

;;; Headers {{{1 
    (foreign-declare "#include <libnova/refraction.h>")
    (foreign-declare "#include <libnova/ln_types.h>")
;;; }}} 

;;; Atmospheric Refraction {{{1
    ;; double LIBNOVA_EXPORT    ln_get_refraction_adj (double altitude, double atm_pres, double temp)
    (define refraction-adj 
      (foreign-lambda double "ln_get_refraction_adj" double double double))
;;; }}}


)              


