;;; ephem-common
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-common
        (range-hours range-degrees range-degrees180
         make-rst rst-rise rst-set rst-transit rst-circumpolar
         make-rst rst-rise rst-set rst-transit
         make-rect rect-x rect-y rect-z
         make-helio helio-l helio-b helio-r
         make-ecl ecl-lng ecl-lat
         make-equ equ-ra equ-dec
         make-hrz hrz-az hrz-alt
         make-gal gal-l gal-b
         make-ell ell-a ell-e ell-i ell-w ell-omega ell-n ell-jd
         make-par par-q par-i par-w par-omega par-jd)

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
        ((> degrees 360) (range-degrees (- degrees 360)))
        (else degrees)))

    (define (range-degrees180 degrees)
      (cond 
        ((< degrees -180) (range-degrees180 (+ 360 degrees)))
        ((> degrees 180) (range-degrees180 (- degrees 360)))
        (else degrees)))

    (define-record-type rst
        (_make-rst rise set transit circumpolar)
        rst?
        (rise rst-rise (setter rst-rise)) 
        (set rst-set (setter rst-set)) 
        (transit rst-transit (setter rst-transit)) 
        (circumpolar rst-circumpolar (setter rst-circumpolar)))

    (define (make-rst rise set transit #!optional (circumpolar #f))
        (_make-rst rise set transit circumpolar))

    (define-record-type rect
        (make-rect x y z)
        rect?
        (x rect-x (setter rect-x)) 
        (y rect-y (setter rect-y)) 
        (z rect-z (setter rect-z))) 

    (define-record-type helio
        (make-helio l b r)
        helio?
        (l helio-l (setter helio-l)) 
        (b helio-b (setter helio-b)) 
        (r helio-r (setter helio-r))) 

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

    (define-record-type ell
        (make-ell a e i w omega n jd)
        ell?
        (a ell-a (setter ell-a))
        (e ell-e (setter ell-e))
        (i ell-i (setter ell-i))
        (w ell-w (setter ell-w))
        (omega ell-omega (setter ell-omega))
        (n ell-n (setter ell-n))
        (jd ell-jd (setter ell-jd)))

    (define-record-type par 
        (make-par q i w omega jd)
        par?
        (q par-q (setter par-q))
        (i par-i (setter par-i))
        (w par-w (setter par-w))
        (omega par-omega (setter par-omega))
        (jd par-jd (setter par-jd)))

;;; }}}


)              


