;;; ephem-angular
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-angular
        (angular-separation rel-posn-angle)

    (import chicken scheme foreign)
    (use ephem-common)
    (foreign-declare "#include <libnova/angular_separation.h>")

;;; }}}

;;; angular {{{1
    ; takes equ equ 
    (define angular-separation
      (foreign-lambda double "ln_get_angular_separation" 
                      nonnull-c-pointer
                      nonnull-c-pointer))
    
    ; takes equ equ 
    (define rel-posn-angle 
      (foreign-lambda double "ln_get_rel_posn_angle" 
                      nonnull-c-pointer
                      nonnull-c-pointer))
                        
;;; }}}

)
