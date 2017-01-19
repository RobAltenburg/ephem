;;; ephem-elliptic
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-elliptic
        (solve-kepler ell-mean-anomaly ell-true-anomaly ell-radius-vector
                      ell-smajor-diam ell-sminor-diam ell-mean-motion
                      ell-geo-rect-posn ell-helio-rect-posn ell-orbit-len
                      ell-orbit-vel ell-orbit-pvel ell-orbit-avel
                      ell-body-phase-angle ell-body-elong ell-body-solar-dist
                      ell-body-earth-dist ell-body-equ-coords ell-body-rst
                      ell-body-rst-horizon ell-body-next-rst-horizon 
                      ell-body-next-rst-horizon-future ell-last-perihelion)

        (import chicken scheme foreign)
        (use ephem-common)
        (foreign-declare "#include <libnova/elliptic_motion.h>")
        ;;; }}}

        ;;; elliptic {{{1
        (define solve-kepler (foreign-lambda double "ln_solve_kepler" double double))
        (define ell-mean-anomaly (foreign-lambda double "ln_get_ell_mean_anomaly" double double))
        (define ell-true-anomaly (foreign-lambda double "ln_get_ell_true_anomaly" double double))
        (define ell-radius-vector (foreign-lambda double "ln_get_ell_radius_vector" double double double))
        (define ell-smajor-diam (foreign-lambda double "ln_get_ell_smajor_diam" double double))
        (define ell-sminor-diam (foreign-lambda double "ln_get_ell_sminor_diam" double double))
        (define ell-mean-motion (foreign-lambda double "ln_get_ell_mean_motion" double))

        ;; returns rect type 
        (define (ell-geo-rect-posn ell-in jd)
          (let ((rect (make-rect)))
            ((foreign-lambda void "ln_get_ell_geo_rect_posn"
                             nonnull-c-pointer
                             double
                             nonnull-c-pointer)
             ell-in
             jd
             rect)
            rect))

        ;; returns rect type 
        (define (ell-helio-rect-posn ell-in jd)
          (let ((rect (make-rect)))
            ((foreign-lambda void "ln_get_ell_helio_rect_posn"
                             nonnull-c-pointer
                             double 
                             nonnull-c-pointer)
             ell-in
             jd
             rect)
            rect))

        ;takes ell-in
        (define ell-orbit-len
          (foreign-lambda double "ln_get_ell_orbit_len" nonnull-c-pointer))

        ;takes jd ell-in
        (define ell-orbit-vel
          (foreign-lambda double "ln_get_ell_orbit_vel" double nonnull-c-pointer))

        ;takes ell-in
        (define ell-orbit-pvel
          (foreign-lambda double "ln_get_ell_orbit_pvel" nonnull-c-pointer))

        ;takes ell-in
        (define ell-orbit-avel
          (foreign-lambda double "ln_get_ell_orbit_avel" nonnull-c-pointer))

        ;takes jd ell-in
        (define ell-body-phase-angle
          (foreign-lambda double "ln_get_ell_body_phase_angle" double nonnull-c-pointer))

        ;takes jd ell-in
        (define ell-body-elong
          (foreign-lambda double "ln_get_ell_body_elong" double nonnull-c-pointer))

        ;takes jd ell-in
        (define ell-body-solar-dist
          (foreign-lambda double "ln_get_ell_body_solar_dist" double nonnull-c-pointer))

        ;takes jd ell-in
        (define ell-body-earth-dist
          (foreign-lambda double "ln_get_ell_body_earth_dist" double nonnull-c-pointer))

        ;; returns equ type 
        (define (ell-body-equ-coords jd ell-in)
          (let ((equ (make-equ)))
            ((foreign-lambda void "ln_get_ell_body_equ_coords"
                             double
                             nonnull-c-pointer
                             nonnull-c-pointer)
             jd ell-in equ)
            equ))

        ;; returns rst type 
        (define (ell-body-rst jd ecl-in ell-in)
          (let ((rst (make-rst)))
            ((foreign-lambda void "ln_get_ell_body_rst"
                             double
                             nonnull-c-pointer
                             nonnull-c-pointer
                             nonnull-c-pointer)
             jd ecl-in ell-in rst)
            rst))

        ;; returns rst type 
        (define (ell-body-rst-horizon jd ecl-in ell-in horizon)
          (let ((rst (make-rst)))
            ((foreign-lambda void "ln_get_ell_body_rst_horizon"
                             double
                             nonnull-c-pointer
                             nonnull-c-pointer
                             double
                             nonnull-c-pointer)
             jd ecl-in ell-in horizon rst)
            rst))

        ;; returns rst type 
        (define (ell-body-next-rst-horizon jd ecl-in ell-in horizon)
          (let ((rst (make-rst)))
            ((foreign-lambda void "ln_get_ell_body_next_rst_horizon"
                             double
                             nonnull-c-pointer
                             nonnull-c-pointer
                             double
                             nonnull-c-pointer)
             jd ecl-in ell-in horizon rst)
            rst))

        ;; returns rst type 
        (define (ell-body-next-rst-horizon-future jd ecl-in ell-in horizon daylimit)
          (let ((rst (make-rst)))
            ((foreign-lambda void "ln_get_ell_body_next_rst_horizon_future"
                             double
                             nonnull-c-pointer
                             nonnull-c-pointer
                             double
                             double
                             nonnull-c-pointer)
             jd ecl-in ell-in horizon daylimit rst)
            rst))


        (define ell-last-perihelion (foreign-lambda double "ln_get_ell_last_perihelion" double double double))

        ;;; }}}

        )              


