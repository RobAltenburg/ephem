;;; ephem-solar
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-solar 
        ( solar-rst-horizon solar-rst solar-geom-coords solar-equ-coords 
          solar-ecl-coords solar-geo-coords solar-sdiam)

    (import chicken scheme foreign)
    (use ephem-common)
    (foreign-declare "#include <libnova/solar.h>")
   
;;; }}}

;;; Solar {{{1
  ;; returns rst type
        (define (solar-rst-horizon jd ecl-in horizon)
          (let ((rst (make-rst)))
            ((foreign-lambda void "ln_get_solar_rst_horizon" double nonnull-c-pointer double nonnull-c-pointer)
             jd ecl-in horizon rst)
            rst))

  ;; returns rst type
        (define (solar-rst jd ecl-in)
          (let ((rst (make-rst)))
            ((foreign-lambda void "ln_get_solar_rst" double nonnull-c-pointer nonnull-c-pointer)
             jd ecl-in rst)
            rst))

  ;; returns helio type
        (define (solar-geom-coords jd)
          (let ((helio (make-helio)))
            ((foreign-lambda void "ln_get_solar_geom_coords" double nonnull-c-pointer)
             jd helio)
            helio))

  ;; returns equ type
        (define (solar-equ-coords jd)
          (let ((equ (make-equ)))
            ((foreign-lambda void "ln_get_solar_equ_coords" double nonnull-c-pointer)
             jd equ)
            equ))

  ;; returns ecl type
        (define (solar-ecl-coords jd)
          (let ((ecl (make-ecl)))
            ((foreign-lambda void "ln_get_solar_ecl_coords" double nonnull-c-pointer)
             jd ecl)
            ecl))

  ;; returns rect type
        (define (solar-geo-coords jd)
          (let ((rect (make-rect)))
            ((foreign-lambda void "ln_get_solar_geo_coords" double nonnull-c-pointer)
             jd rect)
            rect))

    (define solar-sdiam 
      (foreign-lambda double "ln_get_solar_sdiam" double))

    ;;; }}}



)              





