;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname lista5-tests) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))


;; ==========================================================
;; QUESTÃO 1
;; ==========================================================

(check-expect (soma15? (make-carta "ouros" 3) (make-carta "copas" 5)) #false)
(check-expect (soma15? (make-carta "ouros" 10) (make-carta "copas" 5)) #true)
(check-expect (soma15? (make-carta "copas" 5) (make-carta "ouros" 10)) #true)
(check-expect (soma15? (make-carta "espadas" 7) (make-carta "espadas" 8)) #true)