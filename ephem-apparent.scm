;;; ephem-apparent
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-apparent
        (apparent-posn)

    (import chicken scheme foreign)
    (use ephem-common)
    (include "ephem-include.scm")

;;; }}}

;;; Headers {{{1 
    (foreign-declare "#include <libnova/apparent_position.h>")
    (foreign-declare "#include <libnova/ln_types.h>")

;;; }}} 

;;; Apparent {{{1

    ;; returns equ type
    (define (apparent-posn equ-in proper-in jd)
        ((foreign-safe-lambda* scheme-object ((double ra) (double dec) (double pra) (double pdec) (double jd))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_equ_posn in = {.ra = ra, .dec = dec};
                       struct ln_equ_posn pin = {.ra = pra, .dec = pdec};
                       struct ln_equ_posn *out;
                       out = malloc(sizeof(struct ln_equ_posn));
                       ln_get_apparent_posn(&in, &pin, jd, out);
                       a = C_alloc(C_SIZEOF_LIST(2) + C_SIZEOF_FLONUM * 2);
                       lst = C_list(&a, 2, 
                                        C_flonum(&a, out->ra),
                                        C_flonum(&a, out->dec));
                       free(out);
                       C_return(apply_make_equ(lst));")
                       (equ-ra equ-in)
                       (equ-dec equ-in)
                       (equ-ra proper-in)
                       (equ-dec proper-in)
                       jd))
                       
;; }}}

)              


