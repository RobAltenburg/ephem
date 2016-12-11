(use numbers srfi-19 ephem test)

; mayhill lnlat -105.5287 32.903
; harrisburg lnlat -76.8867 40.2732 
; b33 radec 5.683 -2.4583

(current-test-epsilon 0.000001)

(define dd (exact->inexact (date->julian-day (make-date 0 0 0 12 25 12 2016 0 #f))))
(define lng -76.8867)
(define lat 40.2732)

(test "Julian date" dd 2457748.0) ; not part of ephem

(test-group "sidereal"
            (test "GMST" 18.295416 (gmst dd))
            (test "GAST" 18.295287 (gast dd)))

(test-group "angular"
            (let* ((equ1 (make-equ 1.2 3.4)) 
                  (equ2 (make-equ 5.6 7.8))
                  (asa (angular-separation equ1 equ2))
                  (rpa (rel-posn-angle equ1 equ2)))
              (test "asa" 6.206920 asa)
              (test "rpa" -134.900983 rpa)))
            

(test-group "lunar"
            (define rst (lunar-rst dd (make-ecl lng lat)))
            (test "lunar-sdiam arcsec" 883.289643 (lunar-sdiam dd))
            (test "rise" 2457748.908354 (rst-rise rst))
            (test "set" 2457748.317307 (rst-set rst))
            (test "transit" 2457748.095985 (rst-transit rst))
            (define xyz (lunar-geo-posn dd 0))
            (test "geo x" -247929.741775 (rect-x xyz))
            (test "geo y" -319407.187805 (rect-y xyz))
            (test "geo z" 34859.718963 (rect-z xyz))
            (define rd (lunar-equ-coords-prec dd 0))
            (test "equ ra prec" 15.068788 (equ-ra rd))
            (test "equ dec prec" -13.545979 (equ-dec rd))
            (define rd (lunar-equ-coords dd ))
            (test "equ ra" 15.068788 (equ-ra rd))
            (test "equ dec" -13.545979 (equ-dec rd))
            (define ll (lunar-ecl-coords dd 0))
            (test "ecl lat" 4.927518 (ecl-lat ll))
            (test "ecl lng" 232.180727 (ecl-lng ll))
            (test "phase" 137.941339 (lunar-phase dd))
            (test "disk"  0.1287703 (lunar-disk dd))
            (test "earth dist" 405839.016368 (lunar-earth-dist dd))
            (test "bright limb" 110.0766639 (lunar-bright-limb dd))
            (test "long asc node" -203.427720 (lunar-long-asc-node dd))
            (test "long perigee" 774.389011 (lunar-long-perigee dd))
            ) 

(test-exit)


