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
    (foreign-declare "#include <libnova/comet.h>")
;;; }}}

;;; Comet {{{1

    ;; returns double
    ; takes jd ell-in g k)
    (define ell-comet-mag 
      (foreign-lambda double "ln_get_ell_comet_mag"
                       double
                       nonnull-c-pointer
                       double
                       double))

    ;; returns double
    ;; takes jd par-in g k
    (define par-comet-mag 
        (foreign-lambda double "ln_get_par_comet_mag"
                        double
                        nonnull-c-pointer
                        double
                        double))
;; }}}

)              


