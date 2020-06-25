(deffacts datos_iniciales
    (cadena B C A D E E B C E)
    (cadena E E B F D E)
)

;para que quede bien
(defrule inicio
    (cadena $? ?x $?)
    (not (union $?))
=>
    (assert (union ?x))
)

(defrule r_union 
    (cadena $? ?x $?)
    ?h <- (union $?f)
    (not (union $? ?x $?))
=>
    (retract ?h)
    (assert (union $?f ?x))
)