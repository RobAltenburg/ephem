;;; ephem-utility
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-utility
        (get-version vsop87->fk5
                     rad->deg deg->rad hms->deg deg->hms hms->rad)

        (import chicken scheme foreign)
        (use ephem-common)
        (foreign-declare "#include <libnova/vsop87.h>
                         #include <libnova/utility.h>")

        ;;; }}}

        ;;; Utility {{{1
        (define (get-version) 
          (foreign-lambda nonnull-c-string "ln_get_version")) 
        ;;; }}}

        ;;; VSOP87 Theory {{{1
        (define (vsop87->fk5 helio-in jd)
          ((foreign-lambda void "ln_vsop87_to_fk5" nonnull-c-pointer double)
           helio-in jd)
          helio-in)
        ;;; }}}

        ;;; General Conversion {{{1
        (define (rad->deg rad) 
          (foreign-lambda double "ln_rad_to_deg" double)) 

        (define (deg->rad deg) 
          (foreign-lambda double "ln_deg_to_rad" double)) 

        (define (hms->deg hours minutes seconds) 
        ((foreign-lambda double "ln_hms_to_deg" nonnull-c-pointer)
         (make-hms hours minutes seconds)))

        (define (deg->hms degrees) 
          (let ((hms (make-hms)))
            ((foreign-lambda void "ln_deg_to_hms" double nonnull-c-pointer)
             degrees
             hms)
            hms))

        (define (hms->rad hours minutes seconds) 
        ((foreign-lambda double "ln_hms_to_rad" nonnull-c-pointer)
         (make-hms hours minutes seconds)))
        

;;; }}}
)              


