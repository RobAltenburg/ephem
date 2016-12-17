;;; ephem-rise-set
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-rise-set
        (object-rst object-next-rst object-next-rst-horizon
         body-equ-pointer body-rst-horizon body-next-rst-horizon  
         body-next-rst-horizon-future)

    (import chicken scheme foreign)
    (use ephem-common)

;;; }}}

;;; Headers {{{1 
    (foreign-declare "#include <libnova/ln_types.h>")
    (foreign-declare "#include <libnova/rise_set.h>")
    (foreign-declare "#include <libnova/lunar.h>")
    (foreign-declare "#include <libnova/solar.h>")
    (foreign-declare "#include <libnova/mercury.h>")
    (foreign-declare "#include <libnova/venus.h>")
    (foreign-declare "#include <libnova/mars.h>")
    (foreign-declare "#include <libnova/jupiter.h>")
    (foreign-declare "#include <libnova/saturn.h>")
    (foreign-declare "#include <libnova/uranus.h>")
    (foreign-declare "#include <libnova/neptune.h>")
    (foreign-declare "#include <libnova/pluto.h>")
    (define-external (callback (scheme-object obj)) scheme-object obj)

;;; }}} 

;;; Rise Set {{{1

    ;; returns rst record type in jd
    (define (object-rst jd ecl-in equ-in)
      (apply make-rst 
        ((foreign-safe-lambda* scheme-object ((double jd) (double lng) (double lat)
                                                         (double ra) (double dec))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_lnlat_posn in_observer = {.lat = lat, .lng = lng};
                       struct ln_equ_posn in_object = {.ra = ra, .dec = dec};
                       struct ln_rst_time *out;
                       int flag;
                       out = malloc(sizeof(struct ln_rst_time));
                       flag = ln_get_object_rst(jd, &in_observer, &in_object, out);
                       a = C_alloc(C_SIZEOF_LIST(4) + C_SIZEOF_FLONUM * 3 + 1);
                       lst = C_list(&a, 4, 
                                        C_flonum(&a, out->rise),
                                        C_flonum(&a, out->set),
                                        C_flonum(&a, out->transit),
                                        C_fix(flag));
                       free(out);
                       C_return(callback(lst));")
                       jd
                       (ecl-lng ecl-in) (ecl-lat ecl-in)
                       (equ-ra equ-in) (equ-dec equ-in))))

    ;; returns rst record type in jd
    (define (object-next-rst jd ecl-in equ-in)
      (apply make-rst
        ((foreign-safe-lambda* scheme-object ((double jd) (double lng) (double lat)
                                                         (double ra) (double dec))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_lnlat_posn in_observer = {.lat = lat, .lng = lng};
                       struct ln_equ_posn in_object = {.ra = ra, .dec = dec};
                       struct ln_rst_time *out;
                       int flag;
                       out = malloc(sizeof(struct ln_rst_time));
                       flag = ln_get_object_next_rst(jd, &in_observer, &in_object, out);
                       a = C_alloc(C_SIZEOF_LIST(4) + C_SIZEOF_FLONUM * 3 + 1);
                       lst = C_list(&a, 4, 
                                        C_flonum(&a, out->rise),
                                        C_flonum(&a, out->set),
                                        C_flonum(&a, out->transit),
                                        C_fix(flag));
                       free(out);
                       C_return(callback(lst));")
                       jd
                       (ecl-lng ecl-in) (ecl-lat ecl-in)
                       (equ-ra equ-in) (equ-dec equ-in))))


    ;; returns rst record type in jd
    (define (object-next-rst-horizon jd ecl-in equ-in horizon)
      (apply make-rst
        ((foreign-safe-lambda* scheme-object ((double jd) (double lng) (double lat)
                                                         (double ra) (double dec)
                                                         (double horizon))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_lnlat_posn in_observer = {.lat = lat, .lng = lng};
                       struct ln_equ_posn in_object = {.ra = ra, .dec = dec};
                       struct ln_rst_time *out;
                       int flag;
                       out = malloc(sizeof(struct ln_rst_time));
                       flag = ln_get_object_next_rst_horizon(jd, &in_observer, &in_object, horizon, out);
                       a = C_alloc(C_SIZEOF_LIST(4) + C_SIZEOF_FLONUM * 3 + 1);
                       lst = C_list(&a, 4, 
                                        C_flonum(&a, out->rise),
                                        C_flonum(&a, out->set),
                                        C_flonum(&a, out->transit),
                                        C_fix(flag));
                       free(out); 
                       C_return(callback(lst));")
                       jd
                       (ecl-lng ecl-in) (ecl-lat ecl-in)
                       (equ-ra equ-in) (equ-dec equ-in)
                       horizon)))
;}}}

;;; Body Rise Set {{{1

    (define (body-equ-pointer body)
      (cond ((equal? body 'moon)
                ((foreign-lambda* nonnull-c-pointer () "C_return(&ln_get_lunar_equ_coords);")))
            ((equal? body 'sun)
                ((foreign-lambda* nonnull-c-pointer () "C_return(&ln_get_solar_equ_coords);")))
            ((equal? body 'mercury)
                ((foreign-lambda* nonnull-c-pointer () "C_return(&ln_get_mercury_equ_coords);")))
            ((equal? body 'venus)
                ((foreign-lambda* nonnull-c-pointer () "C_return(&ln_get_venus_equ_coords);")))
            ((equal? body 'mars)
                ((foreign-lambda* nonnull-c-pointer () "C_return(&ln_get_mars_equ_coords);")))
            ((equal? body 'jupiter)
                ((foreign-lambda* nonnull-c-pointer () "C_return(&ln_get_jupiter_equ_coords);")))
            ((equal? body 'saturn)
                ((foreign-lambda* nonnull-c-pointer () "C_return(&ln_get_saturn_equ_coords);")))
            ((equal? body 'uranus)
                ((foreign-lambda* nonnull-c-pointer () "C_return(&ln_get_uranus_equ_coords);")))
            ((equal? body 'neptune)
                ((foreign-lambda* nonnull-c-pointer () "C_return(&ln_get_neptune_equ_coords);")))
            ((equal? body 'pluto)
                ((foreign-lambda* nonnull-c-pointer () "C_return(&ln_get_pluto_equ_coords);")))))

    ;; note that "body" us a symbol
    ;; returns rst record type in jd
    (define (body-rst-horizon jd ecl-in body horizon)
      (let ((bb (body-equ-pointer body)))
          (apply make-rst 
            ((foreign-safe-lambda* scheme-object ((double jd) (double lng) (double lat)
                                                  (nonnull-c-pointer body) (double horizon)) 
                           "C_word lst = C_SCHEME_END_OF_LIST, *a;
                           struct ln_lnlat_posn in_observer = {.lat = lat, .lng = lng};
                           struct ln_rst_time *out;
                           int flag;
                           out = malloc(sizeof(struct ln_rst_time));
                           flag = ln_get_body_rst_horizon(jd, &in_observer, body, horizon, out);
                           a = C_alloc(C_SIZEOF_LIST(4) + C_SIZEOF_FLONUM * 3 + 1);
                           lst = C_list(&a, 4, 
                                            C_flonum(&a, out->rise),
                                            C_flonum(&a, out->set),
                                            C_flonum(&a, out->transit),
                                            C_fix(flag));
                           free(out);
                           C_return(callback(lst));")
                           jd
                           (ecl-lng ecl-in) (ecl-lat ecl-in)
                           bb horizon))))
    
    ;; note that "body" us a symbol
    ;; returns rst record type in jd
    (define (body-next-rst-horizon jd ecl-in body horizon)
      (let ((bb (body-equ-pointer body)))
          (apply make-rst 
            ((foreign-safe-lambda* scheme-object ((double jd) (double lng) (double lat)
                                                  (nonnull-c-pointer body) (double horizon)) 
                           "C_word lst = C_SCHEME_END_OF_LIST, *a;
                           struct ln_lnlat_posn in_observer = {.lat = lat, .lng = lng};
                           struct ln_rst_time *out;
                           int flag;
                           out = malloc(sizeof(struct ln_rst_time));
                           flag = ln_get_body_next_rst_horizon(jd, &in_observer, body, horizon, out);
                           a = C_alloc(C_SIZEOF_LIST(4) + C_SIZEOF_FLONUM * 3 + 1);
                           lst = C_list(&a, 4, 
                                            C_flonum(&a, out->rise),
                                            C_flonum(&a, out->set),
                                            C_flonum(&a, out->transit),
                                            C_fix(flag));
                           free(out);
                           C_return(callback(lst));")
                           jd
                           (ecl-lng ecl-in) (ecl-lat ecl-in)
                           bb horizon))))

    ;; note that "body" us a symbol
    ;; returns rst record type in jd
    (define (body-next-rst-horizon-future jd ecl-in body horizon day-limit)
      (let ((bb (body-equ-pointer body)))
          (apply make-rst 
            ((foreign-safe-lambda* scheme-object ((double jd) (double lng) (double lat)
                                                  (nonnull-c-pointer body) (double horizon) (double day_limit)) 
                           "C_word lst = C_SCHEME_END_OF_LIST, *a;
                           struct ln_lnlat_posn in_observer = {.lat = lat, .lng = lng};
                           struct ln_rst_time *out;
                           int flag;
                           out = malloc(sizeof(struct ln_rst_time));
                           flag = ln_get_body_next_rst_horizon_future(jd, &in_observer, body, horizon, day_limit, out);
                           a = C_alloc(C_SIZEOF_LIST(4) + C_SIZEOF_FLONUM * 3 + 1);
                           lst = C_list(&a, 4, 
                                            C_flonum(&a, out->rise),
                                            C_flonum(&a, out->set),
                                            C_flonum(&a, out->transit),
                                            C_fix(flag));
                           free(out);
                           C_return(callback(lst));")
                           jd
                           (ecl-lng ecl-in) (ecl-lat ecl-in)
                           bb horizon day-limit))))
   

;;; }}}

)



