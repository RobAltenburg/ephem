;;; ephem
;;; Chicken scheme wrapper for libnova
;;; 
;;; see: libnova.sourceforge.net
;;;
;;; Rob Altenburg - 2016
;;; 

;;; Module Definition {{{1
(module ephem

        ;;; functions {{{2
        (gmst gast lmst last get-version rad->deg deg->rad hms->deg deg->hms
          lunar-phase lunar-disk lunar-sdiam lunar-earth-dist lunar-bright-limb 
          lunar-long-asc-node lunar-long-perigee lunar-equ-coords lunar-rst
          lunar-geo-posn lunar-equ-coords-prec lunar-ecl-coords
          solar-rst-horizon solar-rst solar-geom-coords solar-equ-coords 
          solar-ecl-coords solar-geo-coords solar-sdiam
          get-date object-rst object-next-rst object-next-rst-horizon
          body-equ-pointer body-rst-horizon body-next-rst-horizon  
          body-next-rst-horizon-future vsop87->fk5
          solve-kepler ell-mean-anomaly ell-true-anomaly ell-radius-vector
          ell-smajor-diam ell-sminor-diam ell-mean-motion ell-geo-rect-posn
          ell-helio-rect-posn ell-orbit-len ell-orbit-vel ell-orbit-pvel 
          ell-orbit-avel ell-body-phase-angle ell-body-elong ell-body-solar-dist
          ell-body-earth-dist ell-body-equ-coords ell-body-rst ell-body-rst-horizon
          ell-body-next-rst-horizon ell-body-next-rst-horizon-future ell-last-perihelion
          solve-hyp-barker hyp-true-anomaly hyp-radius-vector hyp-geo-rect-posn 
          hyp-helio-rect-posn 
          hyp-body-equ-coords hyp-body-earth-dist  hyp-body-solar-dist hyp-body-phase-angle 
          hyp-body-elong hyp-body-rst hyp-body-rst-horizon hyp-body-next-rst-horizon 
          hyp-body-next-rst-horizon-future  
          solve-barker par-true-anomaly par-radius-vector par-geo-rect-posn 
          par-helio-rect-posn 
          par-body-equ-coords par-body-earth-dist  par-body-solar-dist par-body-phase-angle 
          par-body-elong par-body-rst par-body-rst-horizon par-body-next-rst-horizon 
          par-body-next-rst-horizon-future  
          heliocentric-time-diff refraction-adj 
          equ-aberration ecl-aberration dynamical-time-diff jde
          earth-helio-coords earth-solar-dist earth-rect-helio earth-centre-dist
          mercury-sdiam mercury-rst mercury-helio-coords mercury-equ-coords
          mercury-earth-dist mercury-solar-dist mercury-magnitude 
          mercury-disk mercury-phase mercury-rect-helio
          venus-sdiam venus-rst venus-helio-coords venus-equ-coords
          venus-earth-dist venus-solar-dist venus-magnitude 
          venus-disk venus-phase venus-rect-helio
          jupiter-equ-sdiam jupiter-pol-sdiam jupiter-rst jupiter-helio-coords jupiter-equ-coords
          jupiter-earth-dist jupiter-solar-dist jupiter-magnitude 
          jupiter-disk jupiter-phase jupiter-rect-helio
          saturn-equ-sdiam saturn-pol-sdiam saturn-rst saturn-helio-coords saturn-equ-coords
          saturn-earth-dist saturn-solar-dist saturn-magnitude 
          saturn-disk saturn-phase saturn-rect-helio
          neptune-sdiam neptune-rst neptune-helio-coords neptune-equ-coords
          neptune-earth-dist neptune-solar-dist neptune-magnitude 
          neptune-disk neptune-phase neptune-rect-helio
          uranus-sdiam uranus-rst uranus-helio-coords uranus-equ-coords
          uranus-earth-dist uranus-solar-dist uranus-magnitude 
          uranus-disk uranus-phase uranus-rect-helio
          pluto-sdiam pluto-rst pluto-helio-coords pluto-equ-coords
          pluto-earth-dist pluto-solar-dist pluto-magnitude 
          pluto-disk pluto-phase pluto-rect-helio
          angular-separation rel-posn-angle refraction-adj
          constellation apparent-posn
          nutation equ-prec equ-prec2 ecl-prec
         hrz-from-equ hrz-from-equ-sidereal-time equ-from-ecl ecl-from-equ rect-from-helio 
          ecl-from-rect equ-from-gal equ2000-from-gal gal-from-equ gal-from-equ2000
          ell-comet-mag par-comet-mag
          range-hours range-degrees range-degrees180
          make-rst rst-rise rst-set rst-transit 
          make-rect rect-x rect-y rect-z
          make-helio helio-l helio-b helio-r
          make-ecl ecl-lng ecl-lat
          make-equ equ-ra equ-dec
          make-hrz hrz-az hrz-alt
          make-hms hms-hours hms-minutes hms-seconds
          make-ell ell-a ell-e ell-i ell-w ell-omega ell-n ell-jd
          make-hyp hyp-q hyp-e hyp-i hyp-w hyp-omega hyp-jd
          make-par par-q par-i par-w par-omega par-jd
          make-nutation nutation-longitude nutation-obliquity nutation-ecliptic
          is-above-horizon? dms->deg hms->hr)
        ;;;}}}
          
    (import chicken scheme foreign)

    (use ephem-common
            ephem-sidereal ephem-lunar ephem-solar ephem-rise-set ephem-julian-day
            ephem-angular ephem-mercury ephem-venus ephem-jupiter ephem-saturn
            ephem-neptune ephem-uranus ephem-pluto ephem-earth
            ephem-refraction ephem-transform ephem-constellation 
            ephem-aberration ephem-apparent ephem-comet ephem-dynamical
            ephem-nutation ephem-elliptic ephem-heliocentric ephem-hyperbolic
            ephem-parabolic ephem-precession ephem-proper-motion ephem-atmospheric-refraction
            ephem-utility)

;;; }}}

;;; Extras (non-libnova) {{{1

    (define (is-above-horizon? equ-obj ecl-obs jd)
      (let ((alt (hrz-alt (hrz-from-equ equ-obj ecl-obs jd))))
        (if (positive? alt)
          alt
          #f)))

    (define dms->deg 
      (lambda (deg min #!optional (sec 0) (west #t))
        (cond 
          ((negative? deg)
            (range-degrees180 (- deg (/ min 60) (/ sec 3600))))
          (west
            (range-degrees180 (* -1 (+ deg (/ min 60) (/ sec 3600)))))
          (else
            (range-degrees180 (+ deg (/ min 60) (/ sec 3600)))))))
    
    (define hms->hr
      (lambda (hr min #!optional (sec 0))
        (if (positive? hr)
          (range-hours (+ hr (/ min 60) (/ sec 3600)))
          (range-hours (- hr (/ min 60) (/ sec 3600))))))
    
;;; }}}

)              





