(use numbers srfi-19 ephem test)
; mayhill lnlat -105.5287 32.903
; harrisburg lnlat -76.8867 40.2732 
; b33 radec 5.683 -2.4583
(current-test-epsilon 0.000001)
(define dd (exact->inexact (date->julian-day (make-date 0 0 0 16 11 12 2016 0 #f))))
(define lng 0)
(define lat 51.5)
(test "Julian date" 2457734.16667 dd) ; not part of ephem

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
            (test "rise" 2457734.830328 (rst-rise rst))
            (test "set" 2457735.159715 (rst-set rst))
            (test "transit" 2457734.995078 (rst-transit rst))
            (define ll (solar-ecl-coords dd ))
            (test "ecl lng" 259.820349 (ecl-lng ll))
            (test "ecl lat" -0.002017 (ecl-lat ll))
            (define rd (solar-equ-coords dd ))
            (test "equ ra" 258.924254 (equ-ra rd))
            (test "equ dec" -23.048520 (equ-dec rd)))
;;}}}

(test-group "lunar" ;;{{{1
            (define rst (lunar-rst dd (make-ecl lng lat)))
            (test "lunar-sdiam arcsec" 995.721697 (lunar-sdiam dd))
            (test "rise" 2457735.124596 (rst-rise rst))
            (test "set" 2457734.725157 (rst-set rst))
            (test "transit" 2457734.411830 (rst-transit rst))
            (define xyz (lunar-geo-posn dd 0))
            (test "geo x" 246042.077211 (rect-x xyz))
            (test "geo y" 261140.281151 (rect-y xyz))
            (test "geo z" -29645.845565 (rect-z xyz))
            (define rd (lunar-equ-coords-prec dd 0))
            (test "equ ra prec" 21.615615 (equ-ra rd))
            (test "equ dec prec" 12.295526 (equ-dec rd))
            (define rd (lunar-equ-coords dd ))
            (test "equ ra" 21.615615 (equ-ra rd))
            (test "equ dec" 12.295536 (equ-dec rd))
            (define ll (lunar-ecl-coords dd 1))
            (test "ecl lat" -4.723452 (ecl-lat ll))
            (test "ecl lng" 46.705122 (ecl-lng ll))
            (test "phase" 33.333330 (lunar-phase dd))
            (test "disk"  0.917744 (lunar-disk dd))
            (test "earth dist" 360013.647459 (lunar-earth-dist dd))
            (test "bright limb" 246.552804 (lunar-bright-limb dd))
            (test "long asc node" -202.695193 (lunar-long-asc-node dd))
            (test "long perigee" 772.847930 (lunar-long-perigee dd))
            ) 
;;}}}

(test-exit)

;;; JD 2457734.166670
;;; Solar Coords longitude (deg) 259.820349
;;;              latitude (deg) -0.002017
;;;              radius vector (AU) 0.984565
;;; Solar Position RA 258.924254
;;;                DEC -23.048520
;;; 
;;; Rise
;;;  Year    : 2016
;;;  Month   : 12
;;;  Day     : 12
;;;  Hours   : 7
;;;  Minutes : 55
;;;  Seconds : 41.965565
;;; 
;;; Transit
;;;  Year    : 2016
;;;  Month   : 12
;;;  Day     : 12
;;;  Hours   : 11
;;;  Minutes : 52
;;;  Seconds : 54.630068
;;; 
;;; Set
;;;  Year    : 2016
;;;  Month   : 12
;;;  Day     : 12
;;;  Hours   : 15
;;;  Minutes : 49
;;;  Seconds : 57.613272
