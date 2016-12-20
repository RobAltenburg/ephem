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
    (include "ephem-include.scm")

;;; }}}

;;; Parabolic {{{1
    (define solve-barker (foreign-lambda double "ln_solve_barker" double double))
    (define par-true-anomaly (foreign-lambda double "ln_get_par_true_anomaly" double double))
    (define par-radius-vector (foreign-lambda double "ln_get_par_radius_vector" double double))
    
    ;; returns rect type 
    (define (par-geo-rect-posn par-in jdin)
        ((foreign-safe-lambda* scheme-object ((double q) (double i) (double w)
                                              (double omega) (double jde) (double jdin))
                       "C_word lst = C_SCHEME_END_OF_LIST, *al;
                       struct ln_par_orbit in = {.q = q, .i = i, .w = w,
                                               .omega = omega, .JD = jde};
                       struct ln_rect_posn *out;
                       out = malloc(sizeof(struct ln_rect_posn));
                       ln_get_par_geo_rect_posn(&in, jdin, out);
                       al = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
                       lst = C_list(&al, 3, 
                                        C_flonum(&al, out->X),
                                        C_flonum(&al, out->Y),
                                        C_flonum(&al, out->Z));
                       free(out);
                       C_return(apply_make_rect(lst));")
                       (par-q par-in)
                       (par-i par-in)
                       (par-w par-in)
                       (par-omega par-in)
                       (par-jd par-in)
                       jdin))
 
    ;; returns rect type 
    (define (par-helio-rect-posn par-in jdin)
        ((foreign-safe-lambda* scheme-object ((double q) (double i) (double w)
                                              (double omega) (double jde) (double jdin))
                       "C_word lst = C_SCHEME_END_OF_LIST, *al;
                       struct ln_par_orbit in = {.q = q, .i = i, .w = w,
                                               .omega = omega, .JD = jde};
                       struct ln_rect_posn *out;
                       out = malloc(sizeof(struct ln_rect_posn));
                       ln_get_par_helio_rect_posn(&in, jdin, out);
                       al = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
                       lst = C_list(&al, 3, 
                                        C_flonum(&al, out->X),
                                        C_flonum(&al, out->Y),
                                        C_flonum(&al, out->Z));
                       free(out);
                       C_return(apply_make_rect(lst));")
                       (par-q par-in)
                       (par-i par-in)
                       (par-w par-in)
                       (par-omega par-in)
                       (par-jd par-in)
                       jdin))

    ;; returns equ type 
    (define (par-body-equ-coords jdin par-in)
        ((foreign-safe-lambda* scheme-object ((double jdin) (double q) (double i) (double w)
                                              (double omega) (double jde))
                       "C_word lst = C_SCHEME_END_OF_LIST, *al;
                       struct ln_par_orbit in = {.q = q, .i = i, .w = w,
                                               .omega = omega, .JD = jde};
                       struct ln_equ_posn *out;
                       out = malloc(sizeof(struct ln_equ_posn));
                       ln_get_par_body_equ_coords(jdin, &in, out);
                       al = C_alloc(C_SIZEOF_LIST(2) + C_SIZEOF_FLONUM * 2);
                       lst = C_list(&al, 3, 
                                        C_flonum(&al, out->ra),
                                        C_flonum(&al, out->dec));
                       free(out);
                       C_return(apply_make_equ(lst));")
                       jdin
                       (par-q par-in)
                       (par-i par-in)
                       (par-w par-in)
                       (par-omega par-in)
                       (par-jd par-in)))

    (define (par-body-earth-dist jdin par-in) 
        ((foreign-safe-lambda* double ((double jdin) (double q) (double i) (double w)
                                              (double omega) (double jde))
                       "struct ln_par_orbit in = {.q = q, .i = i, .w = w,
                                               .omega = omega, .JD = jde};
                       C_return(ln_get_par_body_earth_dist(jdin, &in));")
                       jdin
                       (par-q par-in)
                       (par-i par-in)
                       (par-w par-in)
                       (par-omega par-in)
                       (par-jd par-in)))

      (define (par-body-solar-dist jdin par-in) 
        ((foreign-safe-lambda* double ((double jdin) (double q) (double i) (double w)
                                              (double omega) (double jde))
                       "struct ln_par_orbit in = {.q = q, .i = i, .w = w,
                                               .omega = omega, .JD = jde};
                       C_return(ln_get_par_body_solar_dist(jdin, &in));")
                       jdin
                       (par-q par-in)
                       (par-i par-in)
                       (par-w par-in)
                       (par-omega par-in)
                       (par-jd par-in)))
 
      (define (par-body-phase-angle jdin par-in) 
        ((foreign-safe-lambda* double ((double jdin) (double q) (double i) (double w)
                                              (double omega) (double jde))
                       "struct ln_par_orbit in = {.q = q, .i = i, .w = w,
                                               .omega = omega, .JD = jde};
                       C_return(ln_get_par_body_phase_angle(jdin, &in));")
                       jdin
                       (par-q par-in)
                       (par-i par-in)
                       (par-w par-in)
                       (par-omega par-in)
                       (par-jd par-in)))

     (define (par-body-elong jdin par-in) 
        ((foreign-safe-lambda* double ((double jdin) (double q) (double i) (double w)
                                              (double omega) (double jde))
                       "struct ln_par_orbit in = {.q = q, .i = i, .w = w,
                                               .omega = omega, .JD = jde};
                       C_return(ln_get_par_body_elong(jdin, &in));")
                       jdin
                       (par-q par-in)
                       (par-i par-in)
                       (par-w par-in)
                       (par-omega par-in)
                       (par-jd par-in)))

   ;; returns rst type 
    (define (par-body-rst jdin ecl-in par-in)
        ((foreign-safe-lambda* scheme-object ((double jdin) (double lng) (double lat ) 
                                              (double q) (double i) (double w)
                                              (double omega) (double jde))
                       "C_word lst = C_SCHEME_END_OF_LIST, *al;
                       struct ln_par_orbit in = {.q = q, .i = i, .w = w,
                                               .omega = omega, .JD = jde};
                       struct ln_lnlat_posn llin = {.lng = lng, .lat = lat};
                       struct ln_rst_time *out;
                       out = malloc(sizeof(struct ln_rst_time));
                       ln_get_par_body_rst(jdin, &llin, &in, out);
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
                       (par-q par-in)
                       (par-i par-in)
                       (par-w par-in)
                       (par-omega par-in)
                       (par-jd par-in)))
 
     ;; returns rst type 
    (define (par-body-rst-horizon jdin ecl-in par-in horizon)
        ((foreign-safe-lambda* scheme-object ((double jdin) (double lng) (double lat ) 
                                              (double q) (double i) (double w)
                                              (double omega) (double jde)
                                              (double horizon))
                       "C_word lst = C_SCHEME_END_OF_LIST, *al;
                       struct ln_par_orbit in = {.q = q, .i = i, .w = w,
                                               .omega = omega, .JD = jde};
                       struct ln_lnlat_posn llin = {.lng = lng, .lat = lat};
                       struct ln_rst_time *out;
                       out = malloc(sizeof(struct ln_rst_time));
                       ln_get_par_body_rst_horizon(jdin, &llin, &in, horizon, out);
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
                       (par-q par-in)
                       (par-i par-in)
                       (par-w par-in)
                       (par-omega par-in)
                       (par-jd par-in)
                       horizon))

    ;; returns rst type 
    (define (par-body-next-rst-horizon jdin ecl-in par-in horizon)
        ((foreign-safe-lambda* scheme-object ((double jdin) (double lng) (double lat ) 
                                              (double q) (double i) (double w)
                                              (double omega) (double jde)
                                              (double horizon))
                       "C_word lst = C_SCHEME_END_OF_LIST, *al;
                       struct ln_par_orbit in = {.q = q, .i = i, .w = w,
                                               .omega = omega, .JD = jde};
                       struct ln_lnlat_posn llin = {.lng = lng, .lat = lat};
                       struct ln_rst_time *out;
                       out = malloc(sizeof(struct ln_rst_time));
                       ln_get_par_body_next_rst_horizon(jdin, &llin, &in, horizon, out);
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
                       (par-q par-in)
                       (par-i par-in)
                       (par-w par-in)
                       (par-omega par-in)
                       (par-jd par-in)
                       horizon))
     ;; returns rst type 
    (define (par-body-next-rst-horizon-future jdin ecl-in par-in horizon daylimit)
        ((foreign-safe-lambda* scheme-object ((double jdin) (double lng) (double lat ) 
                                              (double q) (double i) (double w)
                                              (double omega) (double jde)
                                              (double horizon) (double daylimit))
                       "C_word lst = C_SCHEME_END_OF_LIST, *al;
                       struct ln_par_orbit in = {.q = q, .i = i, .w = w,
                                               .omega = omega, .JD = jde};
                       struct ln_lnlat_posn llin = {.lng = lng, .lat = lat};
                       struct ln_rst_time *out;
                       out = malloc(sizeof(struct ln_rst_time));
                       ln_get_par_body_next_rst_horizon_future(jdin, &llin, &in, horizon, daylimit, out);
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
                       (par-q par-in)
                       (par-i par-in)
                       (par-w par-in)
                       (par-omega par-in)
                       (par-jd par-in)
                       horizon
                       daylimit))
    
 ;;; }}}

)              


