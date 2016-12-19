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
    (include "ephem-include.scm")

;;; }}}

;;; angular {{{1
    (define (angular-separation equ1 equ2)
      ((foreign-lambda* double ((double ra1) (double dec1) (double ra2) (double dec2))
                       "struct ln_equ_posn in_posn1 = {.ra = ra1, .dec = dec1};
                       struct ln_equ_posn in_posn2 = {.ra = ra2, .dec = dec2};
                       C_return(ln_get_angular_separation(&in_posn1, &in_posn2));")
                       (equ-ra equ1)
                       (equ-dec equ1)
                       (equ-ra equ2)
                       (equ-dec equ2)))
                       
    (define (rel-posn-angle equ1 equ2)
      ((foreign-lambda* double ((double ra1) (double dec1) (double ra2) (double dec2))
                       "struct ln_equ_posn in_posn1 = {.ra = ra1, .dec = dec1};
                       struct ln_equ_posn in_posn2 = {.ra = ra2, .dec = dec2};
                       C_return(ln_get_rel_posn_angle(&in_posn1, &in_posn2));")
                       (equ-ra equ1)
                       (equ-dec equ1)
                       (equ-ra equ2)
                       (equ-dec equ2)))
;;; }}}

)
