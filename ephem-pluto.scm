;;; ephem-pluto
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-pluto
        ( pluto-sdiam pluto-rst pluto-helio-coords pluto-equ-coords
                        pluto-earth-dist pluto-solar-dist pluto-magnitude 
                        pluto-disk pluto-phase pluto-rect-helio)

        (import chicken scheme foreign)
        (use ephem-common)
        (foreign-declare "#include <libnova/pluto.h>")
        ;;; }}}

        ;;; pluto {{{1
        (define pluto-sdiam 
          (foreign-lambda double "ln_get_pluto_sdiam" double))

        ;; returns rst type 
        (define (pluto-rst jd ecl-in)
          (let ((rst (make-rst)))
            ((foreign-lambda void "ln_get_pluto_rst" double nonnull-c-pointer nonnull-c-pointer)
             jd ecl-in rst)
            rst))

        ;; returns helio type 
        (define (pluto-helio-coords jd)
          (let ((helio (make-helio)))
            ((foreign-lambda void "ln_get_pluto_helio_coords" double nonnull-c-pointer)
             jd helio)
            helio))

        ;; returns equ type 
        (define (pluto-equ-coords jd)
          (let ((equ (make-equ)))
            ((foreign-lambda void "ln_get_pluto_equ_coords" double nonnull-c-pointer)
             jd equ)
            equ))

        (define pluto-earth-dist 
          (foreign-lambda double "ln_get_pluto_earth_dist" double))
        (define pluto-solar-dist
          (foreign-lambda double "ln_get_pluto_solar_dist" double))
        (define pluto-magnitude 
          (foreign-lambda double "ln_get_pluto_magnitude" double))
        (define pluto-disk 
          (foreign-lambda double "ln_get_pluto_disk" double))
        (define pluto-phase 
          (foreign-lambda double "ln_get_pluto_phase" double))

        ;; returns helio type 
        (define (pluto-rect-helio jd)
          (let ((rect (make-rect)))
            ((foreign-lambda void "ln_get_pluto_rect_helio" double nonnull-c-pointer)
             jd rect)
            rect))
        ;;; }}}

        )              


