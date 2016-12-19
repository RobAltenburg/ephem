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
    (include "ephem-include.scm")

;;; }}}

;;; Sidereal Time {{{1
    (define (gmst jd)
      (range-hours
        ((foreign-lambda double "ln_get_mean_sidereal_time" double) jd)))
    (define (gast jd)
      (range-hours
        ((foreign-lambda double "ln_get_apparent_sidereal_time" double) jd)))
    (define (lmst jd lng)
      (range-hours (+ (gmst jd) (* 24 (/ lng 360)))))
    (define (last jd lng)
      (range-hours (+ (gast jd) (* 24 (/ lng 360)))))
;;; }}}


)              


