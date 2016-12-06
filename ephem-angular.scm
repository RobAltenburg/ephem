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

;;; }}}

;;; Headers {{{1 
    (foreign-declare "#include <libnova/angular_separation.h>")
    (foreign-declare "#include <libnova/ln_types.h>")
;;; }}} 

;;; angular {{{1
    (define angular-separation
      (foreign-lambda* double ((double ra1) (double dec1) (double ra2) (double dec2))
                       "struct ln_equ_posn in_posn1 = {.ra = ra1, .dec = dec1};
                       struct ln_equ_posn in_posn2 = {.ra = ra2, .dec = dec2};
                       C_return(ln_get_angular_separation(&in_posn1, &in_posn2));"))
                       
    (define rel-posn-angle
      (foreign-lambda* double ((double ra1) (double dec1) (double ra2) (double dec2))
                       "struct ln_equ_posn in_posn1 = {.ra = ra1, .dec = dec1};
                       struct ln_equ_posn in_posn2 = {.ra = ra2, .dec = dec2};
                       C_return(ln_get_rel_posn_angle(&in_posn1, &in_posn2));"))
;;; }}}

)