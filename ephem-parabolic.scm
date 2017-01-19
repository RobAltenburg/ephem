;;; ephem-parabolic
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-parabolic
        ( solve-barker par-true-anomaly par-radius-vector
                       par-geo-rect-posn par-helio-rect-posn par-body-equ-coords
                       par-body-earth-dist  par-body-solar-dist par-body-phase-angle 
                       par-body-elong par-body-rst 
                       par-body-rst-horizon par-body-next-rst-horizon 
                       par-body-next-rst-horizon-future)

        (import chicken scheme foreign)
        (use ephem-common)
        (foreign-declare "#include <libnova/parabolic_motion.h>")
        ;;; }}}

        ;;; Parabolic {{{1
        (define solve-barker (foreign-lambda double "ln_solve_barker" double double))
        (define par-true-anomaly (foreign-lambda double "ln_get_par_true_anomaly" double double))
        (define par-radius-vector (foreign-lambda double "ln_get_par_radius_vector" double double))

        ;; returns rect type 
        (define (par-geo-rect-posn par-in jd)
          (let ((rect (make-rect)))
            ((foreign-lambda void "ln_get_par_geo_rect_posn"
                             nonnull-c-pointer
                             double
                             nonnull-c-pointer)
             par-in
             jd
             rect)
            rect))

        ;; returns rect type 
        (define (par-helio-rect-posn par-in jd)
          (let ((rect (make-rect)))
            ((foreign-lambda void "ln_get_par_helio_rect_posn"
                             nonnull-c-pointer
                             double 
                             nonnull-c-pointer)
             par-in
             jd
             rect)
            rect))

        ;; returns equ type 
        (define (par-body-equ-coords jd par-in)
          (let ((equ (make-equ)))
            ((foreign-lambda void "ln_get_par_body_equ_coords"
                             double
                             nonnull-c-pointer
                             nonnull-c-pointer)
             jd
             par-in
             equ)
            equ))

        ;takes jd par-in
        (define par-body-earth-dist
          (foreign-lambda double "ln_get_par_body_earth_dist" double nonnull-c-pointer))

        ;takes jd par-in
        (define par-body-solar-dist
          (foreign-lambda double "ln_get_par_body_solar_dist" double nonnull-c-pointer))

        ;takes jd par-in
        (define par-body-phase-angle
          (foreign-lambda double "ln_get_par_body_phase_angle" double nonnull-c-pointer))

        ;takes jd par-in
        (define par-body-elong
          (foreign-lambda double "ln_get_par_body_elong" double nonnull-c-pointer))

        ;; returns rst type 
        (define (par-body-rst jd ecl-in par-in)
          (let ((rst (make-rst)))
            ((foreign-lambda void "ln_get_par_body_rst"
                             double
                             nonnull-c-pointer
                             nonnull-c-pointer
                             nonnull-c-pointer)
             jd ecl-in par-in rst)
            rst))

        ;; returns rst type 
        (define (par-body-rst-horizon jd ecl-in par-in horizon)
          (let ((rst (make-rst)))
            ((foreign-lambda void "ln_get_par_body_rst_horizon"
                             double
                             nonnull-c-pointer
                             nonnull-c-pointer
                             double
                             nonnull-c-pointer)
             jd ecl-in par-in horizon rst)
            rst))

        ;; returns rst type 
        (define (par-body-next-rst-horizon jd ecl-in par-in horizon)
          (let ((rst (make-rst)))
            ((foreign-lambda void "ln_get_par_body_next_rst_horizon"
                             double
                             nonnull-c-pointer
                             nonnull-c-pointer
                             double
                             nonnull-c-pointer)
             jd ecl-in par-in horizon rst)
            rst))

        ;; returns rst type 
        (define (par-body-next-rst-horizon-future jd ecl-in par-in horizon daylimit)
          (let ((rst (make-rst)))
            ((foreign-lambda void "ln_get_par_body_next_rst_horizon_future"
                             double
                             nonnull-c-pointer
                             nonnull-c-pointer
                             double
                             double
                             nonnull-c-pointer)
             jd ecl-in par-in horizon daylimit rst)
            rst))
        ;;; }}}

        )              


