;; ephem-pluto
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-pluto
        ( pluto-sdiam pluto-rst pluto-helio-coords pluto-equ-coords
          pluto-earth-dist pluto-solar-dist pluto-magnitude 
          pluto-disk pluto-phase pluto-rect-helio)

    (import chicken scheme foreign)

;;; }}}

;;; Headers {{{1 
    (foreign-declare "#include <libnova/pluto.h>")
    (foreign-declare "#include <libnova/ln_types.h>")
    (define-external (callback (scheme-object obj)) scheme-object obj)

;;; }}} 

;;; pluto {{{1
    (define pluto-sdiam 
      (foreign-lambda double "ln_get_pluto_sdiam" double))

    ;; returns #(rise set transit) in jd
    (define pluto-rst
        (foreign-safe-lambda* scheme-object ((double jd) (double lng) (double lat))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_lnlat_posn in = {.lat = lat, .lng = lng};
                       struct ln_rst_time *out;
                       out = malloc(sizeof(struct ln_rst_time));
                       ln_get_pluto_rst(jd, &in, out);
                       a = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
                       lst = C_vector(&a, 3, 
                                        C_flonum(&a, out->rise),
                                        C_flonum(&a, out->set),
                                        C_flonum(&a, out->transit));
                       free(out);
                       C_return(callback(lst));"))

    ;; returns #(L B R) 
    (define pluto-helio-coords
        (foreign-safe-lambda* scheme-object ((double jd))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_helio_posn *r;
                       r = malloc(sizeof(struct ln_helio_posn));
                       ln_get_pluto_helio_coords(jd, r);
                       a = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
                       lst = C_vector(&a, 3, 
                                        C_flonum(&a, r->L),
                                        C_flonum(&a, r->B),
                                        C_flonum(&a, r->R));
                       free(r);
                       C_return(callback(lst));"))

    ;; returns #(ra dec) 
    (define pluto-equ-coords
        (foreign-safe-lambda* scheme-object ((double jd))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_equ_posn *r;
                       r = malloc(sizeof(struct ln_equ_posn));
                       ln_get_pluto_equ_coords(jd, r);
                       a = C_alloc(C_SIZEOF_LIST(2) + C_SIZEOF_FLONUM * 2);
                       lst = C_vector(&a, 2, 
                                        C_flonum(&a, r->ra),
                                        C_flonum(&a, r->dec));
                       free(r);
                       C_return(callback(lst));"))

    ;; returns #(ra dec) 
    (define pluto-equ-coords 
        (foreign-safe-lambda* scheme-object ((double jd))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_equ_posn *r;
                       r = malloc(sizeof(struct ln_equ_posn));
                       ln_get_pluto_equ_coords(jd, r);
                       a = C_alloc(C_SIZEOF_LIST(2) + C_SIZEOF_FLONUM * 2);
                       lst = C_vector(&a, 2, 
                                        C_flonum(&a, r->ra),
                                        C_flonum(&a, r->dec));
                       free(r);
                       C_return(callback(lst));"))

    (define pluto-earth-dist 
      (foreign-lambda double "ln_get_pluto_earth_dist" double))
    (define pluto-solar-dist
      (foreign-lambda double "ln_get_pluto_solar_dist" double))
    (define pluto-magnitude 
      (foreign-lambda double "ln_get_pluto_magnitude" double))
    (define pluto-disk 
      (foreign-lambda double "ln_get_pluto_disk" double))
    (define pluto-phase 
      (foreign-lambda double "ln_get_pluto_phase" double))

    ;; returns #(X Y Z) 
    (define pluto-rect-helio
        (foreign-safe-lambda* scheme-object ((double jd))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_rect_posn *r;
                       r = malloc(sizeof(struct ln_rect_posn));
                       ln_get_pluto_rect_helio(jd, r);
                       a = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
                       lst = C_vector(&a, 3, 
                                        C_flonum(&a, r->X),
                                        C_flonum(&a, r->Y),
                                        C_flonum(&a, r->Z));
                       free(r);
                       C_return(callback(lst));"))

 ;;; }}}




)              

