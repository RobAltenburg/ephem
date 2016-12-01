;;; ephem-sidereal
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-sidereal
        (gmst gast)

    (import chicken scheme foreign)

;;; }}}

;;; Headers {{{1 
    (foreign-declare "#include <libnova/sidereal_time.h>")
    (foreign-declare "#include <libnova/ln_types.h>")
;;; }}} 

;;; Sidereal Time {{{1
    (define gmst 
      (foreign-lambda double "ln_get_mean_sidereal_time" double))
    (define gast 
      (foreign-lambda double "ln_get_apparent_sidereal_time" double))
;;; }}}


)              


