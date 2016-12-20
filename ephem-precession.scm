;;; ephem-precession
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-precession
        (equ-prec equ-prec2 ecl-prec)

    (import chicken scheme foreign)
    (use ephem-common)
    (include "ephem-include.scm")

;;; }}}

;;; precession {{{1
    
       ;; returns equ type 
    (define (equ-prec equ jd)
        ((foreign-safe-lambda* scheme-object ((double ra) (double dec) (double jd))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_equ_posn inequ = {.ra = ra, .dec =dec};
                       struct ln_equ_posn *r;
                       r = malloc(sizeof(struct ln_equ_posn));
                       ln_get_equ_prec(&inequ, jd, r);
                       a = C_alloc(C_SIZEOF_LIST(2) + C_SIZEOF_FLONUM * 2);
                       lst = C_list(&a, 2, 
                                        C_flonum(&a, r->ra),
                                        C_flonum(&a, r->dec));
                       free(r);
                       C_return(apply_make_equ(lst));")
                       (equ-ra equ)
                       (equ-dec equ)
                       jd))

       ;; returns equ type 
    (define (equ-prec2 equ jd-from jd-to)
        ((foreign-safe-lambda* scheme-object ((double ra) (double dec) 
                                              (double fjd) (double tjd))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_equ_posn inequ = {.ra = ra, .dec =dec};
                       struct ln_equ_posn *r;
                       r = malloc(sizeof(struct ln_equ_posn));
                       ln_get_equ_prec2(&inequ, fjd, tjd, r);
                       a = C_alloc(C_SIZEOF_LIST(2) + C_SIZEOF_FLONUM * 2);
                       lst = C_list(&a, 2, 
                                        C_flonum(&a, r->ra),
                                        C_flonum(&a, r->dec));
                       free(r);
                       C_return(apply_make_equ(lst));") 
                       (equ-ra equ)
                       (equ-dec equ)
                        jd-from jd-to))


       ;; returns ecl type 
    (define (ecl-prec ecl jd)
        ((foreign-safe-lambda* scheme-object ((double lng) (double lat) (double jd))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_lnlat_posn inecl = {.lat = lat, .lng = lng};
                       struct ln_lnlat_posn *r;
                       r = malloc(sizeof(struct ln_lnlat_posn));
                       ln_get_ecl_prec(&inecl, jd, r);
                       a = C_alloc(C_SIZEOF_LIST(2) + C_SIZEOF_FLONUM * 2);
                       lst = C_list(&a, 2, 
                                        C_flonum(&a, r->lng),
                                        C_flonum(&a, r->lat));
                       free(r);
                       C_return(apply_make_equ(lst));") 
                       (ecl-lng ecl)
                       (ecl-lat ecl)
                       jd))

    ;;; }}}

)              


