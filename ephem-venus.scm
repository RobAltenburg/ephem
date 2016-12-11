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
    (use ephem-common)

;;; }}}

;;; Headers {{{1 
    (foreign-declare "#include <libnova/venus.h>")
    (foreign-declare "#include <libnova/ln_types.h>")
    (define-external (callback (scheme-object obj)) scheme-object obj)

;;; }}} 

;;; venus {{{1
    (define venus-sdiam 
      (foreign-lambda double "ln_get_venus_sdiam" double))
    
    ;; returns rst type 
    (define (venus-rst jd ecl-in)
      (apply make-rst
        ((foreign-safe-lambda* scheme-object ((double jd) (double lng) (double lat))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_lnlat_posn in = {.lat = lat, .lng = lng};
                       struct ln_rst_time *out;
                       out = malloc(sizeof(struct ln_rst_time));
                       ln_get_venus_rst(jd, &in, out);
                       a = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
                       lst = C_list(&a, 3, 
                                        C_flonum(&a, out->rise),
                                        C_flonum(&a, out->set),
                                        C_flonum(&a, out->transit));
                       free(out);
                       C_return(callback(lst));")
                       jd
                       (ecl-lng ecl-in)
                       (ecl-lat ecl-in))))

    ;; returns helio type
    (define (venus-helio-coords jd)
      (apply make-helio
        ((foreign-safe-lambda* scheme-object ((double jd))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_helio_posn *r;
                       r = malloc(sizeof(struct ln_helio_posn));
                       ln_get_venus_helio_coords(jd, r);
                       a = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
                       lst = C_list(&a, 3, 
                                        C_flonum(&a, r->L),
                                        C_flonum(&a, r->B),
                                        C_flonum(&a, r->R));
                       free(r);
                       C_return(callback(lst));") jd)))

    ;; returns equ type 
    (define (venus-equ-coords jd)
      (apply make-equ
        ((foreign-safe-lambda* scheme-object ((double jd))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_equ_posn *r;
                       r = malloc(sizeof(struct ln_equ_posn));
                       ln_get_venus_equ_coords(jd, r);
                       a = C_alloc(C_SIZEOF_LIST(2) + C_SIZEOF_FLONUM * 2);
                       lst = C_list(&a, 2, 
                                        C_flonum(&a, r->ra),
                                        C_flonum(&a, r->dec));
                       free(r);
                       C_return(callback(lst));") jd)))

    ;; returns equ type
    (define (venus-equ-coords jd)
      (apply make-equ
        ((foreign-safe-lambda* scheme-object ((double jd))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_equ_posn *r;
                       r = malloc(sizeof(struct ln_equ_posn));
                       ln_get_venus_equ_coords(jd, r);
                       a = C_alloc(C_SIZEOF_LIST(2) + C_SIZEOF_FLONUM * 2);
                       lst = C_list(&a, 2, 
                                        C_flonum(&a, r->ra),
                                        C_flonum(&a, r->dec));
                       free(r);
                       C_return(callback(lst));") jd)))

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

    ;; returns rect type
    (define (venus-rect-helio jd)
      (apply make-rect
        ((foreign-safe-lambda* scheme-object ((double jd))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_rect_posn *r;
                       r = malloc(sizeof(struct ln_rect_posn));
                       ln_get_venus_rect_helio(jd, r);
                       a = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
                       lst = C_list(&a, 3, 
                                        C_flonum(&a, r->X),
                                        C_flonum(&a, r->Y),
                                        C_flonum(&a, r->Z));
                       free(r);
                       C_return(callback(lst));") jd)))

 ;;; }}}

)              


