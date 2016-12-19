;;; ephem-aberration
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-aberration
        (equ-aberration ecl-aberration)

    (import chicken scheme foreign)
    (use ephem-common)
    (include "ephem-include.scm")


;;; }}}

;;; Aberration {{{1

    ;; returns equ type
    (define (equ-aberration equ-in jd)
        ((foreign-safe-lambda* scheme-object ((double ra) (double dec) (double jd))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_equ_posn in = {.ra = ra, .dec = dec};
                       struct ln_equ_posn *out;
                       out = malloc(sizeof(struct ln_equ_posn));
                       ln_get_equ_aber(&in, jd, out);
                       a = C_alloc(C_SIZEOF_LIST(2) + C_SIZEOF_FLONUM * 2);
                       lst = C_list(&a, 2, 
                                        C_flonum(&a, out->ra),
                                        C_flonum(&a, out->dec));
                       free(out);
                       C_return(apply_make_equ(lst));")
                       (equ-ra equ-in)
                       (equ-dec equ-in)
                       jd))
                       

     (define (ecl-aberration ecl-in jd)
        ((foreign-safe-lambda* scheme-object ((double lng) (double lat) (double jd))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_lnlat_posn in = {.lng = lng, .lat = lat};
                       struct ln_lnlat_posn *out;
                       out = malloc(sizeof(struct ln_lnlat_posn));
                       ln_get_ecl_aber(&in, jd, out);
                       a = C_alloc(C_SIZEOF_LIST(2) + C_SIZEOF_FLONUM * 2);
                       lst = C_list(&a, 2, 
                                        C_flonum(&a, out->lng),
                                        C_flonum(&a, out->lat));
                       free(out);
                       C_return(apply_make_ecl(lst));")
                       (ecl-lng ecl-in)
                       (ecl-lat ecl-in)
                       jd))
                       
;; }}}

)              


