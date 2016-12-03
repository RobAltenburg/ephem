;;; ephem-julian-day
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-julian-day
        (get-date)

    (import chicken scheme foreign srfi-19)
    (use srfi-19 ephem-common)

;;; }}}

;;; Headers {{{1 
    (foreign-declare "#include <libnova/ln_types.h>")
    (foreign-declare "#include <libnova/julian_day.h>")
    (define-external (callback (scheme-object obj)) scheme-object obj)
;;; }}} 

;;; Julian Day {{{1

    ;; returns #(yyyy mm dd hh mm ss)
    (define _get-date 
        (foreign-safe-lambda* scheme-object ((double jd))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_date *out;
                       out = malloc(sizeof(struct ln_date));
                       ln_get_date(jd, out);
                       a = C_alloc(C_SIZEOF_LIST(6) + C_SIZEOF_FLONUM + 5);
                       lst = C_vector(&a, 6, 
                                        C_fix(out->years),
                                        C_fix(out->months),
                                        C_fix(out->days),
                                        C_fix(out->hours),
                                        C_fix(out->minutes),
                                        C_fix((int)out->seconds));
                                        /* This should be C_flonum(&a, out->seconds));
                                           but srfi-19 complains, when it isn't a fixnum*/
                       free(out);
                       C_return(callback(lst));"))


;; returns a srfi-19 date object 
    (define (get-date jd)
        (let* ((r (_get-date jd)))
             (make-date 0 (vector-ref r 5) (vector-ref r 4) (vector-ref r 3)
                        (vector-ref r 2) (vector-ref r 1) (vector-ref r 0) 0 #f)))



;}}}

)




