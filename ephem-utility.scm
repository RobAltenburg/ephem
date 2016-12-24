;;; ephem-utility
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-utility
        (get-version vsop87->fk5
          rad->deg deg->rad hms->deg deg->hms hms->rad)

    (import chicken scheme foreign)
    (use ephem-common)
    (include "ephem-include.scm")


;;; }}}

;;; Utility {{{1
    (define (get-version) 
        (foreign-lambda nonnull-c-string "ln_get_version")) 
;;; }}}

;;; VSOP87 Theory {{{1
    (define (vsop87->fk5 helio-in jd)
      ((foreign-safe-lambda* scheme-object ((double L) (double B) (double R) (double jd))
                       "C_word lst = C_SCHEME_END_OF_LIST, *al;
                        struct ln_helio_posn pos = {.L = L, .B = B, .R = R};
                        ln_vsop87_to_fk5(&pos, jd); // mutates pos
                        lst = C_list(&al, 3, 
                                        C_flonum(&al, pos.L),
                                        C_flonum(&al, pos.B),
                                        C_flonum(&al, pos.R));
                       C_return(apply_make_helio(lst));")
                       (helio-l helio-in)
                       (helio-b helio-in)
                       (helio-r helio-in)
                       jd))


;;; }}}

;;; General Conversion {{{1
    (define (rad->deg rad) 
        (foreign-lambda double "ln_rad_to_deg" double)) 

    (define (deg->rad deg) 
        (foreign-lambda double "ln_deg_to_rad" double)) 

    (define (hms->deg hours minutes seconds) 
        ((foreign-lambda* double ((double hours) (double minutes) (double seconds))
                        "struct ln_hms hms = {.hours = hours, .minutes = minutes, .seconds = seconds};
                         C_return(ln_hms_to_deg(&hms));")
                         hours
                         minutes
                         seconds))

    (define (deg->hms degrees) 
        ((foreign-safe-lambda* scheme-object ((double degrees))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_hms *out;
                       out = malloc(sizeof(struct ln_hms));
                       ln_deg_to_hms(degrees, out);
                       a = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
                       lst = C_list(&a, 3, 
                                        C_flonum(&a, out->hours),
                                        C_flonum(&a, out->minutes),
                                        C_flonum(&a, out->seconds));
                       free(out);
                       C_return(apply_make_hms(lst));")
                         degrees))

    (define (hms->rad hours minutes seconds) 
        ((foreign-lambda* double ((double hours) (double minutes) (double seconds))
                        "struct ln_hms hms = {.hours = hours, .minutes = minutes, .seconds = seconds};
                         C_return(ln_hms_to_rad(&hms));")
                         hours
                         minutes
                         seconds))

 

;;; }}}
)              


