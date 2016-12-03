;;; ephem-mars
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-mars
        ( mars-sdiam mars-rst mars-helio-coords mars-equ-coords
          mars-earth-dist mars-solar-dist mars-magnitude 
          mars-disk mars-phase mars-rect-helio)

    (import chicken scheme foreign)

;;; }}}

;;; Headers {{{1 
    (foreign-declare "#include <libnova/mars.h>")
    (foreign-declare "#include <libnova/ln_types.h>")
    (define-external (callback (scheme-object obj)) scheme-object obj)

;;; }}} 

;;; mars {{{1
    (define mars-sdiam 
      (foreign-lambda double "ln_get_mars_sdiam" double))

    ;; returns #(rise set transit) in jd
    (define mars-rst
        (foreign-safe-lambda* scheme-object ((double jd) (double lng) (double lat))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_lnlat_posn in = {.lat = lat, .lng = lng};
                       struct ln_rst_time *out;
                       out = malloc(sizeof(struct ln_rst_time));
                       ln_get_mars_rst(jd, &in, out);
                       a = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
                       lst = C_vector(&a, 3, 
                                        C_flonum(&a, out->rise),
                                        C_flonum(&a, out->set),
                                        C_flonum(&a, out->transit));
                       free(out);
                       C_return(callback(lst));"))

    ;; returns #(L B R) 
    (define mars-helio-coords
        (foreign-safe-lambda* scheme-object ((double jd))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_helio_posn *r;
                       r = malloc(sizeof(struct ln_helio_posn));
                       ln_get_mars_helio_coords(jd, r);
                       a = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
                       lst = C_vector(&a, 3, 
                                        C_flonum(&a, r->L),
                                        C_flonum(&a, r->B),
                                        C_flonum(&a, r->R));
                       free(r);
                       C_return(callback(lst));"))

    ;; returns #(ra dec) 
    (define mars-equ-coords
        (foreign-safe-lambda* scheme-object ((double jd))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_equ_posn *r;
                       r = malloc(sizeof(struct ln_equ_posn));
                       ln_get_mars_equ_coords(jd, r);
                       a = C_alloc(C_SIZEOF_LIST(2) + C_SIZEOF_FLONUM * 2);
                       lst = C_vector(&a, 2, 
                                        C_flonum(&a, r->ra),
                                        C_flonum(&a, r->dec));
                       free(r);
                       C_return(callback(lst));"))

    ;; returns #(ra dec) 
    (define mars-equ-coords 
        (foreign-safe-lambda* scheme-object ((double jd))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_equ_posn *r;
                       r = malloc(sizeof(struct ln_equ_posn));
                       ln_get_mars_equ_coords(jd, r);
                       a = C_alloc(C_SIZEOF_LIST(2) + C_SIZEOF_FLONUM * 2);
                       lst = C_vector(&a, 2, 
                                        C_flonum(&a, r->ra),
                                        C_flonum(&a, r->dec));
                       free(r);
                       C_return(callback(lst));"))

    (define mars-earth-dist 
      (foreign-lambda double "ln_get_mars_earth_dist" double))
    (define mars-solar-dist
      (foreign-lambda double "ln_get_mars_solar_dist" double))
    (define mars-magnitude 
      (foreign-lambda double "ln_get_mars_magnitude" double))
    (define mars-disk 
      (foreign-lambda double "ln_get_mars_disk" double))
    (define mars-phase 
      (foreign-lambda double "ln_get_mars_phase" double))

    ;; returns #(X Y Z) 
    (define mars-rect-helio
        (foreign-safe-lambda* scheme-object ((double jd))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_rect_posn *r;
                       r = malloc(sizeof(struct ln_rect_posn));
                       ln_get_mars_rect_helio(jd, r);
                       a = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
                       lst = C_vector(&a, 3, 
                                        C_flonum(&a, r->X),
                                        C_flonum(&a, r->Y),
                                        C_flonum(&a, r->Z));
                       free(r);
                       C_return(callback(lst));"))

 ;;; }}}




)              


