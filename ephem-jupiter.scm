;;; ephem-jupiter
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-jupiter
        ( jupiter-equ-sdiam jupiter-pol-sdiam jupiter-rst jupiter-helio-coords jupiter-equ-coords
                            jupiter-earth-dist jupiter-solar-dist jupiter-magnitude 
                            jupiter-disk jupiter-phase jupiter-rect-helio)

        (import chicken scheme foreign)
        (use ephem-common)
        (foreign-declare "#include <libnova/jupiter.h>")

        ;;; }}}

        ;;; jupiter {{{1
        (define jupiter-equ-sdiam 
          (foreign-lambda double "ln_get_jupiter_equ_sdiam" double))

        (define jupiter-pol-sdiam 
          (foreign-lambda double "ln_get_jupiter_pol_sdiam" double))

        ;; returns rst type 
        (define (jupiter-rst jd ecl-in)
          (let ((rst (make-rst)))
            ((foreign-lambda void "ln_get_jupiter_rst" double nonnull-c-pointer nonnull-c-pointer)
             jd ecl-in rst)
            rst))

        ;; returns helio type 
        (define (jupiter-helio-coords jd)
          (let ((helio (make-helio)))
            ((foreign-lambda void "ln_get_jupiter_helio_coords" double nonnull-c-pointer)
             jd helio)
            helio))

        ;; returns equ type 
        (define (jupiter-equ-coords jd)
          (let ((equ (make-equ)))
            ((foreign-lambda void "ln_get_jupiter_equ_coords" double nonnull-c-pointer)
             jd equ)
            equ))

        (define jupiter-earth-dist 
          (foreign-lambda double "ln_get_jupiter_earth_dist" double))
        (define jupiter-solar-dist
          (foreign-lambda double "ln_get_jupiter_solar_dist" double))
        (define jupiter-magnitude 
          (foreign-lambda double "ln_get_jupiter_magnitude" double))
        (define jupiter-disk 
          (foreign-lambda double "ln_get_jupiter_disk" double))
        (define jupiter-phase 
          (foreign-lambda double "ln_get_jupiter_phase" double))

        ;; returns helio type 
        (define (jupiter-rect-helio jd)
          (let ((rect (make-rect)))
            ((foreign-lambda void "ln_get_jupiter_rect_helio" double nonnull-c-pointer)
             jd rect)
            rect))
        ;;; }}}

        )              


