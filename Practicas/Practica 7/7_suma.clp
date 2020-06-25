(deffacts valores
    (vector 1 2 5 7 8 10 3)
)

(defrule Inicio
    (initial-fact)
    (vector $?x)
=>
    (assert (vector-procesar $?x))
    (assert (suma 0))
)

(defrule suma
    ?h <- (vector-procesar $?y ?x $?g)
    ?s <- (suma ?f)
=>
    (retract ?h)
    (retract ?s)
    (assert (vector-procesar $?y $?g))
    (assert (suma (+ ?f ?x)))
)

(defrule final
    ?h <- (vector-procesar)
    (suma ?f)
=>
    (retract ?h)
    (printout t "El total es " ?f crlf)
)