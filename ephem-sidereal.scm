;;; ephem-sidereal
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-sidereal
        (gmst gast lmst last)

    (import chicken scheme foreign)
    (use ephem-common)

;;; }}}

;;; Headers {{{1 
    (foreign-declare "#include <libnova/sidereal_time.h>")
    (foreign-declare "#include <libnova/ln_types.h>")
;;; }}} 

;;; Sidereal Time {{{1
    (define _gmst 
      (foreign-lambda double "ln_get_mean_sidereal_time" double))
    (define _gast 
      (foreign-lambda double "ln_get_apparent_sidereal_time" double))
    (define (gmst jd)
      (range-hours (_gmst jd)))
    (define (gast jd)
      (range-hours (_gast jd)))
    (define (lmst jd lng)
      (range-hours (+ (gmst jd) (* 24 (/ lng 360)))))
    (define (last jd lng)
      (range-hours (+ (gast jd) (* 24 (/ lng 360)))))
;;; }}}


)              


