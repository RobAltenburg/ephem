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
        (use ephem-common)
        (foreign-declare "#include <libnova/transform.h>")
        ;;; }}}

        ;;; Transform {{{1

        ;; returns hrz type
        ;;void LIBNOVA_EXPORT ln_get_hrz_from_equ(struct ln_equ_posn *object,
        ;;	struct ln_lnlat_posn *observer, double JD, struct ln_hrz_posn *position);
        (define (hrz-from-equ equ ecl jd)
          (let ((hrz (make-hrz)))
            ((foreign-lambda void "ln_get_hrz_from_equ"
                             nonnull-c-pointer
                             nonnull-c-pointer
                             double
                             nonnull-c-pointer)
             equ
             ecl
             jd
             hrz)
            hrz))

        ;; returns hrz type
        ;;void LIBNOVA_EXPORT ln_get_hrz_from_equ_sidereal_time(struct ln_equ_posn *object,
        ;;    struct ln_lnlat_posn *observer, double sidereal,
        ;;    struct ln_hrz_posn *position);
        (define (hrz-from-equ-sidereal-time equ ecl sidereal)
          (let ((hrz (make-hrz)))
            ((foreign-lambda void "ln_get_hrz_from_sidereal_time"
                             nonnull-c-pointer
                             nonnull-c-pointer
                             double
                             nonnull-c-pointer)
             equ
             ecl
             sidereal 
             hrz)
            hrz))

        ;; returns equ type
        ;;void LIBNOVA_EXPORT ln_get_equ_from_ecl(struct ln_lnlat_posn *object,
        ;;	double JD, struct ln_equ_posn *position);
        (define (equ-from-ecl ecl jd)
          (let ((equ (make-equ)))
            ((foreign-lambda void "ln_get_equ_from_ecl"
                             nonnull-c-pointer
                             double
                             nonnull-c-pointer)
             ecl
             jd
             equ)
            equ))

        ;; returns ecl type 
        ;;ln_get_ecl_from_equ(struct ln_equ_posn *object, double JD,
        ;;	struct ln_lnlat_posn *position);
        (define (ecl-from-equ equ jd)
          (let ((ecl (make-ecl)))
            ((foreign-lambda void "ln_get_ecl_from_equ"
                             nonnull-c-pointer
                             double
                             nonnull-c-pointer)
             equ
             jd
             ecl)
            ecl))

        ;; returns rect
        ;;void LIBNOVA_EXPORT ln_get_rect_from_helio(struct ln_helio_posn *object,
        ;;	struct ln_rect_posn *position);
        (define (rect-from-helio helio)
          (let ((rect (make-rect)))
            ((foreign-lambda void "ln_get_rect_from_helio"
                             nonnull-c-pointer
                             nonnull-c-pointer)
             helio
             rect)
            rect))


        ;; returns ecl type
        ;;void LIBNOVA_EXPORT ln_get_ecl_from_rect(struct ln_rect_posn *rect,
        ;;	struct ln_lnlat_posn *posn);
        (define (ecl-from-rect rect)
          (let ((ecl (make-ecl)))
            ((foreign-lambda void "ln_get_ecl_from_rect"
                             nonnull-c-pointer
                             nonnull-c-pointer)
             rect
             ecl)
            ecl))


        ;; returns equ
        ;;void LIBNOVA_EXPORT ln_get_equ_from_gal(struct ln_gal_posn *gal,
        ;;	struct ln_equ_posn *equ);
        (define (equ-from-gal gal)
          (let ((equ (make-equ)))
            ((foreign-lambda void "ln_get_equ_from_gal" 
                             nonnull-c-pointer
                             nonnull-c-pointer)
             gal
             equ)
            equ))

        ;; returns equ
        ;;void LIBNOVA_EXPORT ln_get_equ_from_gal(struct ln_gal_posn *gal,
        ;;	struct ln_equ_posn *equ);
        (define (equ2000-from-gal gal)
          (let ((equ (make-equ)))
            ((foreign-lambda void "ln_get_equ2000_from_gal" 
                             nonnull-c-pointer
                             nonnull-c-pointer)
             gal
             equ)
            equ))


        ;; returns gal
        ;;void LIBNOVA_EXPORT ln_get_gal_from_equ(struct ln_equ_posn *equ,
        ;;	struct ln_gal_posn *gal);
        (define (gal-from-equ equ)
          (let ((gal (make-gal)))
            ((foreign-lambda void "ln_get_gal_from_equ" 
                             nonnull-c-pointer
                             nonnull-c-pointer)
             equ 
             gal)
            gal))

        ;; returns gal
        ;;void LIBNOVA_EXPORT ln_get_gal_from_equ2000(struct ln_equ_posn *equ,
        ;;	struct ln_gal_posn *gal);
        (define (gal-from-equ2000 equ)
          (let ((gal (make-gal)))
            ((foreign-lambda void "ln_get_gal_from_equ2000" 
                             nonnull-c-pointer
                             nonnull-c-pointer)
             equ 
             gal)
            gal))

        ;}}}

        )


