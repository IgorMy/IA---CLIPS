(deffacts minimo
    (vector 2 3 6 8 9 5)
)


(defrule minimo
    (vector $? ?x $?)
    (not (vector $? ?y&:(< ?y ?x) $?))
=>
    (printout t "El minimo es " ?x crlf)
)