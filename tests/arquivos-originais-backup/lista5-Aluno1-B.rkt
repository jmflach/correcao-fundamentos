;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname lista5) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
;; Nome:

;; ==========================================================
;; DEFINIÇÃO DE DADOS E FUNÇÕES PARA UTILIZAREM NESTA LISTA
;; ==========================================================

(define-struct carta (naipe valor))
;; Um elemento do conjunto Carta é
;;   (make-carta-comum n v)     onde
;;   n : String, é o naipe da carta, que pode ser "copas", "ouros", "espadas" ou "paus"
;;   v : Número, é o valor da carta, que pode ser qualquer inteiro entre 1 e 10

(define CARTA-NULA (make-carta "nenhum" 0))


;; soma15?: Carta Carta -> Booleano
;; obj: dadas 2 cartas, verifica se o valor delas somado é 15.
;; ex:
;;  (soma15? $CARTA3O $CARTA5C) -> #false
;;  (soma15? $CARTA10O $CARTA5C) -> #true)
;;  (soma15? $CARTA5C $CARTA10O) -> #true)
;;  (soma15? $CARTA7E $CARTA8E) -> #true)

(define (soma15? c1 c2)
  (= 15 (+ (carta-valor c1) (carta-valor c2))))

(check-expect (soma15? (make-carta "ouros" 3) (make-carta "copas" 5)) #false)
(check-expect (soma15? (make-carta "ouros" 10) (make-carta "copas" 5)) #true)
(check-expect (soma15? (make-carta "copas" 5) (make-carta "ouros" 10)) #true)
(check-expect (soma15? (make-carta "espadas" 7) (make-carta "espadas" 8)) #true)



;; ==========================================================
;; QUESTÃO 1
;; ==========================================================

(define CARTA3O (make-carta "ouros" 3))
(define CARTA5C (make-carta "copas" 5))
(define CARTA1P (make-carta "paus" 1))
(define CARTA3P (make-carta "paus" 3))
(define CARTA3C (make-carta "copas" 3))
(define CARTA10O (make-carta "ouros" 10))
(define CARTA7O (make-carta "ouros" 7))
(define CARTA7E (make-carta "espadas" 7))
(define CARTA8E (make-carta "espadas" 8))
(define CARTA3E (make-carta "espadas" 3))

(define MÃO1 (list CARTA7O CARTA3P CARTA-NULA))
(define MÃO2 (list CARTA1P CARTA3C CARTA5C))
(define MÃO3 (list CARTA3O CARTA5C CARTA1P CARTA3P CARTA3C CARTA10O CARTA7O CARTA7E CARTA8E CARTA3E))

(define MESA1 (list CARTA5C CARTA3C  CARTA1P CARTA3O)) ;; escova com  CARTA3P
(define MESA2 (list CARTA3P CARTA7O CARTA10O))
(define MESA3 (list CARTA5C CARTA3C CARTA1P CARTA3O CARTA3O CARTA1P))