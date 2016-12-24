;;; Externals {{{1
    (define-external (apply_make_ecl (scheme-object obj)) scheme-object (apply make-ecl obj))
    (define-external (apply_make_ell (scheme-object obj)) scheme-object (apply make-ell obj))
    (define-external (apply_make_equ (scheme-object obj)) scheme-object (apply make-equ obj))
    (define-external (apply_make_gal (scheme-object obj)) scheme-object (apply make-gal obj))
    (define-external (apply_make_hms (scheme-object obj)) scheme-object (apply make-hms obj))
    (define-external (apply_make_helio (scheme-object obj)) scheme-object (apply make-helio obj))
    (define-external (apply_make_hrz (scheme-object obj)) scheme-object (apply make-hrz obj))
    (define-external (apply_make_nutation (scheme-object obj)) scheme-object (apply make-nutation obj))
    (define-external (apply_make_par (scheme-object obj)) scheme-object (apply make-par obj))
    (define-external (apply_make_rect (scheme-object obj)) scheme-object (apply make-rect obj))
    (define-external (apply_make_rst (scheme-object obj)) scheme-object (apply make-rst obj))
;;; }}}

;;; Declares {{{1
    (foreign-declare "#include <libnova/aberration.h>")
    (foreign-declare "#include <libnova/angular_separation.h>")
    (foreign-declare "#include <libnova/apparent_position.h>")
    (foreign-declare "#include <libnova/comet.h>")
    (foreign-declare "#include <libnova/constellation.h>")
    (foreign-declare "#include <libnova/dynamical_time.h>")
    (foreign-declare "#include <libnova/earth.h>")
    (foreign-declare "#include <libnova/elliptic_motion.h>")
    (foreign-declare "#include <libnova/hyperbolic_motion.h>")
    (foreign-declare "#include <libnova/parabolic_motion.h>")
    (foreign-declare "#include <libnova/heliocentric_time.h>")
    (foreign-declare "#include <libnova/precession.h>")
    (foreign-declare "#include <libnova/proper_motion.h>")
    (foreign-declare "#include <libnova/julian_day.h>")
    (foreign-declare "#include <libnova/jupiter.h>")
    (foreign-declare "#include <libnova/ln_types.h>")
    (foreign-declare "#include <libnova/lunar.h>")
    (foreign-declare "#include <libnova/mars.h>")
    (foreign-declare "#include <libnova/mercury.h>")
    (foreign-declare "#include <libnova/neptune.h>")
    (foreign-declare "#include <libnova/nutation.h>")
    (foreign-declare "#include <libnova/pluto.h>")
    (foreign-declare "#include <libnova/refraction.h>")
    (foreign-declare "#include <libnova/rise_set.h>")
    (foreign-declare "#include <libnova/saturn.h>")
    (foreign-declare "#include <libnova/sidereal_time.h>")
    (foreign-declare "#include <libnova/solar.h>")
    (foreign-declare "#include <libnova/transform.h>")
    (foreign-declare "#include <libnova/uranus.h>")
    (foreign-declare "#include <libnova/utility.h>")
    (foreign-declare "#include <libnova/venus.h>")
    (foreign-declare "#include <libnova/vsop87.h>")
;;; }}} 
