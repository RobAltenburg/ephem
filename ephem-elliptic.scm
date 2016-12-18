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

;;; }}}

;;; Headers {{{1 
    (foreign-declare "#include <libnova/elliptic_motion.h>")
    (foreign-declare "#include <libnova/ln_types.h>")
    (define-external (callback (scheme-object obj)) scheme-object obj)

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
    (define (ell-geo-rect-posn ell-in jdin)
      (apply make-rect
        ((foreign-safe-lambda* scheme-object ((double a) (double e) (double i) (double w)
                                              (double omega) (double n) (double jde) (double jdin))
                       "C_word lst = C_SCHEME_END_OF_LIST, *al;
                       struct ln_ell_orbit in = {.a = a, .e = e, .i = i, .w = w,
                                               .omega = omega, .n = n, .JD = jde};
                       struct ln_rect_posn *out;
                       out = malloc(sizeof(struct ln_rect_posn));
                       ln_get_ell_geo_rect_posn(&in, jdin, out);
                       al = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
                       lst = C_list(&al, 3, 
                                        C_flonum(&al, out->X),
                                        C_flonum(&al, out->Y),
                                        C_flonum(&al, out->Z));
                       free(out);
                       C_return(callback(lst));")
                       (ell-a ell-in)
                       (ell-e ell-in)
                       (ell-i ell-in)
                       (ell-w ell-in)
                       (ell-omega ell-in)
                       (ell-n ell-in)
                       (ell-jd ell-in)
                       jdin)))
 
    ;; returns rect type 
    (define (ell-helio-rect-posn ell-in jdin)
      (apply make-rect
        ((foreign-safe-lambda* scheme-object ((double a) (double e) (double i) (double w)
                                              (double omega) (double n) (double jde) (double jdin))
                       "C_word lst = C_SCHEME_END_OF_LIST, *al;
                       struct ln_ell_orbit in = {.a = a, .e = e, .i = i, .w = w,
                                               .omega = omega, .n = n, .JD = jde};
                       struct ln_rect_posn *out;
                       out = malloc(sizeof(struct ln_rect_posn));
                       ln_get_ell_helio_rect_posn(&in, jdin, out);
                       al = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
                       lst = C_list(&al, 3, 
                                        C_flonum(&al, out->X),
                                        C_flonum(&al, out->Y),
                                        C_flonum(&al, out->Z));
                       free(out);
                       C_return(callback(lst));")
                       (ell-a ell-in)
                       (ell-e ell-in)
                       (ell-i ell-in)
                       (ell-w ell-in)
                       (ell-omega ell-in)
                       (ell-n ell-in)
                       (ell-jd ell-in)
                       jdin)))

    (define (ell-orbit-len ell-in) 
        ((foreign-safe-lambda* double ((double a) (double e) (double i) (double w)
                                              (double omega) (double n) (double jd))
                       "struct ln_ell_orbit in = {.a = a, .e = e, .i = i, .w = w,
                                               .omega = omega, .n = n, .JD = jd};
                       C_return(ln_get_ell_orbit_len(&in));")
                       (ell-a ell-in)
                       (ell-e ell-in)
                       (ell-i ell-in)
                       (ell-w ell-in)
                       (ell-omega ell-in)
                       (ell-n ell-in)
                       (ell-jd ell-in)))

     (define (ell-orbit-vel jdin ell-in) 
        ((foreign-safe-lambda* double ((double jdin) (double a) (double e) (double i) (double w)
                                              (double omega) (double n) (double jde))
                       "struct ln_ell_orbit in = {.a = a, .e = e, .i = i, .w = w,
                                               .omega = omega, .n = n, .JD = jde};
                       C_return(ln_get_ell_orbit_vel(jdin, &in));")
                       jdin
                       (ell-a ell-in)
                       (ell-e ell-in)
                       (ell-i ell-in)
                       (ell-w ell-in)
                       (ell-omega ell-in)
                       (ell-n ell-in)
                       (ell-jd ell-in)))

      (define (ell-orbit-pvel ell-in) 
        ((foreign-safe-lambda* double ((double a) (double e) (double i) (double w)
                                              (double omega) (double n) (double jde))
                       "struct ln_ell_orbit in = {.a = a, .e = e, .i = i, .w = w,
                                               .omega = omega, .n = n, .JD = jde};
                       C_return(ln_get_ell_orbit_pvel(&in));")
                       (ell-a ell-in)
                       (ell-e ell-in)
                       (ell-i ell-in)
                       (ell-w ell-in)
                       (ell-omega ell-in)
                       (ell-n ell-in)
                       (ell-jd ell-in)))

      (define (ell-orbit-avel ell-in) 
        ((foreign-safe-lambda* double ((double a) (double e) (double i) (double w)
                                              (double omega) (double n) (double jde))
                       "struct ln_ell_orbit in = {.a = a, .e = e, .i = i, .w = w,
                                               .omega = omega, .n = n, .JD = jde};
                       C_return(ln_get_ell_orbit_avel(&in));")
                       (ell-a ell-in)
                       (ell-e ell-in)
                       (ell-i ell-in)
                       (ell-w ell-in)
                       (ell-omega ell-in)
                       (ell-n ell-in)
                       (ell-jd ell-in)))

     (define (ell-body-phase-angle jdin ell-in) 
        ((foreign-safe-lambda* double ((double jdin) (double a) (double e) (double i) (double w)
                                              (double omega) (double n) (double jde))
                       "struct ln_ell_orbit in = {.a = a, .e = e, .i = i, .w = w,
                                               .omega = omega, .n = n, .JD = jde};
                       C_return(ln_get_ell_body_phase_angle(jdin, &in));")
                       jdin
                       (ell-a ell-in)
                       (ell-e ell-in)
                       (ell-i ell-in)
                       (ell-w ell-in)
                       (ell-omega ell-in)
                       (ell-n ell-in)
                       (ell-jd ell-in)))

     (define (ell-body-elong jdin ell-in) 
        ((foreign-safe-lambda* double ((double jdin) (double a) (double e) (double i) (double w)
                                              (double omega) (double n) (double jde))
                       "struct ln_ell_orbit in = {.a = a, .e = e, .i = i, .w = w,
                                               .omega = omega, .n = n, .JD = jde};
                       C_return(ln_get_ell_body_elong(jdin, &in));")
                       jdin
                       (ell-a ell-in)
                       (ell-e ell-in)
                       (ell-i ell-in)
                       (ell-w ell-in)
                       (ell-omega ell-in)
                       (ell-n ell-in)
                       (ell-jd ell-in)))

      (define (ell-body-solar-dist jdin ell-in) 
        ((foreign-safe-lambda* double ((double jdin) (double a) (double e) (double i) (double w)
                                              (double omega) (double n) (double jde))
                       "struct ln_ell_orbit in = {.a = a, .e = e, .i = i, .w = w,
                                               .omega = omega, .n = n, .JD = jde};
                       C_return(ln_get_ell_body_solar_dist(jdin, &in));")
                       jdin
                       (ell-a ell-in)
                       (ell-e ell-in)
                       (ell-i ell-in)
                       (ell-w ell-in)
                       (ell-omega ell-in)
                       (ell-n ell-in)
                       (ell-jd ell-in)))

      (define (ell-body-earth-dist jdin ell-in) 
        ((foreign-safe-lambda* double ((double jdin) (double a) (double e) (double i) (double w)
                                              (double omega) (double n) (double jde))
                       "struct ln_ell_orbit in = {.a = a, .e = e, .i = i, .w = w,
                                               .omega = omega, .n = n, .JD = jde};
                       C_return(ln_get_ell_body_earth_dist(jdin, &in));")
                       jdin
                       (ell-a ell-in)
                       (ell-e ell-in)
                       (ell-i ell-in)
                       (ell-w ell-in)
                       (ell-omega ell-in)
                       (ell-n ell-in)
                       (ell-jd ell-in)))

    ;; returns equ type 
    (define (ell-body-equ-coords jdin ell-in)
      (apply make-equ
        ((foreign-safe-lambda* scheme-object ((double jdin) (double a) (double e) (double i) (double w)
                                              (double omega) (double n) (double jde))
                       "C_word lst = C_SCHEME_END_OF_LIST, *al;
                       struct ln_ell_orbit in = {.a = a, .e = e, .i = i, .w = w,
                                               .omega = omega, .n = n, .JD = jde};
                       struct ln_equ_posn *out;
                       out = malloc(sizeof(struct ln_equ_posn));
                       ln_get_ell_body_equ_coords(jdin, &in, out);
                       al = C_alloc(C_SIZEOF_LIST(2) + C_SIZEOF_FLONUM * 2);
                       lst = C_list(&al, 3, 
                                        C_flonum(&al, out->ra),
                                        C_flonum(&al, out->dec));
                       free(out);
                       C_return(callback(lst));")
                       jdin
                       (ell-a ell-in)
                       (ell-e ell-in)
                       (ell-i ell-in)
                       (ell-w ell-in)
                       (ell-omega ell-in)
                       (ell-n ell-in)
                       (ell-jd ell-in))))

    ;; returns rst type 
    (define (ell-body-rst jdin ecl-in ell-in)
      (apply make-equ
        ((foreign-safe-lambda* scheme-object ((double jdin) (double lng) (double lat ) 
                                              (double a) (double e) (double i) (double w)
                                              (double omega) (double n) (double jde))
                       "C_word lst = C_SCHEME_END_OF_LIST, *al;
                       struct ln_ell_orbit in = {.a = a, .e = e, .i = i, .w = w,
                                               .omega = omega, .n = n, .JD = jde};
                       struct ln_lnlat_posn llin = {.lng = lng, .lat = lat};
                       struct ln_rst_time *out;
                       out = malloc(sizeof(struct ln_rst_time));
                       ln_get_ell_body_rst(jdin, &llin, &in, out);
                       al = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
                       lst = C_list(&al, 3, 
                                        C_flonum(&al, out->rise),
                                        C_flonum(&al, out->set),
                                        C_flonum(&al, out->transit));
                       free(out);
                       C_return(callback(lst));")
                       jdin
                       (ecl-lng ecl-in)
                       (ecl-lat ecl-in)
                       (ell-a ell-in)
                       (ell-e ell-in)
                       (ell-i ell-in)
                       (ell-w ell-in)
                       (ell-omega ell-in)
                       (ell-n ell-in)
                       (ell-jd ell-in))))
 
     ;; returns rst type 
    (define (ell-body-rst-horizon jdin ecl-in ell-in horizon)
      (apply make-equ
        ((foreign-safe-lambda* scheme-object ((double jdin) (double lng) (double lat ) 
                                              (double a) (double e) (double i) (double w)
                                              (double omega) (double n) (double jde)
                                              (double horizon))
                       "C_word lst = C_SCHEME_END_OF_LIST, *al;
                       struct ln_ell_orbit in = {.a = a, .e = e, .i = i, .w = w,
                                               .omega = omega, .n = n, .JD = jde};
                       struct ln_lnlat_posn llin = {.lng = lng, .lat = lat};
                       struct ln_rst_time *out;
                       out = malloc(sizeof(struct ln_rst_time));
                       ln_get_ell_body_rst_horizon(jdin, &llin, &in, horizon, out);
                       al = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
                       lst = C_list(&al, 3, 
                                        C_flonum(&al, out->rise),
                                        C_flonum(&al, out->set),
                                        C_flonum(&al, out->transit));
                       free(out);
                       C_return(callback(lst));")
                       jdin
                       (ecl-lng ecl-in)
                       (ecl-lat ecl-in)
                       (ell-a ell-in)
                       (ell-e ell-in)
                       (ell-i ell-in)
                       (ell-w ell-in)
                       (ell-omega ell-in)
                       (ell-n ell-in)
                       (ell-jd ell-in)
                       horizon)))

    ;; returns rst type 
    (define (ell-body-next-rst-horizon jdin ecl-in ell-in horizon)
      (apply make-equ
        ((foreign-safe-lambda* scheme-object ((double jdin) (double lng) (double lat ) 
                                              (double a) (double e) (double i) (double w)
                                              (double omega) (double n) (double jde)
                                              (double horizon))
                       "C_word lst = C_SCHEME_END_OF_LIST, *al;
                       struct ln_ell_orbit in = {.a = a, .e = e, .i = i, .w = w,
                                               .omega = omega, .n = n, .JD = jde};
                       struct ln_lnlat_posn llin = {.lng = lng, .lat = lat};
                       struct ln_rst_time *out;
                       out = malloc(sizeof(struct ln_rst_time));
                       ln_get_ell_body_next_rst_horizon(jdin, &llin, &in, horizon, out);
                       al = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
                       lst = C_list(&al, 3, 
                                        C_flonum(&al, out->rise),
                                        C_flonum(&al, out->set),
                                        C_flonum(&al, out->transit));
                       free(out);
                       C_return(callback(lst));")
                       jdin
                       (ecl-lng ecl-in)
                       (ecl-lat ecl-in)
                       (ell-a ell-in)
                       (ell-e ell-in)
                       (ell-i ell-in)
                       (ell-w ell-in)
                       (ell-omega ell-in)
                       (ell-n ell-in)
                       (ell-jd ell-in)
                       horizon)))
     ;; returns rst type 
    (define (ell-body-next-rst-horizon-future jdin ecl-in ell-in horizon daylimit)
      (apply make-equ
        ((foreign-safe-lambda* scheme-object ((double jdin) (double lng) (double lat ) 
                                              (double a) (double e) (double i) (double w)
                                              (double omega) (double n) (double jde)
                                              (double horizon) (double daylimit))
                       "C_word lst = C_SCHEME_END_OF_LIST, *al;
                       struct ln_ell_orbit in = {.a = a, .e = e, .i = i, .w = w,
                                               .omega = omega, .n = n, .JD = jde};
                       struct ln_lnlat_posn llin = {.lng = lng, .lat = lat};
                       struct ln_rst_time *out;
                       out = malloc(sizeof(struct ln_rst_time));
                       ln_get_ell_body_next_rst_horizon_future(jdin, &llin, &in, horizon, daylimit, out);
                       al = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
                       lst = C_list(&al, 3, 
                                        C_flonum(&al, out->rise),
                                        C_flonum(&al, out->set),
                                        C_flonum(&al, out->transit));
                       free(out);
                       C_return(callback(lst));")
                       jdin
                       (ecl-lng ecl-in)
                       (ecl-lat ecl-in)
                       (ell-a ell-in)
                       (ell-e ell-in)
                       (ell-i ell-in)
                       (ell-w ell-in)
                       (ell-omega ell-in)
                       (ell-n ell-in)
                       (ell-jd ell-in)
                       horizon
                       daylimit)))
    
    (define ell-last-perihelion (foreign-lambda double "ln_get_ell_last_perihelion" double double double))
 
 ;;; }}}

)              


