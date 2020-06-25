(deffacts Hechos 
	    (DatosExploracion
	        (Nombre Pedro)
	        (Sintomas picor rojo vesiculas inflamada))
	    (DatosExploracion    
	        (Nombre Juan)
	        (Sintomas picor rojo vesiculas normal))
	    (DatosExploracion    
	        (Nombre Erica)
	        (Sintomas picor rojo))
	    (DatosExploracion
	        (Nombre Marta)
	        (Sintomas vesiculas inflamada)))

(deffacts Hecho2
	    (FichaPaciente 
	        (Nombre Pedro))
	    (FichaPaciente
	        (Nombre Juan))
	    (FichaPaciente
	        (Nombre Erica))
	    (FichaPaciente
	        (Nombre Marta)))


(deffacts Hecho3
	(Diagnostico
		(Nombre Pedro)
		(Resultado positivo)
		(ProximaRevision Marzo))
	(Diagnostico
		(Nombre Juan)
		(Resultado negativo)
		(ProximaRevision Junio))
	(Diagnostico
		(Nombre Erica)
		(Resultado positivo)
		(ProximaRevision Junio))
	(Diagnostico
		(Nombre Marta)
		(Resultado negativo)
		(ProximaRevision Abril)))

(deffacts Hecho4
	(DiagnosticoPersonas 
		(Nombre Pedro)
		(Edad 30)
		(Tipo Es_adulto))
	(DiagnosticoPersonas
		(Nombre Juan)
		(Edad 10)
		(Tipo Es_adulto))
	(DiagnosticoPersonas
		(Nombre Erica)
		(Edad 0)
		(Tipo Es_un_bebe))
	(DiagnosticoPersonas
		(Nombre Marta)
		(Edad 1)
		(Tipo Es_un_bebe)))

(deffacts Hecho5
	(Terapia
		(Nombre Pedro)
		(PrincipioActivo grave)
		(Posologia corticoide))
	(Terapia
		(Nombre Juan)
		(PrincipioActivo leve)
		(Posologia corticoide))
	(Terapia
		(Nombre Erica)
		(PrincipioActivo grave)
		(Posologia corticoide))
	(Terapia
		(Nombre Marta)
		(PrincipioActivo leve)
		(Posologia crema_hidratante)))

(deffacts Hecho6
	(Terapia2
		(Nombre Pedro)
		(Posologia corticoide))
	(Terapia2
		(Nombre Juan)
		(Posologia corticoide))
	(Terapia2
		(Nombre Erica)
		(Posologia corticoide))
	(Terapia2
		(Nombre Marta)
		(Posologia crema_hidratante)))
