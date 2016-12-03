;;; ephem-venus
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-venus
        ( venus-sdiam venus-rst venus-helio-coords venus-equ-coords
          venus-earth-dist venus-solar-dist venus-magnitude 
          venus-disk venus-phase venus-rect-helio)

    (import chicken scheme foreign)

;;; }}}

;;; Headers {{{1 
    (foreign-declare "#include <libnova/venus.h>")
    (foreign-declare "#include <libnova/ln_types.h>")
    (define-external (callback (scheme-object obj)) scheme-object obj)

;;; }}} 

;;; venus {{{1
    (define venus-sdiam 
      (foreign-lambda double "ln_get_venus_sdiam" double))

    ;; returns #(rise set transit) in jd
    (define venus-rst
        (foreign-safe-lambda* scheme-object ((double jd) (double lng) (double lat))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_lnlat_posn in = {.lat = lat, .lng = lng};
                       struct ln_rst_time *out;
                       out = malloc(sizeof(struct ln_rst_time));
                       ln_get_venus_rst(jd, &in, out);
                       a = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
                       lst = C_vector(&a, 3, 
                                        C_flonum(&a, out->rise),
                                        C_flonum(&a, out->set),
                                        C_flonum(&a, out->transit));
                       free(out);
                       C_return(callback(lst));"))

    ;; returns #(L B R) 
    (define venus-helio-coords
        (foreign-safe-lambda* scheme-object ((double jd))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_helio_posn *r;
                       r = malloc(sizeof(struct ln_helio_posn));
                       ln_get_venus_helio_coords(jd, r);
                       a = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
                       lst = C_vector(&a, 3, 
                                        C_flonum(&a, r->L),
                                        C_flonum(&a, r->B),
                                        C_flonum(&a, r->R));
                       free(r);
                       C_return(callback(lst));"))

    ;; returns #(ra dec) 
    (define venus-equ-coords
        (foreign-safe-lambda* scheme-object ((double jd))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_equ_posn *r;
                       r = malloc(sizeof(struct ln_equ_posn));
                       ln_get_venus_equ_coords(jd, r);
                       a = C_alloc(C_SIZEOF_LIST(2) + C_SIZEOF_FLONUM * 2);
                       lst = C_vector(&a, 2, 
                                        C_flonum(&a, r->ra),
                                        C_flonum(&a, r->dec));
                       free(r);
                       C_return(callback(lst));"))

    ;; returns #(ra dec) 
    (define venus-equ-coords 
        (foreign-safe-lambda* scheme-object ((double jd))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_equ_posn *r;
                       r = malloc(sizeof(struct ln_equ_posn));
                       ln_get_venus_equ_coords(jd, r);
                       a = C_alloc(C_SIZEOF_LIST(2) + C_SIZEOF_FLONUM * 2);
                       lst = C_vector(&a, 2, 
                                        C_flonum(&a, r->ra),
                                        C_flonum(&a, r->dec));
                       free(r);
                       C_return(callback(lst));"))

    (define venus-earth-dist 
      (foreign-lambda double "ln_get_venus_earth_dist" double))
    (define venus-solar-dist
      (foreign-lambda double "ln_get_venus_solar_dist" double))
    (define venus-magnitude 
      (foreign-lambda double "ln_get_venus_magnitude" double))
    (define venus-disk 
      (foreign-lambda double "ln_get_venus_disk" double))
    (define venus-phase 
      (foreign-lambda double "ln_get_venus_phase" double))

    ;; returns #(X Y Z) 
    (define venus-rect-helio
        (foreign-safe-lambda* scheme-object ((double jd))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_rect_posn *r;
                       r = malloc(sizeof(struct ln_rect_posn));
                       ln_get_venus_rect_helio(jd, r);
                       a = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
                       lst = C_vector(&a, 3, 
                                        C_flonum(&a, r->X),
                                        C_flonum(&a, r->Y),
                                        C_flonum(&a, r->Z));
                       free(r);
                       C_return(callback(lst));"))

 ;;; }}}




)              


