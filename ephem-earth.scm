;;; ephem-earth
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-earth
        (earth-helio-coords earth-solar-dist earth-rect-helio earth-centre-dist)

    (import chicken scheme foreign)
    (use ephem-common)
    (include "ephem-include.scm")

;;; }}}

;;; earth {{{1
    
    ;; returns helio type
    (define (earth-helio-coords jd)
        ((foreign-safe-lambda* scheme-object ((double jd))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_helio_posn *r;
                       r = malloc(sizeof(struct ln_helio_posn));
                       ln_get_earth_helio_coords(jd, r);
                       a = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
                       lst = C_list(&a, 3, 
                                        C_flonum(&a, r->L),
                                        C_flonum(&a, r->B),
                                        C_flonum(&a, r->R));
                       free(r);
                       C_return(apply_make_helio(lst));") jd))

    (define earth-solar-dist
      (foreign-lambda double "ln_get_earth_solar_dist" double))

    ;; returns rect type
    (define (earth-rect-helio jd)
        ((foreign-safe-lambda* scheme-object ((double jd))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_rect_posn *r;
                       r = malloc(sizeof(struct ln_rect_posn));
                       ln_get_earth_rect_helio(jd, r);
                       a = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
                       lst = C_list(&a, 3, 
                                        C_flonum(&a, r->X),
                                        C_flonum(&a, r->Y),
                                        C_flonum(&a, r->Z));
                       free(r);
                       C_return(apply_make_rect(lst));") jd))

     (define (earth-centre-dist height latitude)
               ((foreign-safe-lambda* scheme-object ((double height) (double latitude))
                       "C_word vec = C_SCHEME_END_OF_LIST, *a;
                        double p_sin_o, p_cos_o;
                        ln_get_earth_centre_dist (height, latitude, &p_sin_o, &p_cos_o);
                        a = C_alloc(C_SIZEOF_LIST(2) + C_SIZEOF_FLONUM * 2);
                        vec = C_vector(&a, 2, 
                                        C_flonum(&a, p_sin_o),
                                        C_flonum(&a, p_cos_o));
                        C_return(apply_make_equ(vec));") height latitude))
 ;;; }}}

)              


