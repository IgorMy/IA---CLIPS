(deftemplate Pais
	(field Nombre)
	(multifield Bandera)
)

(defrule inicio
	?h <- (fase color)
=>
	(retract ?h)
	(printout t "Introduzca el color: ")
	(assert (color (read)))
	(assert (fase otro_color))
)

(defrule otro_color
	?h <- (fase otro_color)
=>
	(retract ?h)
	(printout t "¿Quiere añadir otro color? (s/n) ")
	(assert (respuesta (read))
	(fase comprobar_respuesta))
)

(defrule no
	?h <- (fase comprobar_respuesta)
	?r <- (respuesta n)
	=>
	(retract ?h ?r)
	(assert (fase calcular))
)

(defrule si
	?h <- (fase comprobar_respuesta)
	?r <- (respuesta s)
=>
	(retract ?h ?r)
	(assert (fase pedir_color))
)

(defrule fallo
	?h <- (fase comprobar_respuesta)
	?r <- (respuesta ~s&~n)
=>
	(retract ?h ?r)
	(assert (fase otro_color))
	(printout t "Responda 's' o 'n'" crlf)
)

(defrule banderas_colores
	(fase calcular)
	(Pais (Nombre ?x))
	(forall (color ?y) (Pais (Nombre ?x) (Bandera $? ?y $?)))
=>
	(printout t ?x crlf)
)