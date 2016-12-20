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
    (include "ephem-include.scm")

;;; }}}

;;; hyperbolic {{{1
    (define solve-hyp-barker (foreign-lambda double "ln_solve_hyp_barker" double double double))
    (define hyp-true-anomaly (foreign-lambda double "ln_get_hyp_true_anomaly" double double double))
    (define hyp-radius-vector (foreign-lambda double "ln_get_hyp_radius_vector" double double double))
    
    ;; returns rect type 
    (define (hyp-geo-rect-posn hyp-in jdin)
        ((foreign-safe-lambda* scheme-object ((double q) (double e) (double i) (double w)
                                              (double omega) (double jde) (double jdin))
                       "C_word lst = C_SCHEME_END_OF_LIST, *al;
                       struct ln_hyp_orbit in = {.q = q, .e = e, .i = i, .w = w,
                                               .omega = omega, .JD = jde};
                       struct ln_rect_posn *out;
                       out = malloc(sizeof(struct ln_rect_posn));
                       ln_get_hyp_geo_rect_posn(&in, jdin, out);
                       al = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
                       lst = C_list(&al, 3, 
                                        C_flonum(&al, out->X),
                                        C_flonum(&al, out->Y),
                                        C_flonum(&al, out->Z));
                       free(out);
                       C_return(apply_make_rect(lst));")
                       (hyp-q hyp-in)
                       (hyp-e hyp-in)
                       (hyp-i hyp-in)
                       (hyp-w hyp-in)
                       (hyp-omega hyp-in)
                       (hyp-jd hyp-in)
                       jdin))
 
    ;; returns rect type 
    (define (hyp-helio-rect-posn hyp-in jdin)
        ((foreign-safe-lambda* scheme-object ((double q) (double e) (double i) (double w)
                                              (double omega) (double jde) (double jdin))
                       "C_word lst = C_SCHEME_END_OF_LIST, *al;
                       struct ln_hyp_orbit in = {.q = q, .e = e, .i = i, .w = w,
                                               .omega = omega, .JD = jde};
                       struct ln_rect_posn *out;
                       out = malloc(sizeof(struct ln_rect_posn));
                       ln_get_hyp_helio_rect_posn(&in, jdin, out);
                       al = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
                       lst = C_list(&al, 3, 
                                        C_flonum(&al, out->X),
                                        C_flonum(&al, out->Y),
                                        C_flonum(&al, out->Z));
                       free(out);
                       C_return(apply_make_rect(lst));")
                       (hyp-q hyp-in)
                       (hyp-e hyp-in)
                       (hyp-i hyp-in)
                       (hyp-w hyp-in)
                       (hyp-omega hyp-in)
                       (hyp-jd hyp-in)
                       jdin))

    ;; returns equ type 
    (define (hyp-body-equ-coords jdin hyp-in)
        ((foreign-safe-lambda* scheme-object ((double jdin) (double q) (double e) (double i) (double w)
                                              (double omega) (double jde))
                       "C_word lst = C_SCHEME_END_OF_LIST, *al;
                       struct ln_hyp_orbit in = {.q = q, .e = e, .i = i, .w = w,
                                               .omega = omega, .JD = jde};
                       struct ln_equ_posn *out;
                       out = malloc(sizeof(struct ln_equ_posn));
                       ln_get_hyp_body_equ_coords(jdin, &in, out);
                       al = C_alloc(C_SIZEOF_LIST(2) + C_SIZEOF_FLONUM * 2);
                       lst = C_list(&al, 3, 
                                        C_flonum(&al, out->ra),
                                        C_flonum(&al, out->dec));
                       free(out);
                       C_return(apply_make_equ(lst));")
                       jdin
                       (hyp-q hyp-in)
                       (hyp-e hyp-in)
                       (hyp-i hyp-in)
                       (hyp-w hyp-in)
                       (hyp-omega hyp-in)
                       (hyp-jd hyp-in)))

    (define (hyp-body-earth-dist jdin hyp-in) 
        ((foreign-safe-lambda* double ((double jdin) (double q) (double e) (double i) (double w)
                                              (double omega) (double jde))
                       "struct ln_hyp_orbit in = {.q = q, .e = e, .i = i, .w = w,
                                               .omega = omega, .JD = jde};
                       C_return(ln_get_hyp_body_earth_dist(jdin, &in));")
                       jdin
                       (hyp-q hyp-in)
                       (hyp-e hyp-in)
                       (hyp-i hyp-in)
                       (hyp-w hyp-in)
                       (hyp-omega hyp-in)
                       (hyp-jd hyp-in)))

      (define (hyp-body-solar-dist jdin hyp-in) 
        ((foreign-safe-lambda* double ((double jdin) (double q) (double e) (double i) (double w)
                                              (double omega) (double jde))
                       "struct ln_hyp_orbit in = {.q = q, .e = e, .i = i, .w = w,
                                               .omega = omega, .JD = jde};
                       C_return(ln_get_hyp_body_solar_dist(jdin, &in));")
                       jdin
                       (hyp-q hyp-in)
                       (hyp-e hyp-in)
                       (hyp-i hyp-in)
                       (hyp-w hyp-in)
                       (hyp-omega hyp-in)
                       (hyp-jd hyp-in)))
 
      (define (hyp-body-phase-angle jdin hyp-in) 
        ((foreign-safe-lambda* double ((double jdin) (double q) (double e) (double i) (double w)
                                              (double omega) (double jde))
                       "struct ln_hyp_orbit in = {.q = q, .e = e, .i = i, .w = w,
                                               .omega = omega, .JD = jde};
                       C_return(ln_get_hyp_body_phase_angle(jdin, &in));")
                       jdin
                       (hyp-q hyp-in)
                       (hyp-e hyp-in)
                       (hyp-i hyp-in)
                       (hyp-w hyp-in)
                       (hyp-omega hyp-in)
                       (hyp-jd hyp-in)))

     (define (hyp-body-elong jdin hyp-in) 
        ((foreign-safe-lambda* double ((double jdin) (double q) (double e) (double i) (double w)
                                              (double omega) (double jde))
                       "struct ln_hyp_orbit in = {.q = q, .e = e, .i = i, .w = w,
                                               .omega = omega, .JD = jde};
                       C_return(ln_get_hyp_body_elong(jdin, &in));")
                       jdin
                       (hyp-q hyp-in)
                       (hyp-e hyp-in)
                       (hyp-i hyp-in)
                       (hyp-w hyp-in)
                       (hyp-omega hyp-in)
                       (hyp-jd hyp-in)))

   ;; returns rst type 
    (define (hyp-body-rst jdin ecl-in hyp-in)
        ((foreign-safe-lambda* scheme-object ((double jdin) (double lng) (double lat ) 
                                              (double q) (double e) (double i) (double w)
                                              (double omega) (double jde))
                       "C_word lst = C_SCHEME_END_OF_LIST, *al;
                       struct ln_hyp_orbit in = {.q = q, .e = e, .i = i, .w = w,
                                               .omega = omega, .JD = jde};
                       struct ln_lnlat_posn llin = {.lng = lng, .lat = lat};
                       struct ln_rst_time *out;
                       out = malloc(sizeof(struct ln_rst_time));
                       ln_get_hyp_body_rst(jdin, &llin, &in, out);
                       al = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
                       lst = C_list(&al, 3, 
                                        C_flonum(&al, out->rise),
                                        C_flonum(&al, out->set),
                                        C_flonum(&al, out->transit));
                       free(out);
                       C_return(apply_make_equ(lst));")
                       jdin
                       (ecl-lng ecl-in)
                       (ecl-lat ecl-in)
                       (hyp-q hyp-in)
                       (hyp-e hyp-in)
                       (hyp-i hyp-in)
                       (hyp-w hyp-in)
                       (hyp-omega hyp-in)
                       (hyp-jd hyp-in)))
 
     ;; returns rst type 
    (define (hyp-body-rst-horizon jdin ecl-in hyp-in horizon)
        ((foreign-safe-lambda* scheme-object ((double jdin) (double lng) (double lat ) 
                                              (double q) (double e) (double i) (double w)
                                              (double omega) (double jde)
                                              (double horizon))
                       "C_word lst = C_SCHEME_END_OF_LIST, *al;
                       struct ln_hyp_orbit in = {.q = q, .e = e, .i = i, .w = w,
                                               .omega = omega, .JD = jde};
                       struct ln_lnlat_posn llin = {.lng = lng, .lat = lat};
                       struct ln_rst_time *out;
                       out = malloc(sizeof(struct ln_rst_time));
                       ln_get_hyp_body_rst_horizon(jdin, &llin, &in, horizon, out);
                       al = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
                       lst = C_list(&al, 3, 
                                        C_flonum(&al, out->rise),
                                        C_flonum(&al, out->set),
                                        C_flonum(&al, out->transit));
                       free(out);
                       C_return(apply_make_equ(lst));")
                       jdin
                       (ecl-lng ecl-in)
                       (ecl-lat ecl-in)
                       (hyp-q hyp-in)
                       (hyp-e hyp-in)
                       (hyp-i hyp-in)
                       (hyp-w hyp-in)
                       (hyp-omega hyp-in)
                       (hyp-jd hyp-in)
                       horizon))

    ;; returns rst type 
    (define (hyp-body-next-rst-horizon jdin ecl-in hyp-in horizon)
        ((foreign-safe-lambda* scheme-object ((double jdin) (double lng) (double lat ) 
                                              (double q) (double e) (double i) (double w)
                                              (double omega) (double jde)
                                              (double horizon))
                       "C_word lst = C_SCHEME_END_OF_LIST, *al;
                       struct ln_hyp_orbit in = {.q = q, .e = e, .i = i, .w = w,
                                               .omega = omega, .JD = jde};
                       struct ln_lnlat_posn llin = {.lng = lng, .lat = lat};
                       struct ln_rst_time *out;
                       out = malloc(sizeof(struct ln_rst_time));
                       ln_get_hyp_body_next_rst_horizon(jdin, &llin, &in, horizon, out);
                       al = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
                       lst = C_list(&al, 3, 
                                        C_flonum(&al, out->rise),
                                        C_flonum(&al, out->set),
                                        C_flonum(&al, out->transit));
                       free(out);
                       C_return(apply_make_equ(lst));")
                       jdin
                       (ecl-lng ecl-in)
                       (ecl-lat ecl-in)
                       (hyp-q hyp-in)
                       (hyp-e hyp-in)
                       (hyp-i hyp-in)
                       (hyp-w hyp-in)
                       (hyp-omega hyp-in)
                       (hyp-jd hyp-in)
                       horizon))
     ;; returns rst type 
    (define (hyp-body-next-rst-horizon-future jdin ecl-in hyp-in horizon daylimit)
        ((foreign-safe-lambda* scheme-object ((double jdin) (double lng) (double lat ) 
                                              (double q) (double e) (double i) (double w)
                                              (double omega) (double jde)
                                              (double horizon) (double daylimit))
                       "C_word lst = C_SCHEME_END_OF_LIST, *al;
                       struct ln_hyp_orbit in = {.q = q, .e = e, .i = i, .w = w,
                                               .omega = omega, .JD = jde};
                       struct ln_lnlat_posn llin = {.lng = lng, .lat = lat};
                       struct ln_rst_time *out;
                       out = malloc(sizeof(struct ln_rst_time));
                       ln_get_hyp_body_next_rst_horizon_future(jdin, &llin, &in, horizon, daylimit, out);
                       al = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
                       lst = C_list(&al, 3, 
                                        C_flonum(&al, out->rise),
                                        C_flonum(&al, out->set),
                                        C_flonum(&al, out->transit));
                       free(out);
                       C_return(apply_make_equ(lst));")
                       jdin
                       (ecl-lng ecl-in)
                       (ecl-lat ecl-in)
                       (hyp-q hyp-in)
                       (hyp-e hyp-in)
                       (hyp-i hyp-in)
                       (hyp-w hyp-in)
                       (hyp-omega hyp-in)
                       (hyp-jd hyp-in)
                       horizon
                       daylimit))
    
 ;;; }}}

)              


