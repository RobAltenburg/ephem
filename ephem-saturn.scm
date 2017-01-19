;;; ephem-saturn
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-saturn
        ( saturn-equ-sdiam saturn-pol-sdiam saturn-rst saturn-helio-coords saturn-equ-coords
                            saturn-earth-dist saturn-solar-dist saturn-magnitude 
                            saturn-disk saturn-phase saturn-rect-helio)

        (import chicken scheme foreign)
        (use ephem-common)
        (foreign-declare "#include <libnova/saturn.h>")

        ;;; }}}

        ;;; saturn {{{1
        (define saturn-equ-sdiam 
          (foreign-lambda double "ln_get_saturn_equ_sdiam" double))

        (define saturn-pol-sdiam 
          (foreign-lambda double "ln_get_saturn_pol_sdiam" double))

        ;; returns rst type 
        (define (saturn-rst jd ecl-in)
          (let ((rst (make-rst)))
            ((foreign-lambda void "ln_get_saturn_rst" double nonnull-c-pointer nonnull-c-pointer)
             jd ecl-in rst)
            rst))

        ;; returns helio type 
        (define (saturn-helio-coords jd)
          (let ((helio (make-helio)))
            ((foreign-lambda void "ln_get_saturn_helio_coords" double nonnull-c-pointer)
             jd helio)
            helio))

        ;; returns equ type 
        (define (saturn-equ-coords jd)
          (let ((equ (make-equ)))
            ((foreign-lambda void "ln_get_saturn_equ_coords" double nonnull-c-pointer)
             jd equ)
            equ))

        (define saturn-earth-dist 
          (foreign-lambda double "ln_get_saturn_earth_dist" double))
        (define saturn-solar-dist
          (foreign-lambda double "ln_get_saturn_solar_dist" double))
        (define saturn-magnitude 
          (foreign-lambda double "ln_get_saturn_magnitude" double))
        (define saturn-disk 
          (foreign-lambda double "ln_get_saturn_disk" double))
        (define saturn-phase 
          (foreign-lambda double "ln_get_saturn_phase" double))

        ;; returns helio type 
        (define (saturn-rect-helio jd)
          (let ((rect (make-rect)))
            ((foreign-lambda void "ln_get_saturn_rect_helio" double nonnull-c-pointer)
             jd rect)
            rect))
        ;;; }}}

        )              


