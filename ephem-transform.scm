;;; ephem-transform
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-transform
        (hrz-from-equ hrz-from-equ-sidereal-time equ-from-ecl ecl-from-equ rect-from-helio 
         ecl-from-rect equ-from-gal equ2000-from-gal gal-from-equ gal-from-equ2000)

    (import chicken scheme foreign)

;;; }}}

;;; Headers {{{1 
    (foreign-declare "#include <libnova/ln_types.h>")
    (foreign-declare "#include <libnova/transform.h>")
    (define-external (callback (scheme-object obj)) scheme-object obj)
;;; }}} 

;;; Transform {{{1

    ;; returns #(az alt)
    ;;void LIBNOVA_EXPORT ln_get_hrz_from_equ(struct ln_equ_posn *object,
    ;;	struct ln_lnlat_posn *observer, double JD, struct ln_hrz_posn *position);
    (define hrz-from-equ
      (foreign-safe-lambda* scheme-object ((double ra) (double dec) (double lng) (double lat) (double jd))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_lnlat_posn inll = {.lat = lat, .lng =lng};
                       struct ln_equ_posn inequ = {.ra = ra, .dec =dec};
                       struct ln_hrz_posn *out;
                       out = malloc(sizeof(struct ln_hrz_posn));
                       ln_get_hrz_from_equ(&inequ, &inll, jd, out);
                       a = C_alloc(C_SIZEOF_LIST(2) + C_SIZEOF_FLONUM * 2);
                       lst = C_vector(&a, 2, 
                                        C_flonum(&a, out->az),
                                        C_flonum(&a, out->alt));
                       free(out);
                       C_return(callback(lst));"))

                       
    ;; returns #(az alt)
    ;;void LIBNOVA_EXPORT ln_get_hrz_from_equ_sidereal_time(struct ln_equ_posn *object,
    ;;    struct ln_lnlat_posn *observer, double sidereal,
    ;;    struct ln_hrz_posn *position);
    (define hrz-from-equ-sidereal-time
      (foreign-safe-lambda* scheme-object ((double ra) (double dec) (double lng) (double lat) (double sidereal))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_lnlat_posn inll = {.lat = lat, .lng =lng};
                       struct ln_equ_posn inequ = {.ra = ra, .dec =dec};
                       struct ln_hrz_posn *out;
                       out = malloc(sizeof(struct ln_hrz_posn));
                       ln_get_hrz_from_equ_sidereal_time(&inequ, &inll, sidereal, out);
                       a = C_alloc(C_SIZEOF_LIST(2) + C_SIZEOF_FLONUM * 2);
                       lst = C_vector(&a, 2, 
                                        C_flonum(&a, out->az),
                                        C_flonum(&a, out->alt));
                       free(out);
                       C_return(callback(lst));"))



    ;; returns #(ra dec) 
    ;;void LIBNOVA_EXPORT ln_get_equ_from_ecl(struct ln_lnlat_posn *object,
    ;;	double JD, struct ln_equ_posn *position);
    (define equ-from-ecl
      (foreign-safe-lambda* scheme-object ((double lng) (double lat) (double jd))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_lnlat_posn inll = {.lat = lat, .lng =lng};
                       struct ln_equ_posn *out;
                       out = malloc(sizeof(struct ln_equ_posn));
                       ln_get_equ_from_ecl(&inll, jd, out);
                       a = C_alloc(C_SIZEOF_LIST(2) + C_SIZEOF_FLONUM * 2);
                       lst = C_vector(&a, 2, 
                                        C_flonum(&a, out->ra),
                                        C_flonum(&a, out->dec));
                       free(out);
                       C_return(callback(lst));"))


    ;; returns #(lng lat) 
    ;;ln_get_ecl_from_equ(struct ln_equ_posn *object, double JD,
    ;;	struct ln_lnlat_posn *position);
    (define ecl-from-equ
      (foreign-safe-lambda* scheme-object ((double ra) (double dec) (double jd))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_equ_posn in = {.ra = ra, .dec =dec};
                       struct ln_lnlat_posn *out;
                       out = malloc(sizeof(struct ln_lnlat_posn));
                       ln_get_ecl_from_equ(&in, jd, out);
                       a = C_alloc(C_SIZEOF_LIST(2) + C_SIZEOF_FLONUM * 2);
                       lst = C_vector(&a, 2, 
                                        C_flonum(&a, out->lng),
                                        C_flonum(&a, out->lat));
                       free(out);
                       C_return(callback(lst));"))


                       
    ;; returns #(x y z) 
    ;;void LIBNOVA_EXPORT ln_get_rect_from_helio(struct ln_helio_posn *object,
    ;;	struct ln_rect_posn *position);
    (define rect-from-helio
      (foreign-safe-lambda* scheme-object ((double L) (double B) (double R))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_helio_posn in = {.L = L, .B = B, .R = R};
                       struct ln_rect_posn *out;
                       out = malloc(sizeof(struct ln_rect_posn));
                       ln_get_rect_from_helio(&in, out);
                       a = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
                       lst = C_vector(&a, 3, 
                                        C_flonum(&a, out->X),
                                        C_flonum(&a, out->Y),
                                        C_flonum(&a, out->Z));
                       free(out);
                       C_return(callback(lst));"))


    ;; returns #(L B R) 
    ;;void LIBNOVA_EXPORT ln_get_ecl_from_rect(struct ln_rect_posn *rect,
    ;;	struct ln_lnlat_posn *posn);
    (define ecl-from-rect
      (foreign-safe-lambda* scheme-object ((double X) (double Y) (double Z))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_rect_posn in = {.X = X, .Y = Y, .Z = Z};
                       struct ln_lnlat_posn *out;
                       out = malloc(sizeof(struct ln_lnlat_posn));
                       ln_get_ecl_from_rect(&in, out);
                       a = C_alloc(C_SIZEOF_LIST(3) + C_SIZEOF_FLONUM * 3);
                       lst = C_vector(&a, 2, 
                                        C_flonum(&a, out->lng),
                                        C_flonum(&a, out->lat));
                       free(out);
                       C_return(callback(lst));"))

  
    ;; returns #(ra dec) 
    ;;void LIBNOVA_EXPORT ln_get_equ_from_gal(struct ln_gal_posn *gal,
    ;;	struct ln_equ_posn *equ);
    (define equ-from-gal
      (foreign-safe-lambda* scheme-object ((double l) (double b))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_gal_posn in = {.l = l, .b = b};
                       struct ln_equ_posn *out;
                       out = malloc(sizeof(struct ln_equ_posn));
                       ln_get_equ_from_gal(&in, out);
                       a = C_alloc(C_SIZEOF_LIST(2) + C_SIZEOF_FLONUM * 2);
                       lst = C_vector(&a, 2, 
                                        C_flonum(&a, out->ra),
                                        C_flonum(&a, out->dec));
                       free(out);
                       C_return(callback(lst));"))


    ;; returns #(ra dec) 
    ;;void LIBNOVA_EXPORT ln_get_equ2000_from_gal(struct ln_gal_posn *gal,
    ;;	struct ln_equ_posn *equ);
    (define equ2000-from-gal
      (foreign-safe-lambda* scheme-object ((double l) (double b))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_gal_posn in = {.l = l, .b = b};
                       struct ln_equ_posn *out;
                       out = malloc(sizeof(struct ln_equ_posn));
                       ln_get_equ2000_from_gal(&in, out);
                       a = C_alloc(C_SIZEOF_LIST(2) + C_SIZEOF_FLONUM * 2);
                       lst = C_vector(&a, 2, 
                                        C_flonum(&a, out->ra),
                                        C_flonum(&a, out->dec));
                       free(out);
                       C_return(callback(lst));"))


    ;; returns #(l b) 
    ;;void LIBNOVA_EXPORT ln_get_gal_from_equ(struct ln_equ_posn *equ,
    ;;	struct ln_gal_posn *gal);
    (define gal-from-equ
      (foreign-safe-lambda* scheme-object ((double ra) (double dec))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_equ_posn in = {.ra = ra, .dec = dec};
                       struct ln_gal_posn *out;
                       out = malloc(sizeof(struct ln_gal_posn));
                       ln_get_gal_from_equ(&in, out);
                       a = C_alloc(C_SIZEOF_LIST(2) + C_SIZEOF_FLONUM * 2);
                       lst = C_vector(&a, 2, 
                                        C_flonum(&a, out->l),
                                        C_flonum(&a, out->b));
                       free(out);
                       C_return(callback(lst));"))
   
    
    ;; returns #(l b) 
    ;;void LIBNOVA_EXPORT ln_get_gal_from_equ2000(struct ln_equ_posn *equ,
    ;;	struct ln_gal_posn *gal);
    (define gal-from-equ2000
      (foreign-safe-lambda* scheme-object ((double ra) (double dec))
                       "C_word lst = C_SCHEME_END_OF_LIST, *a;
                       struct ln_equ_posn in = {.ra = ra, .dec = dec};
                       struct ln_gal_posn *out;
                       out = malloc(sizeof(struct ln_gal_posn));
                       ln_get_gal_from_equ2000(&in, out);
                       a = C_alloc(C_SIZEOF_LIST(2) + C_SIZEOF_FLONUM * 2);
                       lst = C_vector(&a, 2, 
                                        C_flonum(&a, out->l),
                                        C_flonum(&a, out->b));
                       free(out);
                       C_return(callback(lst));"))
 
;}}}

)

