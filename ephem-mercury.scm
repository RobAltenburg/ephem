;;; ephem-mercury
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-mercury
        ( mercury-sdiam mercury-rst mercury-helio-coords mercury-equ-coords
                        mercury-earth-dist mercury-solar-dist mercury-magnitude 
                        mercury-disk mercury-phase mercury-rect-helio)

        (import chicken scheme foreign)
        (use ephem-common)
        (foreign-declare "#include <libnova/mercury.h>")
        ;;; }}}

        ;;; mercury {{{1
        (define mercury-sdiam 
          (foreign-lambda double "ln_get_mercury_sdiam" double))

        ;; returns rst type 
        (define (mercury-rst jd ecl-in)
          (let ((rst (make-rst)))
            ((foreign-lambda void "ln_get_mercury_rst" double nonnull-c-pointer nonnull-c-pointer)
             jd ecl-in rst)
            rst))

        ;; returns helio type 
        (define (mercury-helio-coords jd)
          (let ((helio (make-helio)))
            ((foreign-lambda void "ln_get_mercury_helio_coords" double nonnull-c-pointer)
             jd helio)
            helio))

        ;; returns equ type 
        (define (mercury-equ-coords jd)
          (let ((equ (make-equ)))
            ((foreign-lambda void "ln_get_mercury_equ_coords" double nonnull-c-pointer)
             jd equ)
            equ))

        (define mercury-earth-dist 
          (foreign-lambda double "ln_get_mercury_earth_dist" double))
        (define mercury-solar-dist
          (foreign-lambda double "ln_get_mercury_solar_dist" double))
        (define mercury-magnitude 
          (foreign-lambda double "ln_get_mercury_magnitude" double))
        (define mercury-disk 
          (foreign-lambda double "ln_get_mercury_disk" double))
        (define mercury-phase 
          (foreign-lambda double "ln_get_mercury_phase" double))

        ;; returns helio type 
        (define (mercury-rect-helio jd)
          (let ((rect (make-rect)))
            ((foreign-lambda void "ln_get_mercury_rect_helio" double nonnull-c-pointer)
             jd rect)
            rect))
        ;;; }}}

        )              


