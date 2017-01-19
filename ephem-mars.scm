;;; ephem-mars
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-mars
        ( mars-sdiam mars-rst mars-helio-coords mars-equ-coords
                        mars-earth-dist mars-solar-dist mars-magnitude 
                        mars-disk mars-phase mars-rect-helio)

        (import chicken scheme foreign)
        (use ephem-common)
        (foreign-declare "#include <libnova/mars.h>")
        ;;; }}}

        ;;; mars {{{1
        (define mars-sdiam 
          (foreign-lambda double "ln_get_mars_sdiam" double))

        ;; returns rst type 
        (define (mars-rst jd ecl-in)
          (let ((rst (make-rst)))
            ((foreign-lambda void "ln_get_mars_rst" double nonnull-c-pointer nonnull-c-pointer)
             jd ecl-in rst)
            rst))

        ;; returns helio type 
        (define (mars-helio-coords jd)
          (let ((helio (make-helio)))
            ((foreign-lambda void "ln_get_mars_helio_coords" double nonnull-c-pointer)
             jd helio)
            helio))

        ;; returns equ type 
        (define (mars-equ-coords jd)
          (let ((equ (make-equ)))
            ((foreign-lambda void "ln_get_mars_equ_coords" double nonnull-c-pointer)
             jd equ)
            equ))

        (define mars-earth-dist 
          (foreign-lambda double "ln_get_mars_earth_dist" double))
        (define mars-solar-dist
          (foreign-lambda double "ln_get_mars_solar_dist" double))
        (define mars-magnitude 
          (foreign-lambda double "ln_get_mars_magnitude" double))
        (define mars-disk 
          (foreign-lambda double "ln_get_mars_disk" double))
        (define mars-phase 
          (foreign-lambda double "ln_get_mars_phase" double))

        ;; returns helio type 
        (define (mars-rect-helio jd)
          (let ((rect (make-rect)))
            ((foreign-lambda void "ln_get_mars_rect_helio" double nonnull-c-pointer)
             jd rect)
            rect))
        ;;; }}}

        )              


