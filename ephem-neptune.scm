;;; ephem-neptune
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-neptune
        ( neptune-sdiam neptune-rst neptune-helio-coords neptune-equ-coords
          neptune-earth-dist neptune-solar-dist neptune-magnitude 
          neptune-disk neptune-phase neptune-rect-helio)

    (import chicken scheme foreign)
    (use ephem-common)
    (include "ephem-include.scm")

;;; }}}

;;; neptune {{{1
    (define neptune-sdiam 
      (foreign-lambda double "ln_get_neptune_sdiam" double))
    
    ;; returns rst type 
    (define (neptune-rst jd ecl-in)
        ((foreign-safe-lambda* scheme-object ((double jd) (double lng) (double lat))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_lnlat_posn in = {.lat = lat, .lng = lng};
                       struct ln_rst_time *out;
                       out = malloc(sizeof(struct ln_rst_time));
                       ln_get_neptune_rst(jd, &in, out);
                       a = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
                       lst = C_list(&a, 3, 
                                        C_flonum(&a, out->rise),
                                        C_flonum(&a, out->set),
                                        C_flonum(&a, out->transit));
                       free(out);
                       C_return(apply_make_rst(lst));")
                       jd
                       (ecl-lng ecl-in)
                       (ecl-lat ecl-in)))

    ;; returns helio type
    (define (neptune-helio-coords jd)
        ((foreign-safe-lambda* scheme-object ((double jd))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_helio_posn *r;
                       r = malloc(sizeof(struct ln_helio_posn));
                       ln_get_neptune_helio_coords(jd, r);
                       a = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
                       lst = C_list(&a, 3, 
                                        C_flonum(&a, r->L),
                                        C_flonum(&a, r->B),
                                        C_flonum(&a, r->R));
                       free(r);
                       C_return(apply_make_helio(lst));") jd))

    ;; returns equ type 
    (define (neptune-equ-coords jd)
        ((foreign-safe-lambda* scheme-object ((double jd))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_equ_posn *r;
                       r = malloc(sizeof(struct ln_equ_posn));
                       ln_get_neptune_equ_coords(jd, r);
                       a = C_alloc(C_SIZEOF_LIST(2) + C_SIZEOF_FLONUM * 2);
                       lst = C_list(&a, 2, 
                                        C_flonum(&a, r->ra),
                                        C_flonum(&a, r->dec));
                       free(r);
                       C_return(apply_make_equ(lst));") jd))

    ;; returns equ type
    (define (neptune-equ-coords jd)
        ((foreign-safe-lambda* scheme-object ((double jd))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_equ_posn *r;
                       r = malloc(sizeof(struct ln_equ_posn));
                       ln_get_neptune_equ_coords(jd, r);
                       a = C_alloc(C_SIZEOF_LIST(2) + C_SIZEOF_FLONUM * 2);
                       lst = C_list(&a, 2, 
                                        C_flonum(&a, r->ra),
                                        C_flonum(&a, r->dec));
                       free(r);
                       C_return(apply_make_equ(lst));") jd))

    (define neptune-earth-dist 
      (foreign-lambda double "ln_get_neptune_earth_dist" double))
    (define neptune-solar-dist
      (foreign-lambda double "ln_get_neptune_solar_dist" double))
    (define neptune-magnitude 
      (foreign-lambda double "ln_get_neptune_magnitude" double))
    (define neptune-disk 
      (foreign-lambda double "ln_get_neptune_disk" double))
    (define neptune-phase 
      (foreign-lambda double "ln_get_neptune_phase" double))

    ;; returns rect type
    (define (neptune-rect-helio jd)
        ((foreign-safe-lambda* scheme-object ((double jd))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_rect_posn *r;
                       r = malloc(sizeof(struct ln_rect_posn));
                       ln_get_neptune_rect_helio(jd, r);
                       a = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
                       lst = C_list(&a, 3, 
                                        C_flonum(&a, r->X),
                                        C_flonum(&a, r->Y),
                                        C_flonum(&a, r->Z));
                       free(r);
                       C_return(apply_make_rect(lst));") jd))

 ;;; }}}

)              


