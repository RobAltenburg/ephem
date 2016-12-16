(use numbers srfi-19 ephem fmt)

; mayhill lnlat -105.5287 32.903
; harrisburg lnlat -76.8867 40.2732 
; b33 radec 5.683 -2.4583
;(define now (exact->inexact (date->julian-day (current-date (* 3600 -5)))))

(define dd (exact->inexact (date->julian-day 
                             (make-date 0 0 30 7 13 12 2016 (* 3600 0)  #f))))
(define my-ecl (make-ecl -76.8867 40.2732))
(define my-equ (make-equ 20.97 -23.18))
(define rst (object-rst dd my-ecl my-equ)) 
(define rst (solar-rst dd my-ecl)) 
(define sequ (solar-equ-coords dd))
(define shrz (hrz-from-equ sequ my-ecl dd))
(fmt #t nl (fix 5 dd) nl
     "sunrise: " (get-date (rst-rise rst)) nl
     "xsunrise: " (get-date (rst-rise rst)) nl
     "sunset: " (get-date (rst-set rst)) nl
     "xsunset: " (get-date (rst-set rst)) nl
     "equ: " (fix 2 (* 24 (/ (equ-ra sequ) 360))) " " 
     (fix 2 (equ-dec sequ)) nl
     "hrz: " (fix 2 (hrz-az shrz)) " "  (fix 2 (hrz-alt shrz)) nl)


