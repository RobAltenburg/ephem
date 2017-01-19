;;; ephem-constellation
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-constellation
        (constellation) 

        (import chicken scheme foreign)
        (use ephem-common)
        (foreign-declare "#include <libnova/ln_types.h>
                          #include <libnova/constellation.h>")
        ;;; }}}

        ;;; Constellation {{{1

        ;; returns 
        (define constellation 
          (foreign-lambda nonnull-c-string "ln_get_constellation" nonnull-c-pointer))


        ;; }}}

        )              


