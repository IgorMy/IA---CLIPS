; template comienzo
(deftemplate Enfermedad
    (field Nombre)
    (multifield Sintomas)
    (field Probabilidad)
    (multifield Medicamentos)
)

(deftemplate Datos_Procesados
    (field Sintoma)
    (field Enfermedad)
)

(deftemplate Medico
    (field Tipo)
    (multifield Tratamientos)
)

; Introducción de datos
(defrule inicio
	?h <- (Sintomas_Paciente)
=>
	(retract ?h)
	(printout t "Introduzca el sintoma: ")
	(assert (Sintoma_Introducido (read)))
	(assert (otro_sintoma))
)

(defrule otro_sintoma
	?h <- (otro_sintoma)
=>
	(retract ?h)
	(printout t "¿Quiere añadir otro sintoma? [si/no]: ")
	(assert (respuesta (read))
	(comprobar_respuesta))
)

(defrule no
	?h <- (comprobar_respuesta)
	?r <- (respuesta no)
	=>
	(retract ?h ?r)
	(assert (aumentar_porcentaje))
)

(defrule si
	?h <- (comprobar_respuesta)
	?r <- (respuesta si)
=>
	(retract ?h ?r)
	(assert (Sintomas_Paciente))
)

(defrule fallo
	?h <- (comprobar_respuesta)
	?r <- (respuesta ~si&~no)
=>
	(retract ?h ?r)
	(printout t "Responda si o no" crlf)
    (assert (otro_sintoma))
)
;Aumentar probabilidad de enfermedad
(defrule añadir_porcentaje_enfermedad
    (aumentar_porcentaje)
    (Sintoma_Introducido ?x)
    ?o <- (Enfermedad (Nombre ?i) (Sintomas $?q ?x $?w) (Probabilidad ?p)  (Medicamentos $?po))
    (not (Datos_Procesados (Sintoma ?x) (Enfermedad ?i)))
=>
    (retract ?o)
    (assert (Datos_Procesados (Sintoma ?x) (Enfermedad ?i)))
    (assert (Enfermedad (Nombre ?i) (Sintomas $?q ?x $?w) (Probabilidad (+ ?p 1)) (Medicamentos $?po) ))
)

;Borrar datos inecesarios
(defrule borrra
    ?h <- (Sintoma_Introducido ?x)
    (forall
    (Enfermedad (Nombre ?i) (Sintomas $?q ?x $?w) (Probabilidad ?p) (Medicamentos $?))
    (Datos_Procesados (Sintoma ?x) (Enfermedad ?i)))
=>
    (retract ?h)
)

(defrule borrar2
    (not (Sintoma_Introducido ?))
    ?h <- (Datos_Procesados (Sintoma ?) (Enfermedad ?))
=>
    (retract ?h)
)

(defrule seguir
    (not (Datos_Procesados (Sintoma ?) (Enfermedad ?)))
    (Enfermedad (Nombre ?) (Sintomas $?q) (Probabilidad ?p) (Medicamentos $?))
    (test (> ?p 0))
    ?i <- (aumentar_porcentaje)
=>
    (retract ?i)
)

; Calculamos la probabilidad maxima

(defrule probabilidad_max
    ?h <- (Probabilidad_maxima ?i)
    (Enfermedad (Nombre ?) (Sintomas $?q) (Probabilidad ?p) (Medicamentos $?))
    (test (< ?i ?p))
    (not (test (= ?p 0)))
=>
    (retract ?h)
    (assert (Probabilidad_maxima ?p))
    
)

(defrule check
    (forall
        (Probabilidad_maxima ?i)
        (Enfermedad (Nombre ?) (Sintomas $?) (Probabilidad ?p&:(> ?p ?i)) (Medicamentos $?))
    )
=>
    (assert (continuar))
)

; Mostrar enfermedades

(defrule mostrar_enfermedades
    (continuar)
    (Probabilidad_maxima ?p)
    (Enfermedad (Nombre ?i) (Sintomas $?q) (Probabilidad ?p) (Medicamentos $?l))
=>
    (printout t "Tiene " ?i " para curarla se recomienda " $?l crlf)
)

(defrule vector_enfermedades
    (continuar)
    (Probabilidad_maxima ?p)
    (Enfermedad (Nombre ?i) (Sintomas $?) (Probabilidad ?p) (Medicamentos $? ?x $?))
    (not (vector_tratamientos $? ?x $?))
    ?t <- (vector_tratamientos $?g)
=>
    (retract ?t)
    (assert (vector_tratamientos $?g ?x))
)

