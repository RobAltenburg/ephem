;;; ephem-neptune
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-neptune
        ( neptune-sdiam neptune-rst neptune-helio-coords neptune-equ-coords
                        neptune-earth-dist neptune-solar-dist neptune-magnitude 
                        neptune-disk neptune-phase neptune-rect-helio)

        (import chicken scheme foreign)
        (use ephem-common)
        (foreign-declare "#include <libnova/neptune.h>")
        ;;; }}}

        ;;; neptune {{{1
        (define neptune-sdiam 
          (foreign-lambda double "ln_get_neptune_sdiam" double))

        ;; returns rst type 
        (define (neptune-rst jd ecl-in)
          (let ((rst (make-rst)))
            ((foreign-lambda void "ln_get_neptune_rst" double nonnull-c-pointer nonnull-c-pointer)
             jd ecl-in rst)
            rst))

        ;; returns helio type 
        (define (neptune-helio-coords jd)
          (let ((helio (make-helio)))
            ((foreign-lambda void "ln_get_neptune_helio_coords" double nonnull-c-pointer)
             jd helio)
            helio))

        ;; returns equ type 
        (define (neptune-equ-coords jd)
          (let ((equ (make-equ)))
            ((foreign-lambda void "ln_get_neptune_equ_coords" double nonnull-c-pointer)
             jd equ)
            equ))

        (define neptune-earth-dist 
          (foreign-lambda double "ln_get_neptune_earth_dist" double))
        (define neptune-solar-dist
          (foreign-lambda double "ln_get_neptune_solar_dist" double))
        (define neptune-magnitude 
          (foreign-lambda double "ln_get_neptune_magnitude" double))
        (define neptune-disk 
          (foreign-lambda double "ln_get_neptune_disk" double))
        (define neptune-phase 
          (foreign-lambda double "ln_get_neptune_phase" double))

        ;; returns helio type 
        (define (neptune-rect-helio jd)
          (let ((rect (make-rect)))
            ((foreign-lambda void "ln_get_neptune_rect_helio" double nonnull-c-pointer)
             jd rect)
            rect))
        ;;; }}}

        )              


