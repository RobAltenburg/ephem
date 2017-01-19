;;; ephem-uranus
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-uranus
        ( uranus-sdiam uranus-rst uranus-helio-coords uranus-equ-coords
                        uranus-earth-dist uranus-solar-dist uranus-magnitude 
                        uranus-disk uranus-phase uranus-rect-helio)

        (import chicken scheme foreign)
        (use ephem-common)
        (foreign-declare "#include <libnova/uranus.h>")
        ;;; }}}

        ;;; uranus {{{1
        (define uranus-sdiam 
          (foreign-lambda double "ln_get_uranus_sdiam" double))

        ;; returns rst type 
        (define (uranus-rst jd ecl-in)
          (let ((rst (make-rst)))
            ((foreign-lambda void "ln_get_uranus_rst" double nonnull-c-pointer nonnull-c-pointer)
             jd ecl-in rst)
            rst))

        ;; returns helio type 
        (define (uranus-helio-coords jd)
          (let ((helio (make-helio)))
            ((foreign-lambda void "ln_get_uranus_helio_coords" double nonnull-c-pointer)
             jd helio)
            helio))

        ;; returns equ type 
        (define (uranus-equ-coords jd)
          (let ((equ (make-equ)))
            ((foreign-lambda void "ln_get_uranus_equ_coords" double nonnull-c-pointer)
             jd equ)
            equ))

        (define uranus-earth-dist 
          (foreign-lambda double "ln_get_uranus_earth_dist" double))
        (define uranus-solar-dist
          (foreign-lambda double "ln_get_uranus_solar_dist" double))
        (define uranus-magnitude 
          (foreign-lambda double "ln_get_uranus_magnitude" double))
        (define uranus-disk 
          (foreign-lambda double "ln_get_uranus_disk" double))
        (define uranus-phase 
          (foreign-lambda double "ln_get_uranus_phase" double))

        ;; returns helio type 
        (define (uranus-rect-helio jd)
          (let ((rect (make-rect)))
            ((foreign-lambda void "ln_get_uranus_rect_helio" double nonnull-c-pointer)
             jd rect)
            rect))
        ;;; }}}

        )              


