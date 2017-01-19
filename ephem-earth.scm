;;; ephem-earth
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-earth
        (earth-helio-coords earth-solar-dist earth-rect-helio earth-centre-dist)

    (import chicken scheme foreign)
    (use ephem-common)
    (foreign-declare "#include <libnova/earth.h>")
;;; }}}

;;; earth {{{1
    
    ;; returns helio type
    (define (earth-helio-coords jd)
      (let ((helio (make-helio)))
        ((foreign-lambda void "ln_get_earth_helio_coords" 
                         double
                         nonnull-c-pointer)
         jd helio)
        helio))

    (define earth-solar-dist
      (foreign-lambda double "ln_get_earth_solar_dist" double))

    ;; returns rect type
    (define (earth-rect-helio jd)
      (let ((rect (make-rect)))
            ((foreign-lambda void "ln_get_earth_rect_helio"
                             double
                             nonnull-c-pointer)
             jd rect)
            rect))

    (define (earth-centre-dist height latitude)
               ((foreign-safe-lambda* scheme-object ((double height) (double latitude))
                       "C_word vec = C_SCHEME_END_OF_LIST, *a;
                        double p_sin_o, p_cos_o;
                        ln_get_earth_centre_dist (height, latitude, &p_sin_o, &p_cos_o);
                        a = C_alloc(C_SIZEOF_LIST(2) + C_SIZEOF_FLONUM * 2);
                        vec = C_vector(&a, 2, 
                                        C_flonum(&a, p_sin_o),
                                        C_flonum(&a, p_cos_o));
                        C_return(vec);") height latitude))
 ;;; }}}

)              


