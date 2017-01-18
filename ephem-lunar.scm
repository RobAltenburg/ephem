;;; ephem-lunar
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-lunar
        ( lunar-phase lunar-disk lunar-sdiam lunar-earth-dist lunar-bright-limb 
                      lunar-long-asc-node lunar-long-perigee lunar-equ-coords lunar-rst
                      lunar-geo-posn lunar-equ-coords-prec lunar-ecl-coords)

        (import chicken scheme foreign)
        (use ephem-common)
        (foreign-declare "#include <libnova/lunar.h>")
   
        ;;; }}}

        ;;; Lunar {{{1
        (define lunar-sdiam 
          (foreign-lambda double "ln_get_lunar_sdiam" double))

        ;; returns rst type
        (define (lunar-rst jd ecl-in)
          (let ((rst (make-rst)))
            ((foreign-lambda void "ln_get_lunar_rst" double nonnull-c-pointer nonnull-c-pointer)
             jd ecl-in rst)
            rst))

        ;; returns rect type
        (define (lunar-geo-posn jd precision)
          (let ((rect (make-rect)))
            ((foreign-lambda void "ln_get_lunar_geo_posn" double nonnull-c-pointer double)
             jd rect precision)
            rect))

        ;; returns equ type
        (define (lunar-equ-coords-prec jd precision)
          (let ((equ (make-equ)))
            ((foreign-lambda void "ln_get_lunar_equ_coords_prec" double nonnull-c-pointer double)
             jd equ precision)
            equ))

        ;; returns equ type
        (define (lunar-equ-coords jd)
          (let ((equ (make-equ)))
            ((foreign-lambda void "ln_get_lunar_equ_coords" double nonnull-c-pointer)
             jd equ)
            equ))

        ;; returns ecl type
        (define (lunar-ecl-coords jd precision)
          (let ((ecl (make-ecl)))
            ((foreign-lambda void "ln_get_lunar_ecl_coords" double nonnull-c-pointer double)
             jd ecl precision)
            ecl))

        (define lunar-phase 
          (foreign-lambda double "ln_get_lunar_phase" double))
        (define lunar-disk 
          (foreign-lambda double "ln_get_lunar_disk" double))
        (define lunar-earth-dist 
          (foreign-lambda double "ln_get_lunar_earth_dist" double))
        (define lunar-bright-limb 
          (foreign-lambda double "ln_get_lunar_bright_limb" double))
        (define lunar-long-asc-node 
          (foreign-lambda double "ln_get_lunar_long_asc_node" double))
        (define lunar-long-perigee 
          (foreign-lambda double "ln_get_lunar_long_perigee" double))
        ;;; }}}

        )              


