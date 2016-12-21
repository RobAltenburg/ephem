;;; ephem-proper-motion
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-proper-motion
        (equ-pm)

    (import chicken scheme foreign)
    (use ephem-common)
    (include "ephem-include.scm")

;;; }}}

;;; Proper Motion {{{1
    
       ;; returns equ type 
    (define (equ-pm equm equp jd)
        ((foreign-safe-lambda* scheme-object ((double ram) (double decm)
                                              (double rap) (double decp) (double jd))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_equ_posn equm = {.ra = ram, .dec =decm};
                       struct ln_equ_posn equp= {.ra = rap, .dec =decp};
                       struct ln_equ_posn *r;
                       r = malloc(sizeof(struct ln_equ_posn));
                       ln_get_equ_pm(&equm, &equp, jd, r);
                       a = C_alloc(C_SIZEOF_LIST(2) + C_SIZEOF_FLONUM * 2);
                       lst = C_list(&a, 2, 
                                        C_flonum(&a, r->ra),
                                        C_flonum(&a, r->dec));
                       free(r);
                       C_return(apply_make_equ(lst));")
                       (equ-ra equm)
                       (equ-dec equm)
                       (equ-ra equp)
                       (equ-dec equp)
                       jd))
    ;;; }}}

)              


