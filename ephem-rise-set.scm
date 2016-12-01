;;; ephem-rise-set
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-rise-set
        (object-rst)
         ;;> object-next-rst object-next-rst-horizon
         ;;> body-rst-horizon body-next-rst-horizon
         ;;> body-next-rst-horizon-future)

    (import chicken scheme foreign)

;;; }}}

;;; Headers {{{1 
    (foreign-declare "#include <libnova/ln_types.h>")
    (foreign-declare "#include <libnova/rise_set.h>")

;;; }}} 

;;; Rise Set {{{1

    ;; returns #(rise set transit) in jd
    (define object-rst
        (foreign-safe-lambda* scheme-object ((double jd) (double lng) (double lat)
                                                         (double ra) (double dec))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_lnlat_posn in_observer = {.lat = lat, .lng = lng};
                       struct ln_equ_posn in_object = {.ra = ra, .dec = dec};
                       struct ln_rst_time *out;
                       int flag;
                       out = malloc(sizeof(struct ln_rst_time));
                       flag = ln_get_object_rst(jd, &in_observer, &in_object, out);
                       a = C_alloc(C_SIZEOF_LIST(4) + C_SIZEOF_FLONUM * 3 + 1);
                       lst = C_vector(&a, 4, 
                                        C_flonum(&a, out->rise),
                                        C_flonum(&a, out->set),
                                        C_flonum(&a, out->transit),
                                        C_fix(flag));
                       C_return(lst);"))




;}}}

)

;;; Solar {{{1
;;>>    ;; returns #(rise set transit) in jd
;;>>    (define solar-rst-horizon
;;>>        (foreign-safe-lambda* scheme-object ((double jd) (double lng) (double lat) (double horizon))
;;>>                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
;;>>                       struct ln_lnlat_posn in = {.lat = lat, .lng = lng};
;;>>                       struct ln_rst_time *out;
;;>>                       out = malloc(sizeof(struct ln_rst_time));
;;>>                       ln_get_solar_rst_horizon(jd, &in, horizon, out);
;;>>                       a = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
;;>>                       lst = C_vector(&a, 3, 
;;>>                                        C_flonum(&a, out->rise),
;;>>                                        C_flonum(&a, out->set),
;;>>                                        C_flonum(&a, out->transit));
;;>>                       C_return(lst);"))
;;>>
;;>>    ;; returns #(rise set transit) in jd
;;>>    (define solar-rst
;;>>        (foreign-safe-lambda* scheme-object ((double jd) (double lng) (double lat))
;;>>                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
;;>>                       struct ln_lnlat_posn in = {.lat = lat, .lng = lng};
;;>>                       struct ln_rst_time *out;
;;>>                       out = malloc(sizeof(struct ln_rst_time));
;;>>                       ln_get_solar_rst(jd, &in, out);
;;>>                       a = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
;;>>                       lst = C_vector(&a, 3, 
;;>>                                        C_flonum(&a, out->rise),
;;>>                                        C_flonum(&a, out->set),
;;>>                                        C_flonum(&a, out->transit));
;;>>                       C_return(lst);"))
;;>>
;;>>    ;; returns #(L B R) 
;;>>    (define solar-geom-coords
;;>>        (foreign-safe-lambda* scheme-object ((double jd))
;;>>                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
;;>>                       struct ln_helio_posn *r;
;;>>                       r = malloc(sizeof(struct ln_helio_posn));
;;>>                       ln_get_solar_geom_coords(jd, r);
;;>>                       a = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
;;>>                       lst = C_vector(&a, 3, 
;;>>                                        C_flonum(&a, r->L),
;;>>                                        C_flonum(&a, r->B),
;;>>                                        C_flonum(&a, r->R));
;;>>                       C_return(lst);"))
;;>>
;;>>                       
;;>>    ;; returns #(ra dec) 
;;>>    (define solar-equ-coords 
;;>>        (foreign-safe-lambda* scheme-object ((double jd))
;;>>                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
;;>>                       struct ln_equ_posn *r;
;;>>                       r = malloc(sizeof(struct ln_equ_posn));
;;>>                       ln_get_solar_equ_coords(jd, r);
;;>>                       a = C_alloc(C_SIZEOF_LIST(2) + C_SIZEOF_FLONUM * 2);
;;>>                       lst = C_vector(&a, 2, 
;;>>                                        C_flonum(&a, r->ra),
;;>>                                        C_flonum(&a, r->dec));
;;>>                       C_return(lst);"))
;;>>
;;>>    ;; returns #(lat lng) degrees
;;>>    (define solar-ecl-coords 
;;>>        (foreign-safe-lambda* scheme-object ((double jd))
;;>>                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
;;>>                       struct ln_lnlat_posn *r;
;;>>                       r = malloc(sizeof(struct ln_equ_posn));
;;>>                       ln_get_solar_ecl_coords(jd, r);
;;>>                       a = C_alloc(C_SIZEOF_LIST(2) + C_SIZEOF_FLONUM * 2);
;;>>                       lst = C_vector(&a, 2, 
;;>>                                        C_flonum(&a, r->lat),
;;>>                                        C_flonum(&a, r->lng));
;;>>                       C_return(lst);"))
;;>>
;;>>    ;; returns #(X Y Z) 
;;>>    (define solar-geo-coords
;;>>        (foreign-safe-lambda* scheme-object ((double jd))
;;>>                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
;;>>                       struct ln_rect_posn *r;
;;>>                       r = malloc(sizeof(struct ln_rect_posn));
;;>>                       ln_get_solar_geo_coords(jd, r);
;;>>                       a = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
;;>>                       lst = C_vector(&a, 3, 
;;>>                                        C_flonum(&a, r->X),
;;>>                                        C_flonum(&a, r->Y),
;;>>                                        C_flonum(&a, r->Z));
;;>>                       C_return(lst);"))
;;>>
;;>>    (define solar-sdiam 
;;>>      (foreign-lambda double "ln_get_solar_sdiam" double))
;;>>
;;>>    ;;; }}}



