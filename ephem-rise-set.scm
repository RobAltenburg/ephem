;;; ephem-rise-set
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-rise-set
        (object-rst object-next-rst)
         ;;> object-next-rst object-next-rst-horizon
         ;;> body-rst-horizon body-next-rst-horizon
         ;;> body-next-rst-horizon-future)

    (import chicken scheme foreign)

;;; }}}

;;; Headers {{{1 
    (foreign-declare "#include <libnova/ln_types.h>")
    (foreign-declare "#include <libnova/rise_set.h>")
    (define-external (callback (scheme-object obj)) scheme-object obj)

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
                       free(out);
                       C_return(callback(lst));"))

    ;; returns #(rise set transit) in jd
    (define object-next-rst
        (foreign-safe-lambda* scheme-object ((double jd) (double lng) (double lat)
                                                         (double ra) (double dec))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_lnlat_posn in_observer = {.lat = lat, .lng = lng};
                       struct ln_equ_posn in_object = {.ra = ra, .dec = dec};
                       struct ln_rst_time *out;
                       int flag;
                       out = malloc(sizeof(struct ln_rst_time));
                       flag = ln_get_object_next_rst(jd, &in_observer, &in_object, out);
                       a = C_alloc(C_SIZEOF_LIST(4) + C_SIZEOF_FLONUM * 3 + 1);
                       lst = C_vector(&a, 4, 
                                        C_flonum(&a, out->rise),
                                        C_flonum(&a, out->set),
                                        C_flonum(&a, out->transit),
                                        C_fix(flag));
                       free(out);
                       C_return(callback(lst));"))


    ;; returns #(rise set transit) in jd
    (define object-next-rst-horizon
        (foreign-safe-lambda* scheme-object ((double jd) (double lng) (double lat)
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
                       lst = C_vector(&a, 4, 
                                        C_flonum(&a, out->rise),
                                        C_flonum(&a, out->set),
                                        C_flonum(&a, out->transit),
                                        C_fix(flag));
                       free(out); 
                       C_return(callback(lst));"))

;}}}

)



