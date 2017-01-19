;;; ephem-common
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem-common
        (range-hours range-degrees range-degrees180
                     make-rst rst-rise rst-set rst-transit 
                     make-rst rst-rise rst-set rst-transit
                     make-rect rect-x rect-y rect-z
                     make-helio helio-l helio-b helio-r
                     make-ecl ecl-lng ecl-lat
                     make-equ equ-ra equ-dec
                     make-hrz hrz-az hrz-alt
                     make-hms hms-hours hms-minutes hms-seconds
                     make-gal gal-l gal-b
                     make-ell ell-a ell-e ell-i ell-w ell-omega ell-n ell-jd
                     make-hyp hyp-q hyp-e hyp-i hyp-w hyp-omega hyp-jd
                     make-par par-q par-i par-w par-omega par-jd
                     make-nutation nutation-longitude nutation-obliquity nutation-ecliptic
                     )

        (import chicken scheme foreign foreigners)
        (foreign-declare "#include <libnova/ln_types.h>")

        ;;; }}}

        ;;; Common {{{1
        (define (range-hours hours)
          (cond 
            ((< hours 0) (range-hours (+ 24 hours)))
            ((> hours 24) (range-hours (- hours 24)))
            (else hours)))

        (define (range-degrees degrees)
          (cond 
            ((< degrees 0) (range-degrees (+ 360 degrees)))
            ((> degrees 360) (range-degrees (- degrees 360)))
            (else degrees)))

        (define (range-degrees180 degrees)
          (cond 
            ((< degrees -180) (range-degrees180 (+ 360 degrees)))
            ((> degrees 180) (range-degrees180 (- degrees 360)))
            (else degrees)))

        (define-foreign-record-type (rst "struct ln_rst_time")
                                    (constructor: _make-rst)
                                    (destructor: free-rst)
                                    (double rise rst-rise rst-rise-set!)
                                    (double set rst-set rst-set-set!)
                                    (double transit rst-transit rst-transit-set!))

        (define (make-rst #!optional (rise #f) (set #f) (transit #f))
          (let ((rst (_make-rst)))
            (when (and rise set transit)
              (rst-rise-set! rst rise)
              (rst-set-set! rst set)
              (rst-transit-set! rst transit))
            (set-finalizer! rst free-rst)
            rst))

        (define-foreign-record-type (rect "struct ln_rect_posn")
                                    (constructor: _make-rect)
                                    (destructor: free-rect)
                                    (double X rect-x rect-x-set!)
                                    (double Y rect-y rect-y-set!)
                                    (double Z rect-z rect-z-set!))

        (define (make-rect #!optional (x #f) (y #f) (z #f))
          (let ((rect (_make-rect)))
            (when (and x y z)
              (rect-x-set! rect x)
              (rect-y-set! rect y)
              (rect-z-set! rect z))
            (set-finalizer! rect free-rect)
            rect))

        (define-foreign-record-type (helio "struct ln_helio_posn")
                                    (constructor: _make-helio)
                                    (destructor: free-helio)
                                    (double L helio-l helio-l-set!)
                                    (double B helio-b helio-b-set!)
                                    (double R helio-r helio-r-set!))

        (define (make-helio #!optional (l #f) (b #f) (r #f))
          (let ((helio (_make-helio)))
            (when (and l b r)
              (helio-l-set! helio l)
              (helio-b-set! helio b)
              (helio-r-set! helio r))
            (set-finalizer! helio free-helio)
            helio))


        (define-foreign-record-type (ecl "struct ln_lnlat_posn")
                                    (constructor: _make-ecl)
                                    (destructor: free-ecl)
                                    (double lng ecl-lng ecl-lng-set!)
                                    (double lat ecl-lat ecl-lat-set!))

        (define (make-ecl #!optional (lng #f) (lat #f))
          (let ((ecl (_make-ecl)))
            (when (and lng lat)
              (ecl-lng-set! ecl lng)
              (ecl-lat-set! ecl lat))
            (set-finalizer! ecl free-ecl)
            ecl))

        (define-foreign-record-type (equ "struct ln_equ_posn")
                                    (constructor: _make-equ)
                                    (destructor: free-equ)
                                    (double ra equ-ra equ-ra-set!)
                                    (double dec equ-dec equ-dec-set!))

        (define (make-equ #!optional (ra #f) (dec #f))
          (let ((equ (_make-equ)))
            (when (and ra dec)
              (equ-ra-set! equ ra)
              (equ-dec-set! equ dec))
            (set-finalizer! equ free-equ)
            equ))


        (define-foreign-record-type (hrz "struct ln_hrz_posn")
                                    (constructor: _make-hrz)
                                    (destructor: free-hrz)
                                    (double az hrz-az hrz-az-set!)
                                    (double alt hrz-alt hrz-alt-set!))

        (define (make-hrz #!optional (az #f) (alt #f))
          (let ((hrz (_make-hrz)))
            (when (and az alt)
              (hrz-az-set! hrz az)
              (hrz-alt-set! hrz alt))
            (set-finalizer! hrz free-hrz)
            hrz))

        (define-foreign-record-type (hms "struct ln_hms")
                                    (constructor: _make-hms)
                                    (destructor: free-hms)
                                    (double hours hms-hours hms-hours-set!)
                                    (double minutes hms-minutes hms-minutes-set!)
                                    (double seconds hms-seconds hms-seconds-set!))

        (define (make-hms #!optional (hours #f) (minutes #f) (seconds #f))
          (let ((hms (_make-hms)))
            (when (and hours minutes seconds)
              (hms-hours-set! hms hours)
              (hms-minutes-set! hms minutes)
              (hms-seconds-set! hms seconds))
            (set-finalizer! hms free-hms)
            hms))

        (define-foreign-record-type (gal "struct ln_gal_posn")
                                    (constructor: _make-gal)
                                    (destructor: free-gal)
                                    (double l gal-l gal-l-set!)
                                    (double b gal-b gal-b-set!))

        (define (make-gal #!optional (l #f) (b #f))
          (let ((gal (_make-gal)))
            (when (and l b)
              (gal-l-set! gal l)
              (gal-b-set! gal b))
            (set-finalizer! gal free-gal)
            gal))


        (define-foreign-record-type (ell "struct ln_ell_orbit")
                                    (constructor: _make-ell)
                                    (destructor: free-ell)
                                    (double a ell-a ell-a-set!)
                                    (double e ell-e ell-e-set!)
                                    (double i ell-i ell-i-set!)
                                    (double w ell-w ell-w-set!)
                                    (double omega ell-omega ell-omega-set!)
                                    (double n ell-n ell-n-set!)
                                    (double JD ell-jd ell-jd-set!))


        (define (make-ell #!optional (a #f) (e #f) (i #f) (w #f) (omega #f) (n #f) (jd #f))
          (let ((ell (_make-ell)))
            (when (and a e i w omega n jd) 
              (ell-a-set! ell a)
              (ell-e-set! ell e)
              (ell-i-set! ell i)
              (ell-w-set! ell w)
              (ell-omega-set! ell omega)
              (ell-n-set! ell n)
              (ell-jd-set! ell jd))
            (set-finalizer! ell free-ell)
            ell))

        (define-foreign-record-type (hyp "struct ln_hyp_orbit")
                                    (constructor: _make-hyp)
                                    (destructor: free-hyp)
                                    (double q hyp-q hyp-q-set!)
                                    (double e hyp-e hyp-e-set!)
                                    (double i hyp-i hyp-i-set!)
                                    (double w hyp-w hyp-w-set!)
                                    (double omega hyp-omega hyp-omega-set!)
                                    (double JD hyp-jd hyp-jd-set!))


        (define (make-hyp #!optional (q #f) (e #f) (i #f) (w #f) (omega #f) (jd #f))
          (let ((hyp (_make-hyp)))
            (when (and q e i w omega jd) 
              (hyp-q-set! hyp q)
              (hyp-e-set! hyp e)
              (hyp-i-set! hyp i)
              (hyp-w-set! hyp w)
              (hyp-omega-set! hyp omega)
              (hyp-jd-set! hyp jd))
            (set-finalizer! hyp free-hyp)
            hyp))


        (define-foreign-record-type (par "struct ln_par_orbit")
                                    (constructor: _make-par)
                                    (destructor: free-par)
                                    (double q par-q par-q-set!)
                                    (double i par-i par-i-set!)
                                    (double w par-w par-w-set!)
                                    (double omega par-omega par-omega-set!)
                                    (double JD par-jd par-jd-set!))


        (define (make-par #!optional (q #f) (i #f) (w #f) (omega #f) (jd #f))
          (let ((par (_make-par)))
            (when (and q i w omega jd) 
              (par-q-set! par q)
              (par-i-set! par i)
              (par-w-set! par w)
              (par-omega-set! par omega)
              (par-jd-set! par jd))
            (set-finalizer! par free-par)
            par))

        (define-foreign-record-type (nutation "struct ln_nutation")
                                    (constructor: _make-nutation)
                                    (destructor: free-nutation)
                                    (double longitude nutation-longitude nutation-longitude-set!)
                                    (double obliquity nutation-obliquity nutation-obliquity-set!)
                                    (double ecliptic nutation-ecliptic nutation-ecliptic-set!))


        (define (make-nutation #!optional (longitude #f) (obliquity #f) (ecliptic #f))
          (let ((nutation (_make-nutation)))
            (when (and longitude obliquity ecliptic) 
              (nutation-longitude-set! nutation longitude)
              (nutation-obliquity-set! nutation obliquity)
              (nutation-ecliptic-set! nutation ecliptic))
            (set-finalizer! nutation free-nutation)
            nutation))


        ;;; }}}


        )              


