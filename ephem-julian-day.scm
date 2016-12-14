;;; ephem-julian-day
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-julian-day
        (get-date)

    (import chicken scheme foreign srfi-19)
    (use srfi-19)

;;; }}}

;;; Headers {{{1 
    (foreign-declare "#include <libnova/ln_types.h>")
    (foreign-declare "#include <libnova/julian_day.h>")
    (define-external (callback (scheme-object obj)) scheme-object obj)
;;; }}} 

;;; Julian Day {{{1
    ;; returns a srfi-19 date object 
    (define (get-date jd #!optional (tz 0))
      (julian-day->date jd tz))

)

