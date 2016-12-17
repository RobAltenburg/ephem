(exit)
csi
(use numbers srfi-19 ephem fmt)

; mayhill lnlat -105.5287 32.903
; harrisburg lnlat -76.8867 40.2732 
; b33 radec 5.683 -2.4583
;(define now (exact->inexact (date->julian-day (current-date (* 3600 -5)))))

(define dd (exact->inexact (date->julian-day 
                             (make-date 0 0 30 7 13 12 2016 (* 3600 0)  #f))))
(define my-ecl (make-ecl -76.8867 40.2732))
(define my-equ (make-equ 20.97 -23.18))
(define rst (lunar-rst dd my-ecl))
(define rstb (body-rst-horizon dd my-ecl 'moon 0)) 
(fmt #t nl (fix 5 dd) nl
     "object: " (get-date (rst-rise rst)) " -- " (get-date (rst-rise rst)) nl
     "body:   " (get-date (rst-rise rstb)) " -- " (get-date (rst-rise rstb)) nl
     "const:  " (get-constellation my-equ) nl)



