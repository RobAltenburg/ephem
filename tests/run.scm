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

(test-group "lunar"
            (define rst (lunar-rst dd lng lat))
            (test "lunar-sdiam arcsec" 883.289643 (lunar-sdiam dd))
            (test "rise" 2457748.908354 (vector-ref rst 0))
            (test "set" 2457748.317307 (vector-ref rst 1))
            (test "transit" 2457748.095985 (vector-ref rst 2))
            (define xyz (lunar-geo-posn dd 0))
            (test "geo x" -247929.741775 (vector-ref xyz 0))
            (test "geo y" -319407.187805 (vector-ref xyz 1))
            (test "geo z" 34859.718963 (vector-ref xyz 2))
            (define rd (lunar-equ-coords-prec dd 0))
            (test "equ ra prec" 15.068788 (vector-ref rd 0))
            (test "equ dec prec" -13.545979 (vector-ref rd 1))
            (define rd (lunar-equ-coords dd ))
            (test "equ ra" 15.068788 (vector-ref rd 0))
            (test "equ dec" -13.545979 (vector-ref rd 1))
            (define ll (lunar-ecl-coords dd 0))
            (test "ecl lat" 4.927518 (vector-ref ll 0))
            (test "ecl lng" 232.180727 (vector-ref ll 1))
            (test "phase" 137.941339 (lunar-phase dd))
            (test "disk"  0.1287703 (lunar-disk dd))
            (test "earth dist" 405839.016368 (lunar-earth-dist dd))
            (test "bright limb" 110.0766639 (lunar-bright-limb dd))
            (test "long asc node" -203.427720 (lunar-long-asc-node dd))
            (test "long perigee" 774.389011 (lunar-long-perigee dd))
            ) 

(test-exit)


