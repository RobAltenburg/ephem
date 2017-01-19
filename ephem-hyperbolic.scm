;;; ephem-hyperbolic
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-hyperbolic
        ( solve-hyp-barker hyp-true-anomaly hyp-radius-vector
                           hyp-geo-rect-posn hyp-helio-rect-posn hyp-body-equ-coords
                           hyp-body-earth-dist  hyp-body-solar-dist hyp-body-phase-angle 
                           hyp-body-elong hyp-body-rst 
                           hyp-body-rst-horizon hyp-body-next-rst-horizon 
                           hyp-body-next-rst-horizon-future)

        (import chicken scheme foreign)
        (use ephem-common)
        (foreign-declare "#include <libnova/hyperbolic_motion.h>")

        ;;; }}}

        ;;; hyperbolic {{{1
        (define solve-hyp-barker (foreign-lambda double "ln_solve_hyp_barker" double double double))
        (define hyp-true-anomaly (foreign-lambda double "ln_get_hyp_true_anomaly" double double double))
        (define hyp-radius-vector (foreign-lambda double "ln_get_hyp_radius_vector" double double double))


        ;; returns rect type 
        (define (hyp-geo-rect-posn hyp-in jd)
          (let ((rect (make-rect)))
            ((foreign-lambda void "ln_get_hyp_geo_rect_posn"
                             nonnull-c-pointer
                             double
                             nonnull-c-pointer)
             hyp-in
             jd
             rect)
            rect))

        ;; returns rect type 
        (define (hyp-helio-rect-posn hyp-in jd)
          (let ((rect (make-rect)))
            ((foreign-lambda void "ln_get_hyp_helio_rect_posn"
                             nonnull-c-pointer
                             double 
                             nonnull-c-pointer)
             hyp-in
             jd
             rect)
            rect))

        ;; returns equ type 
        (define (hyp-body-equ-coords jd hyp-in)
          (let ((equ (make-equ)))
            ((foreign-lambda void "ln_get_hyp_body_equ_coords"
                             double
                             nonnull-c-pointer
                             nonnull-c-pointer)
             jd
             hyp-in
             equ)
            equ))

        ;takes jd hyp-in
        (define hyp-body-earth-dist
          (foreign-lambda double "ln_get_hyp_body_earth_dist" double nonnull-c-pointer))

        ;takes jd hyp-in
        (define hyp-body-solar-dist
          (foreign-lambda double "ln_get_hyp_body_solar_dist" double nonnull-c-pointer))

        ;takes jd hyp-in
        (define hyp-body-phase-angle
          (foreign-lambda double "ln_get_hyp_body_phase_angle" double nonnull-c-pointer))

        ;takes jd hyp-in
        (define hyp-body-elong
          (foreign-lambda double "ln_get_hyp_body_elong" double nonnull-c-pointer))

        ;; returns rst type 
        (define (hyp-body-rst jd ecl-in hyp-in)
          (let ((rst (make-rst)))
            ((foreign-lambda void "ln_get_hyp_body_rst"
                             double
                             nonnull-c-pointer
                             nonnull-c-pointer
                             nonnull-c-pointer)
             jd ecl-in hyp-in rst)
            rst))

        ;; returns rst type 
        (define (hyp-body-rst-horizon jd ecl-in hyp-in horizon)
          (let ((rst (make-rst)))
            ((foreign-lambda void "ln_get_hyp_body_rst_horizon"
                             double
                             nonnull-c-pointer
                             nonnull-c-pointer
                             double
                             nonnull-c-pointer)
             jd ecl-in hyp-in horizon rst)
            rst))

        ;; returns rst type 
        (define (hyp-body-next-rst-horizon jd ecl-in hyp-in horizon)
          (let ((rst (make-rst)))
            ((foreign-lambda void "ln_get_hyp_body_next_rst_horizon"
                             double
                             nonnull-c-pointer
                             nonnull-c-pointer
                             double
                             nonnull-c-pointer)
             jd ecl-in hyp-in horizon rst)
            rst))

        ;; returns rst type 
        (define (hyp-body-next-rst-horizon-future jd ecl-in hyp-in horizon daylimit)
          (let ((rst (make-rst)))
            ((foreign-lambda void "ln_get_hyp_body_next_rst_horizon_future"
                             double
                             nonnull-c-pointer
                             nonnull-c-pointer
                             double
                             double
                             nonnull-c-pointer)
             jd ecl-in hyp-in horizon daylimit rst)
            rst))


        ;;; }}}

        )
