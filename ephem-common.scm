;;; ephem-common
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-common
        (range-hours range-degrees
         make-rst rst-rise rst-set rst-transit rst-circumpolar
         make-rect rect-X rect-Y rect-Z
         make-helio helio-L helio-B helio-R
         make-ecl ecl-lng ecl-lat
         make-equ equ-ra equ-dec
         make-hrz hrz-az hrz-alt
         make-gal gal-l gal-b)

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

    (define-record-type rst
        (make-rst rise set transit circumpolar)
        rst?
        (rise rst-rise (setter rst-rise)) 
        (set rst-set (setter rst-set)) 
        (transit rst-transit (setter rst-transit)) 
        (transit rst-circumpolar (setter rst-circumpolar))) 

    (define-record-type rect
        (make-rect X Y Z)
        rect?
        (X rect-X (setter rect-X)) 
        (Y rect-Y (setter rect-Y)) 
        (Z rect-Z (setter rect-Z))) 

    (define-record-type helio
        (make-helio L B R)
        helio?
        (L helio-L (setter helio-L)) 
        (B helio-B (setter helio-B)) 
        (R helio-R (setter helio-R))) 

    (define-record-type ecl 
        (make-ecl lng lat)
        ecl?
        (lng ecl-lng (setter ecl-lng)) 
        (lat ecl-lat (setter ecl-lat))) 

    (define-record-type equ 
        (make-equ ra dec)
        equ?
        (ra equ-ra (setter equ-ra)) 
        (dec equ-dec (setter equ-dec))) 

    (define-record-type hrz 
        (make-hrz az alt)
        hrz?
        (az hrz-az (setter hrz-az)) 
        (alt hrz-alt (setter hrz-alt))) 

    (define-record-type gal 
        (make-gal l b)
        gal?
        (l gal-l (setter gal-l)) 
        (b gal-b (setter gal-b))) 

;;; }}}


)              


