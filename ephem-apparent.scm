;;; ephem-apparent
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-apparent
        (apparent-posn)

    (import chicken scheme foreign)
    (use ephem-common)
    (foreign-declare "#include <libnova/apparent_position.h>")

;;; }}}

;;; Apparent {{{1

    ;; returns equ type
    (define (apparent-posn equ-in proper-in jd)
      (let ((equ (make-equ)))
          ((foreign-lambda void "ln_get_apparent_posn"
                       nonnull-c-pointer
                       nonnull-c-pointer
                       double
                       nonnull-c-pointer) equ-in proper-in jd equ)
          equ))

                       
;; }}}

)              


