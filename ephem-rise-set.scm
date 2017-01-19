;;; ephem-rise-set
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-rise-set
        (object-rst object-next-rst object-next-rst-horizon
                    body-rst-horizon body-next-rst-horizon  
                    body-next-rst-horizon-future)

        (import chicken scheme foreign)
        (use ephem-common)
        (foreign-declare "#include <libnova/rise_set.h>
                         #include <libnova/mercury.h>
                         #include <libnova/venus.h>
                         #include <libnova/mars.h>
                         #include <libnova/jupiter.h>
                         #include <libnova/saturn.h>
                         #include <libnova/uranus.h>
                         #include <libnova/neptune.h>
                         #include <libnova/pluto.h>
                         #include <libnova/lunar.h>
                         #include <libnova/solar.h>")

                         ;;; }}}

                         ;;; Rise Set {{{1

                         ;; returns rst record type in jd
                         (define (object-rst jd ecl-in equ-in)
                           (let* ((rst (make-rst))
                                  (circumpolar ;; not currently returning this
                                    ((foreign-lambda double 
                                                     "ln_get_object_rst" 
                                                     double 
                                                     nonnull-c-pointer 
                                                     nonnull-c-pointer
                                                     nonnull-c-pointer) jd ecl-in equ-in rst)))
                             rst))

                         ;; returns rst record type in jd
                         (define (object-next-rst jd ecl-in equ-in)
                           (let* ((rst (make-rst))
                                  (circumpolar ;; not currently returning this
                                    ((foreign-lambda double 
                                                     "ln_get_object_next_rst" 
                                                     double 
                                                     nonnull-c-pointer 
                                                     nonnull-c-pointer
                                                     nonnull-c-pointer) jd ecl-in equ-in rst)))
                             rst))

                         ;; returns rst record type in jd
                         (define (object-next-rst-horizon jd ecl-in equ-in horizon)
                           (let* ((rst (make-rst))
                                  (circumpolar ;; not currently returning this
                                    ((foreign-lambda double 
                                                     "ln_get_object_next_rst_horizon" 
                                                     double 
                                                     nonnull-c-pointer 
                                                     nonnull-c-pointer
                                                     double
                                                     nonnull-c-pointer) 
                                     jd ecl-in equ-in horizon rst)))
                             rst))

                         ;;;}}}


                         ;;; Body Rise Set {{{1

                         (define (body-equ-pointer body)
                           (cond ((equal? body 'moon)
                                  ((foreign-lambda* nonnull-c-pointer () "C_return(&ln_get_lunar_equ_coords);")))
                                 ((equal? body 'sun)
                                  ((foreign-lambda* nonnull-c-pointer () "C_return(&ln_get_solar_equ_coords);")))
                                 ((equal? body 'mercury)
                                  ((foreign-lambda* nonnull-c-pointer () "C_return(&ln_get_mercury_equ_coords);")))
                                 ((equal? body 'venus)
                                  ((foreign-lambda* nonnull-c-pointer () "C_return(&ln_get_venus_equ_coords);")))
                                 ((equal? body 'mars)
                                  ((foreign-lambda* nonnull-c-pointer () "C_return(&ln_get_mars_equ_coords);")))
                                 ((equal? body 'jupiter)
                                  ((foreign-lambda* nonnull-c-pointer () "C_return(&ln_get_jupiter_equ_coords);")))
                                 ((equal? body 'saturn)
                                  ((foreign-lambda* nonnull-c-pointer () "C_return(&ln_get_saturn_equ_coords);")))
                                 ((equal? body 'uranus)
                                  ((foreign-lambda* nonnull-c-pointer () "C_return(&ln_get_uranus_equ_coords);")))
                                 ((equal? body 'neptune)
                                  ((foreign-lambda* nonnull-c-pointer () "C_return(&ln_get_neptune_equ_coords);")))
                                 ((equal? body 'pluto)
                                  ((foreign-lambda* nonnull-c-pointer () "C_return(&ln_get_pluto_equ_coords);")))))

                         ;; note that "body" us a symbol
                         ;; returns rst record type in jd
                         (define (body-rst-horizon jd ecl-in body horizon)
                           (let* ((rst (make-rst))
                                  (circumpolar ;; not currently returning this
                                    ((foreign-lambda double 
                                                     "ln_get_body_rst_horizon" 
                                                     double 
                                                     nonnull-c-pointer 
                                                     nonnull-c-pointer
                                                     double
                                                     nonnull-c-pointer) 
                                     jd ecl-in (body-equ-pointer body) horizon rst)))
                             rst))

                         ;; note that "body" us a symbol
                         ;; returns rst record type in jd
                         (define (body-next-rst-horizon jd ecl-in body horizon)
                           (let* ((rst (make-rst))
                                  (circumpolar ;; not currently returning this
                                    ((foreign-lambda double 
                                                     "ln_get_body_next_rst_horizon" 
                                                     double 
                                                     nonnull-c-pointer 
                                                     nonnull-c-pointer
                                                     double
                                                     nonnull-c-pointer) 
                                     jd ecl-in (body-equ-pointer body) horizon rst)))
                             rst))

                         ;; note that "body" us a symbol
                         ;; returns rst record type in jd
                         (define (body-next-rst-horizon-future jd ecl-in body horizon day-limit)
                           (let* ((rst (make-rst))
                                  (circumpolar ;; not currently returning this
                                    ((foreign-lambda double 
                                                     "ln_get_body_next_rst_horizon_future" 
                                                     double 
                                                     nonnull-c-pointer 
                                                     nonnull-c-pointer
                                                     double
                                                     double
                                                     nonnull-c-pointer) 
                                     jd ecl-in (body-equ-pointer body) horizon day-limit rst)))
                             rst))


                         ;;; }}}

                         )



