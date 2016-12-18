;;; ephem-comet
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-comet
        (ell-comet-mag par-comet-mag)

    (import chicken scheme foreign)
    (use ephem-common)

;;; }}}

;;; Headers {{{1 
    (foreign-declare "#include <libnova/comet.h>")
    (foreign-declare "#include <libnova/ln_types.h>")

;;; }}} 

;;; Comet {{{1

    ;; returns double
    (define (ell-comet-mag jd ell-in g k)
        ((foreign-lambda* double ((double jd) (double a) (double e) (double i) (double w)
                                  (double omega) (double n) (double jde) (double g) (double k))
                       "struct ln_ell_orbit in = {.a = a, .e = e, .i = i, .w = w,
                                                .omega = omega, .n = n, .JD = jde};
                       C_return(ln_get_ell_comet_mag(jd, &in, g, k));")
                       jd
                       (ell-a ell-in)
                       (ell-e ell-in)
                       (ell-i ell-in)
                       (ell-w ell-in)
                       (ell-omega ell-in)
                       (ell-n ell-in)
                       (ell-jd ell-in)
                       g
                       k))
    ;; returns double
    (define (par-comet-mag jd par-in g k)
        ((foreign-lambda* double ((double jd) (double q) (double i) (double w)
                                  (double omega) (double jde) (double g) (double k))
                       "struct ln_par_orbit in = {.q = q, .i = i, .w = w, .omega = omega, .JD = jde};
                       C_return(ln_get_par_comet_mag(jd, &in, g, k));")
                       jd
                       (par-q par-in)
                       (par-i par-in)
                       (par-w par-in)
                       (par-omega par-in)
                       (par-jd par-in)
                       g
                       k))
                       
;; }}}

)              


