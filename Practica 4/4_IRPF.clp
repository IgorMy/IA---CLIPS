(deftemplate Persona
    (field Nombre)
    (field Edad)
    (field NombreConyuge)
    (field PosicionEconomica)
    (field Salario)
)

(deffacts Datos_iniciales
    (Persona (Nombre Pedro) (Edad 40) (NombreConyuge Marta) (PosicionEconomica Desahogada) (Salario 1200))
    (Persona (Nombre Juan) (Edad 40) (NombreConyuge Lavinia) (PosicionEconomica Desahogada) (Salario 1500))
    (Persona (Nombre Marina) (Edad 40) (NombreConyuge Fran) (PosicionEconomica Desahogada) (Salario 600))
    (Persona (Nombre Fran) (Edad 60) (NombreConyuge Marina) (PosicionEconomica Desahogada) (Salario 800))
    (Persona (Nombre Paco) (Edad 60) (NombreConyuge Carlos) (PosicionEconomica Desahogada) (Salario 1800))
    (Persona (Nombre Lorena) (Edad 60) (NombreConyuge Marta) (PosicionEconomica Desahogada) (Salario 12000))
)

; A

(defrule Personas_de_60_años
    (Persona (Nombre ?Nombre) (Edad 60))
=>
	(printout t ?Nombre " tiene 60 años" crlf )
)


; B

(defrule Personas_de_40_años
    (Persona (Nombre ?Nombre) (Edad 40) (Salario ?Salario))
=>
    (printout t ?Nombre " tiene 40 años y tiene un salario de " ?Salario crlf )
)

; C

(defrule PersonaDatos
	(Persona (Nombre ?Nombre) (Edad ?Edad) (NombreConyuge ?NombreConyuge) (PosicionEconomica ?PosicionEconomica) (Salario ?Salario))
=>
	(printout t ?Nombre " tiene " ?Edad ", esta casado con " ?NombreConyuge " con una posicion economica " ?PosicionEconomica " y salario de " ?Salario  crlf )
)

; D

(defrule PersonaConyuge
	(Persona (Nombre ?Nombre) (NombreConyuge ?NombreConyuge) (PosicionEconomica Desahogada))
=>
	(printout t ?NombreConyuge " tiene la posición economica de se conyuge es Desahogada"  crlf )
)

; E

(defrule PersonaConyugeVector
	(Persona (NombreConyuge ?NombreConyuge) (PosicionEconomica Desahogada))
=>
	(assert(DatosFiscales ?NombreConyuge ConyugeDesahogado))
)

; F

(defrule EliminarDatos
    (Persona (NombreConyuge ?NombreConyuge) (PosicionEconomica Desahogada))
    ?Persona <- (Persona (PosicionEconomica Desahogada))
=>
    (retract ?Persona)
    (printout t ?NombreConyuge " ha sido eliminado" crlf)
)

; E

(defrule EliminarDatos2
    (Persona (Nombre ?Nombre) (PosicionEconomica Desahogada))
    ?Persona <- (Persona (PosicionEconomica Desahogada))
=>
    (retract ?Persona)
    (printout t ?Nombre " eliminado" crlf)
)
