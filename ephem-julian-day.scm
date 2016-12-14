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
    (use srfi-19)

;;; }}}

;;; Headers {{{1 
    (foreign-declare "#include <libnova/ln_types.h>")
    (foreign-declare "#include <libnova/julian_day.h>")
    (define-external (callback (scheme-object obj)) scheme-object obj)
;;; }}} 

;;; Julian Day {{{1
    ;; returns a srfi-19 date object 
    (define (get-date jd)
      (apply 
        (lambda (yy mm dd hh mm ss)
              (let* ((sec (truncate ss))
                     (ns (truncate (* 1000000 (- ss sec)))))
                     (make-date ns sec mm hh dd mm yy 0 #f)))

        (foreign-safe-lambda* scheme-object ((double jd))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_date *out;
                       out = malloc(sizeof(struct ln_date));
                       ln_get_date(jd, out);
                       a = C_alloc(C_SIZEOF_LIST(6) + C_SIZEOF_FLONUM + 5);
                       lst = C_list(&a, 6, 
                                        C_fix(out->years),
                                        C_fix(out->months),
                                        C_fix(out->days),
                                        C_fix(out->hours),
                                        C_fix(out->minutes),
                                        C_flonum(&a, out->seconds));
                       free(out);
                       C_return(callback(lst));")))


;}}}

)




