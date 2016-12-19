;;; ephem-nutation
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-nutation
        (nutation)

    (import chicken scheme foreign)
    (use ephem-common)
    (include "ephem-include.scm")

;;; }}}

;;; nutation {{{1

    ;; returns nutation type
    (define (nutation jd)
        ((foreign-safe-lambda* scheme-object ((double jd))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_nutation *out;
                       out = malloc(sizeof(struct ln_nutation));
                       ln_get_nutation(jd, out);
                       a = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
                       lst = C_list(&a, 3, 
                                        C_flonum(&a, out->longitude),
                                        C_flonum(&a, out->obliquity),
                                        C_flonum(&a, out->ecliptic));
                       free(out);
                       C_return(apply_make_nutation(lst));")
                       jd))
                       
;; }}}

)              


