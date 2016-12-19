;;; ephem-lunar
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-lunar
        ( lunar-phase lunar-disk lunar-sdiam lunar-earth-dist lunar-bright-limb 
          lunar-long-asc-node lunar-long-perigee lunar-equ-coords lunar-rst
          lunar-geo-posn lunar-equ-coords-prec lunar-ecl-coords)

    (import chicken scheme foreign)
    (use ephem-common)
    (include "ephem-include.scm")

;;; }}}

;;; Headers {{{1 
    (foreign-declare "#include <libnova/lunar.h>")
    (foreign-declare "#include <libnova/ln_types.h>")

;;; }}} 

;;; Lunar {{{1
    (define lunar-sdiam 
      (foreign-lambda double "ln_get_lunar_sdiam" double))

    ;; returns rst type
    (define (lunar-rst jd ecl-in)
        ((foreign-safe-lambda* scheme-object ((double jd) (double lng) (double lat))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_lnlat_posn in = {.lat = lat, .lng = lng};
                       struct ln_rst_time *out;
                       out = malloc(sizeof(struct ln_rst_time));
                       ln_get_lunar_rst(jd, &in, out);
                       a = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
                       lst = C_list(&a, 3, 
                                        C_flonum(&a, out->rise),
                                        C_flonum(&a, out->set),
                                        C_flonum(&a, out->transit));
                       free(out);
                       C_return(apply_make_rst(lst));")
                       jd
                       (ecl-lng ecl-in)
                       (ecl-lat ecl-in)))

    ;; returns rect type
    (define (lunar-geo-posn jd precision)
        ((foreign-safe-lambda* scheme-object ((double jd) (double precision))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_rect_posn *r;
                       r = malloc(sizeof(struct ln_rect_posn));
                       ln_get_lunar_geo_posn(jd, r, precision);
                       a = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
                       lst = C_list(&a, 3, 
                                        C_flonum(&a, r->X),
                                        C_flonum(&a, r->Y),
                                        C_flonum(&a, r->Z));
                       free(r);
                       C_return(apply_make_rect(lst));")
                       jd precision))

    ;; returns equ type
    (define (lunar-equ-coords-prec jd precision)
        ((foreign-safe-lambda* scheme-object ((double jd) (double precision))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_equ_posn *r;
                       r = malloc(sizeof(struct ln_rect_posn));
                       ln_get_lunar_equ_coords_prec(jd, r, precision);
                       a = C_alloc(C_SIZEOF_LIST(2) + C_SIZEOF_FLONUM * 2);
                       lst = C_list(&a, 2, 
                                        C_flonum(&a, r->ra),
                                        C_flonum(&a, r->dec));
                       free(r);
                       C_return(apply_make_equ(lst));")
                       jd precision))

    ;; returns equ type
    (define (lunar-equ-coords jd)
        ((foreign-safe-lambda* scheme-object ((double jd))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_equ_posn *r;
                       r = malloc(sizeof(struct ln_equ_posn));
                       ln_get_lunar_equ_coords(jd, r);
                       a = C_alloc(C_SIZEOF_LIST(2) + C_SIZEOF_FLONUM * 2);
                       lst = C_list(&a, 2, 
                                        C_flonum(&a, r->ra),
                                        C_flonum(&a, r->dec));
                       free(r);
                       C_return(apply_make_equ(lst));") jd))

    ;; returns ecl type
    (define (lunar-ecl-coords jd precision)
        ((foreign-safe-lambda* scheme-object ((double jd) (double precision))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_lnlat_posn *r;
                       r = malloc(sizeof(struct ln_equ_posn));
                       ln_get_lunar_ecl_coords(jd, r, precision);
                       a = C_alloc(C_SIZEOF_LIST(2) + C_SIZEOF_FLONUM * 2);
                       lst = C_list(&a, 2, 
                                        C_flonum(&a, r->lng),
                                        C_flonum(&a, r->lat));
                       free(r);
                       C_return(apply_make_ecl(lst));") jd precision))

   (define lunar-phase 
      (foreign-lambda double "ln_get_lunar_phase" double))
    (define lunar-disk 
      (foreign-lambda double "ln_get_lunar_disk" double))
    (define lunar-earth-dist 
      (foreign-lambda double "ln_get_lunar_earth_dist" double))
    (define lunar-bright-limb 
      (foreign-lambda double "ln_get_lunar_bright_limb" double))
    (define lunar-long-asc-node 
      (foreign-lambda double "ln_get_lunar_long_asc_node" double))
    (define lunar-long-perigee 
      (foreign-lambda double "ln_get_lunar_long_perigee" double))
;;; }}}

)              


