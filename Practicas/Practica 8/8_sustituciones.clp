(deffacts datos_iniciales
    (palabra B C D Z A R G T Y O I P)
)

(defrule inicio
    (initial-fact)
    (palabra $?x)
=>
    (assert (palabras_regla_1 $?x))
    (assert (palabras_regla_2 $?x))
    (assert (palabras_regla_3 $?x))
    (assert (palabras_regla_4 $?x))
)

(defrule regla_1
    ?h <- (palabras_regla_1 $?x C $?y)
=>
    (retract ?h)
    (assert (palabras_regla_1 $?x D L $?y))
)

(defrule regla_2
    ?h <- (palabras_regla_2 $?x C $?y)
=>
    (retract ?h)
    (assert (palabras_regla_2 $?x B M $?y))
)

(defrule regla_3
    ?h <- (palabras_regla_3 $?x B $?y)
=>
    (retract ?h)
    (assert (palabras_regla_3 $?x M M $?y))
)

(defrule regla_4
    ?h <- (palabras_regla_4 $?x Z $?y)
=>
    (retract ?h)
    (assert (palabras_regla_4 $?x B B M $?y))
)