(use numbers srfi-19 ephem fmt)

; mayhill lnlat -105.5287 32.903
; harrisburg lnlat -76.8867 40.2732 
; b33 radec 5.683 -2.4583

(define now (exact->inexact (date->julian-day (current-date (* 3600 -7)))))
;(define dd (exact->inexact (date->julian-day (make-date 0 0 0 12 1 1 2000 0 #f))))

;(define rst (object-rst now -105.5287 32.903 5.683 2.4583)) 

(define my-ecl (make-ecl -76.8867 40.2732))
(define my-equ (make-equ 5.683 -2.4583))

(define rst (object-rst now my-ecl my-equ)) 

;(define rise (get-date (vector-ref rst 0)))
;(define set (get-date (vector-ref rst 1)))
;(define transit (get-date (vector-ref rst 2)))

(fmt #t 
     (get-date (rstc-rise rst)) nl
     (get-date (rstc-set rst)) nl)



