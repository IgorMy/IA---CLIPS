; Plantillas

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

; Introducir datos

(defrule inicio
    ?i <- (inicio)
=>
    (retract ?i)
    (printout t "--------------------------------------------------------------------" crlf)
    (printout t "                           Sistema medico " crlf)
    (printout t "--------------------------------------------------------------------" crlf)
    (assert (Sintomas_Paciente))
)

(defrule preguntar
	?h <- (Sintomas_Paciente)
=>
	(retract ?h)
	(printout t " -> Introduzca un sintoma,para terminar introduzca '-1': ")
	(assert (Sintoma (read)))
	(assert (comprobar))
)

; Comprobar si vamos a introducir otro sintoma

(defrule otro_sintoma
    ?i <- (comprobar)
    (not (Sintoma -1))
=>
    (retract ?i)
    (assert (Sintomas_Paciente))
)

(defrule salir
    ?i <- (comprobar)
    ?h <- (Sintoma -1)
=>
    (retract ?i ?h)
    (printout t "--------------------------------------------------------------------" crlf)
    (assert (continuar1))
)

; Recalculasmos las probabilidades de las enfermedades

(defrule probabilidade_de_enfermedades
    (continuar1)
    (Sintoma ?q)
    ?i <- (Enfermedad (Nombre ?w) (Sintomas $?e ?q $?t) (Probabilidad ?y) (Medicamentos $?u))
    (not (Datos_Procesados (Sintoma ?q) (Enfermedad ?w)))
=>
    (retract ?i)
    (assert (Enfermedad (Nombre ?w) (Sintomas $?e ?q $?t) (Probabilidad (+ ?y 1)) (Medicamentos $?u)))
    (assert (Datos_Procesados (Sintoma ?q) (Enfermedad ?w)))
)

; Borrar datos estructuras auxiliares, primera fase

(defrule borrra
    (continuar1)
    ?h <- (Sintoma ?x)
    (forall
    (Enfermedad (Nombre ?i) (Sintomas $?q ?x $?w) (Probabilidad ?p) (Medicamentos $?))
    (Datos_Procesados (Sintoma ?x) (Enfermedad ?i)))
=>
    (retract ?h)
)

(defrule borrar1
    (continuar1)
    (not (Sintoma ?t))
    ?i <- (Datos_Procesados (Sintoma ?t) (Enfermedad ?))
=>
    (retract ?i)
)

; Continuar despues de borrar las estructuras auxiliares

(defrule continuar_0
    ?i <- (continuar1)
    (not (Sintoma ?))
    (not (Datos_Procesados (Sintoma ?) (Enfermedad ?)))
=>
    (retract ?i)
    (assert (continuar2))
)

; Calculamos la probabilidad maxima

(defrule calcular_probabilidad_maxima
    (continuar2)
    ?i <- (Probabilidad_maxima ?h)
    (Enfermedad (Nombre ?) (Sintomas $?) (Probabilidad ?p) (Medicamentos $?))
    (test (> ?p ?h))
=>
    (retract ?i)
    (assert (Probabilidad_maxima ?p))
)

(defrule continuar_1
    ?i <- (continuar2)
    (Probabilidad_maxima ?h)
    (not (Enfermedad (Nombre ?) (Sintomas $?) (Probabilidad ?p&:(< ?h ?p)) (Medicamentos $?)))
=>
    (retract ?i)
    (assert (continuar3))
)

; Borramos enfermedades inecesarias del registro

(defrule borrar2
    (continuar3)
    (Probabilidad_maxima ?h)
    ?i <- (Enfermedad (Nombre ?) (Sintomas $?) (Probabilidad ?p&:(> ?h ?p)) (Medicamentos $?))
=>
    (retract ?i)
)

(defrule continuar_2
    ?i <- (continuar3)
    ?j <- (Probabilidad_maxima ?h)
    (not (Enfermedad (Nombre ?) (Sintomas $?) (Probabilidad ?p&:(< ?h ?p)) (Medicamentos $?)))
=>
    (retract ?i ?j)
    (assert (continuar4))
)

; Mostrar enfermedades

(defrule mostrar_enfermedades
    (continuar4)
    ?p <- (Enfermedad (Nombre ?n) (Sintomas $?) (Probabilidad ?) (Medicamentos $?i))
    ?r <- (Medicamentos_necesarios $?t)
=>
    (retract ?r ?p)
    (assert(Medicamentos_necesarios $?t $?i))
    (printout t " --Tiene " ?n " para curarla se recomienda " $?i crlf)
)

(defrule continuar_3
    ?i <- (continuar4)
    (not (Enfermedad (Nombre ?) (Sintomas $?) (Probabilidad ?) (Medicamentos $?)))
=>
    (retract ?i)
    (printout t "--------------------------------------------------------------------" crlf)
    (assert (continuar5))
)

; Depuramos la lista de medicamentos

(defrule depurar1
    (continuar5)
    ?t <- (Medicamentos_necesarios $?q ?w $?e)
    (not (Medicamentos_necesarios_depurada $? ?w $?))
    ?y <- (Medicamentos_necesarios_depurada $?u)
=> 
    (retract ?t ?y)
    (assert (Medicamentos_necesarios $?q $?e))
    (assert (Medicamentos_necesarios_depurada $?u ?w))
)

(defrule depurar2
    (continuar5)
    ?t <- (Medicamentos_necesarios $?q ?w $?e)
    (Medicamentos_necesarios_depurada $? ?w $?)
=> 
    (retract ?t)
    (assert (Medicamentos_necesarios $?q $?e))
)

(defrule continuar_4
    ?i <- (continuar5)
    ?o <- (Medicamentos_necesarios)
=>
    (retract ?i ?o)
    (assert (continuar6))
)

(defrule mostrar_medicos
    (continuar6)
    (Medicamentos_necesarios_depurada $? ?w $?)
    (Medico (Tipo ?q) (Tratamientos $? ?w $?))
=>
    (printout t " - Para el tratamiendo de " ?w " puede acudir a " ?q crlf)
)
