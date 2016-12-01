;;; ephem
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem 
        (gmst gast
          lunar-phase lunar-disk lunar-sdiam lunar-earth-dist lunar-bright-limb 
          lunar-long-asc-node lunar-long-perigee lunar-equ-coords lunar-rst
          lunar-geo-posn lunar-equ-coords-prec lunar-ecl-coords
          solar-rst-horizon solar-rst solar-geom-coords solar-equ-coords 
          solar-ecl-coords solar-geo-coords solar-sdiam
          object-rst get-date)

    (import chicken scheme foreign 
            ephem-sidereal ephem-lunar ephem-solar ephem-rise-set
            ephem-julian-day)

    (use ephem-sidereal ephem-lunar ephem-solar ephem-rise-set ephem-julian-day)

;;; }}}

;;; Headers {{{1 
    (foreign-declare "#include <libnova/sidereal_time.h>")
    (foreign-declare "#include <libnova/lunar.h>")
    (foreign-declare "#include <libnova/solar.h>")
    (foreign-declare "#include <libnova/rise_set.h>")
    (foreign-declare "#include <libnova/julian_day.h>")
    (foreign-declare "#include <libnova/ln_types.h>")
;;; }}} 

)              


