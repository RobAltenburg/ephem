;;; ephem-dynamical
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-dynamical
        (dynamical-time-diff jde)

    (import chicken scheme foreign)
    (use ephem-common)
    (include "ephem-include.scm")

;;; }}}

;;; Dynamical Time {{{1
    (define (dynamical-time-diff jd)
        (foreign-lambda double "ln_get_dynamical_time_diff" double) jd)
    (define (jde jd)
        (foreign-lambda double "ln_get_jde" double) jd)
;;; }}}


)              


