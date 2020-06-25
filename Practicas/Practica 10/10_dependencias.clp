(deftemplate Producto 
    (field CodigoVendedor) 
    (field CodigoProducto)
    (field PVPProducto)
)

(defrule regla_1
    (Producto (CodigoVendedor ?z) (CodigoProducto ?x) (PVPProducto ?y))
    (Producto (CodigoVendedor ?h) (CodigoProducto ?x) (PVPProducto ?t))
    (test (<> ?y ?t))
    (not (no_cumplen ?h ? ?z))
=>
    (assert (no_cumplen ?z ?x ?h))
)

(defrule regla_2
    (Producto (CodigoVendedor ?z) (CodigoProducto ?x) (PVPProducto ?y))
    (Producto (CodigoVendedor ?h) (CodigoProducto ?x) (PVPProducto ?t))
    (test (= ?y ?t))
    (test (<> ?z ?h))
    (not (cumplen ?h ? ?z))
=>
    (assert (cumplen ?z ?x ?h))
)

(defrule pantalla_1
    ?h <- (no_cumplen ?x ?y ?z)
=>
    (printout t "Los vendedores " ?x " y " ?z " no cumplen la regla de dependencia en el articulo " ?y crlf)
)

(defrule pantalla_2
    ?h <- (cumplen ?x ?y ?z)
=>
    (printout t "Los vendedores " ?x " y " ?z " cumplen la regla de dependencia en el articulo " ?y crlf)
)