(use numbers srfi-19 ephem test)
; mayhill lnlat -105.5287 32.903
; harrisburg lnlat -76.8867 40.2732 
; b33 radec 5.683 -2.4583
(current-test-epsilon 0.001)
;(define dd (exact->inexact (date->julian-day (make-date 0 0 0 16 11 12 2016 0 #f))))
(define dd 2457734.166670) 
(define lng 0)
(define lat 51.5)

(test-group "sidereal" ;; {{{1
            (test "GMST" 21.386430 (gmst dd)) ;; should be 21.342292
            (test "GAST" 21.386291 (gast dd))) ;; 21.386099
;}}}

(test-group "angular" ;;{{{1
            (let* ((equ1 (make-equ 1.2 3.4)) 
                  (equ2 (make-equ 5.6 7.8))
                  (asa (angular-separation equ1 equ2))
                  (rpa (rel-posn-angle equ1 equ2)))
              (test "asa" 6.206920 asa)
              (test "rpa" -134.900983 rpa)))
;;}}}

(test-group "solar" ;;{{{1
            (define rst (solar-rst dd (make-ecl lng lat)))
            (define sunrise (get-date (rst-rise rst)))
            (test "sunrise day" 12 (date-day sunrise))
            (test "sunrise hours" 7 (date-hour sunrise))
            (test "sunrise minute" 55 (date-minute sunrise))
            ;;(test "sunrise seconds" 41.9655 (+ (date-second sunrise) (/ (date-nanosecond sunrise) 1e+9)))
           (define sunset (get-date (rst-set rst)))
            (test "sunset day" 12 (date-day sunset))
            (test "sunset hours" 15 (date-hour sunset))
            (test "sunset minute" 49 (date-minute sunset))
            ;;(test "sunset seconds" 57.6132 (+ (date-second sunset) (/ (date-nanosecond sunset) 1e+9)))
            (define transit (get-date (rst-transit rst)))
            (test "transit day" 12 (date-day transit))
            (test "transit hours" 11 (date-hour transit))
            (test "transit minute" 52 (date-minute transit))
            ;;(test "transit seconds" 54.6300 (+ (date-second transit) (/ (date-nanosecond transit) 1e+9)))
            (define ll (solar-ecl-coords dd ))
            (test "ecl lng" 259.820349 (ecl-lng ll))
            (test "ecl lat" 0.002035 (ecl-lat ll))
            (define rd (solar-equ-coords dd ))
            (test "equ ra" 258.924590 (equ-ra rd))
            (test "equ dec" -23.044480 (equ-dec rd)))
;;}}}

(test-group "lunar" ;;{{{1
            (define rst (lunar-rst dd (make-ecl lng lat)))
            (define moonrise (get-date (rst-rise rst)))
            (test "moonrise day" 12 (date-day moonrise))
            (test "moonrise hours" 15 (date-hour moonrise))
            (test "moonrise minute" 13 (date-minute moonrise))
            (test "moonrise seconds" 49.055840 (+ (date-second moonrise) (/ (date-nanosecond moonrise) 1e+9)))
           (define moonset (get-date (rst-set rst)))
            (test "moonset day" 12 (date-day moonset))
            (test "moonset hours" 5 (date-hour moonset))
            (test "moonset minute" 24 (date-minute moonset))
            (test "moonset seconds" 13.533134 (+ (date-second moonset) (/ (date-nanosecond moonset) 1e+9)))
            (define transit (get-date (rst-transit rst)))
            (test "transit day" 11 (date-day transit))
            (test "transit hours" 21 (date-hour transit))
            (test "transit minute" 53 (date-minute transit))
            (test "transit seconds" 2.081741 (+ (date-second transit) (/ (date-nanosecond transit) 1e+9)))
            (test "lunar-sdiam arcsec" 995.721697 (lunar-sdiam dd))
            (test "rise" 2457735.124596 (rst-rise rst))
            (test "set" 2457734.725157 (rst-set rst))
            (test "transit" 2457734.411830 (rst-transit rst))
            (define xyz (lunar-geo-posn dd 0))
            (test "geo x" 246041.842701 (rect-x xyz))
            (test "geo y" 261140.490523 (rect-y xyz))
            (test "geo z" -29645.854275 (rect-z xyz))
            (define rd (lunar-equ-coords-prec dd 0.1))
            (test "equ ra prec" 45.615665 (equ-ra rd))
            (test "equ dec prec" 12.295526 (equ-dec rd))
            (define rd (lunar-equ-coords dd ))
            (test "equ ra" 45.615665 (equ-ra rd))
            (test "equ dec" 12.295536 (equ-dec rd))
            (define ll (lunar-ecl-coords dd 1))
            (test "ecl lat" -4.723454 (ecl-lat ll))
            (test "ecl lng" 46.705173 (ecl-lng ll))
            (test "phase" 33.333248 (lunar-phase dd))
            (test "disk"  0.917744 (lunar-disk dd))
            (test "earth dist" 360013.647459 (lunar-earth-dist dd))
            (test "bright limb" 246.552803 (lunar-bright-limb dd))
            (test "long asc node" -202.695193 (lunar-long-asc-node dd))
            (test "long perigee" 772.847930 (lunar-long-perigee dd))
            ) 
;;}}}

(test-exit)

