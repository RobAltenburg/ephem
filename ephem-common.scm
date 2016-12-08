;;; ephem-common
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-common
        (range-hours range-degrees)

    (import chicken scheme foreign)

;;; }}}

;;; Headers {{{1 
    (foreign-declare "#include <libnova/ln_types.h>")
;;; }}} 

;;; Common {{{1
    (define (range-hours hours)
      (cond 
        ((< hours 0) (range-hours (+ 24 hours)))
        ((> hours 24) (range-hours (- hours 24)))
        (else hours)))

    (define (range-degrees degrees)
      (cond 
        ((< degrees 0) (range-degrees (+ 360 degrees)))
        ((> degrees 24) (range-degrees (- degrees 360)))
        (else degrees)))
;;; }}}


)              


