;;; ephem-venus
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-venus
        ( venus-sdiam venus-rst venus-helio-coords venus-equ-coords
                        venus-earth-dist venus-solar-dist venus-magnitude 
                        venus-disk venus-phase venus-rect-helio)

        (import chicken scheme foreign)
        (use ephem-common)
        (foreign-declare "#include <libnova/venus.h>")
        ;;; }}}

        ;;; venus {{{1
        (define venus-sdiam 
          (foreign-lambda double "ln_get_venus_sdiam" double))

        ;; returns rst type 
        (define (venus-rst jd ecl-in)
          (let ((rst (make-rst)))
            ((foreign-lambda void "ln_get_venus_rst" double nonnull-c-pointer nonnull-c-pointer)
             jd ecl-in rst)
            rst))

        ;; returns helio type 
        (define (venus-helio-coords jd)
          (let ((helio (make-helio)))
            ((foreign-lambda void "ln_get_venus_helio_coords" double nonnull-c-pointer)
             jd helio)
            helio))

        ;; returns equ type 
        (define (venus-equ-coords jd)
          (let ((equ (make-equ)))
            ((foreign-lambda void "ln_get_venus_equ_coords" double nonnull-c-pointer)
             jd equ)
            equ))

        (define venus-earth-dist 
          (foreign-lambda double "ln_get_venus_earth_dist" double))
        (define venus-solar-dist
          (foreign-lambda double "ln_get_venus_solar_dist" double))
        (define venus-magnitude 
          (foreign-lambda double "ln_get_venus_magnitude" double))
        (define venus-disk 
          (foreign-lambda double "ln_get_venus_disk" double))
        (define venus-phase 
          (foreign-lambda double "ln_get_venus_phase" double))

        ;; returns helio type 
        (define (venus-rect-helio jd)
          (let ((rect (make-rect)))
            ((foreign-lambda void "ln_get_venus_rect_helio" double nonnull-c-pointer)
             jd rect)
            rect))
        ;;; }}}

        )              


