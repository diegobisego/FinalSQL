
CREATE DATABASE DistribuidoraDiegoBisego;

USE DistribuidoraDiegoBisego;

CREATE TABLE PAIS (
id_pais INT AUTO_INCREMENT NOT NULL,
 nombre VARCHAR(50) NOT NULL,
 PRIMARY KEY (id_pais)
);

CREATE TABLE PROVINCIA (
id_provincia INT AUTO_INCREMENT NOT NULL,
 nombre VARCHAR(50) NOT NULL,
 id_pais INT NOT NULL,
 PRIMARY KEY (id_provincia),
 CONSTRAINT FOREIGN KEY id_pais (id_pais) REFERENCES Pais (id_pais)
);

CREATE TABLE CIUDAD (
id_ciudad INT AUTO_INCREMENT NOT NULL,
 nombre VARCHAR(50) NOT NULL,
 CP VARCHAR(50) NOT NULL,
 id_provincia INT NOT NULL,
 PRIMARY KEY (id_ciudad),
 CONSTRAINT FOREIGN KEY id_provincia (id_provincia) REFERENCES Provincia (id_provincia)
);

CREATE TABLE TIPO_IVA (
id_tipo_iva INT AUTO_INCREMENT NOT NULL,
 nombre VARCHAR(50) NOT NULL,
 tasa DECIMAL(9,2) NOT NULL,
 PRIMARY KEY (id_tipo_iva)
);

CREATE TABLE CLIENTE (
id_cliente INT AUTO_INCREMENT NOT NULL,
 nombre VARCHAR(50) NOT NULL,
 id_tipo_iva INT NOT NULL,
 num_doc VARCHAR(11) NOT NULL,
 nombre_empresa VARCHAR(50),
 id_ciudad INT NOT NULL,
 descuento INT NOT NULL,
 PRIMARY KEY (id_cliente),
 CONSTRAINT FOREIGN KEY id_tipo_iva (id_tipo_iva) REFERENCES TIPO_IVA (id_tipo_iva),
 CONSTRAINT FOREIGN KEY id_ciudad (id_ciudad) REFERENCES ciudad (id_ciudad)
);

CREATE TABLE TIPO_PRODUCTO (
id_tipo_producto INT AUTO_INCREMENT NOT NULL,
 nombre VARCHAR(50) NOT NULL,
 PRIMARY KEY (id_tipo_producto)
);

CREATE TABLE PRODUCTO (
id_producto INT AUTO_INCREMENT NOT NULL,
 nombre VARCHAR(50) NOT NULL,
 precio DECIMAL(9,2) NOT NULL,
 stock DECIMAL(9,2),
 id_tipo_producto INT NOT NULL,
 PRIMARY KEY (id_producto),
 CONSTRAINT FOREIGN KEY id_tipo_producto (id_tipo_producto) REFERENCES
TIPO_PRODUCTO (id_tipo_producto)
);

CREATE TABLE VENTA (
id_venta INT AUTO_INCREMENT NOT NULL,
 id_cliente INT NOT NULL,
 monto_total DECIMAL(9,2) NOT NULL,
 PRIMARY KEY (id_venta),
 CONSTRAINT FOREIGN KEY id_cliente (id_cliente) REFERENCES CLIENTE (id_cliente)
);

CREATE TABLE VENTA_DETALLE (
id_venta_detalle INT AUTO_INCREMENT NOT NULL,
 id_producto INT NOT NULL,
 id_venta INT NOT NULL,
 prec_unit DECIMAL(9,2) NOT NULL,
 cantidad DECIMAL(9,2) NOT NULL,
monto_final DECIMAL(9,2) NOT NULL,
 PRIMARY KEY (id_venta_detalle),
 CONSTRAINT FOREIGN KEY id_producto (id_producto) REFERENCES PRODUCTO
(id_producto),
 CONSTRAINT FOREIGN KEY id_venta (id_venta) REFERENCES VENTA (id_venta)
);

CREATE TABLE PROVEEDOR (
id_proveedor INT AUTO_INCREMENT NOT NULL,
 nombre VARCHAR(50) NOT NULL,
 id_tipo_iva INT NOT NULL,
 num_doc VARCHAR(11) NOT NULL,
 nombre_empresa VARCHAR(50),
 id_ciudad INT NOT NULL,
 PRIMARY KEY (id_proveedor),
 CONSTRAINT FOREIGN KEY id_tipo_iva_prov (id_tipo_iva) REFERENCES TIPO_IVA
(id_tipo_iva),
 CONSTRAINT FOREIGN KEY id_ciudad_prov (id_ciudad) REFERENCES CIUDAD (id_ciudad)
);

CREATE TABLE COMPRA (
id_compra INT AUTO_INCREMENT NOT NULL,
 id_proveedor INT NOT NULL,
 monto_total DECIMAL(9,2) NOT NULL,
 PRIMARY KEY (id_compra),
 CONSTRAINT FOREIGN KEY id_proveedor (id_proveedor) REFERENCES PROVEEDOR
(id_proveedor)
);

CREATE TABLE COMPRA_DETALLE (
id_compra_detalle INT AUTO_INCREMENT NOT NULL,
 id_producto INT NOT NULL,
 id_compra INT NOT NULL,
 prec_unit DECIMAL(9,2) NOT NULL,
 cantidad DECIMAL(9,2) NOT NULL,
monto_final DECIMAL(9,2) NOT NULL,
 PRIMARY KEY (id_compra_detalle),
 CONSTRAINT FOREIGN KEY id_producto_comp (id_producto) REFERENCES PRODUCTO
(id_producto),
 CONSTRAINT FOREIGN KEY id_compra_comp (id_compra) REFERENCES COMPRA
(id_compra)
);

CREATE TABLE TIPO_PERSONA (
id_tipo INT AUTO_INCREMENT NOT NULL,
 tipo VARCHAR(50) NOT NULL,
 PRIMARY KEY (id_tipo)
);

CREATE TABLE EMAIL (
id_email INT AUTO_INCREMENT NOT NULL,
id_cl_prov INT NOT NULL,
 email VARCHAR(50) NOT NULL,
 id_tipo_persona INT NOT NULL,
 PRIMARY KEY (id_email),
 CONSTRAINT FOREIGN KEY id_tipo_persona_email (id_tipo_persona) REFERENCES
TIPO_PERSONA (id_tipo)
);

CREATE TABLE TELEFONO (
id_telefono INT AUTO_INCREMENT NOT NULL,
id_cl_prov INT NOT NULL,
 telefono VARCHAR(50) NOT NULL,
 id_tipo_persona INT NOT NULL,
 PRIMARY KEY (id_telefono),
 CONSTRAINT FOREIGN KEY id_tipo_persona_tel (id_tipo_persona) REFERENCES
TIPO_PERSONA (id_tipo)
);

CREATE TABLE LOG_VENTA_DETALLE (
 id_log INT AUTO_INCREMENT NOT NULL,
 id_venta INT NOT NULL,
 id_cliente INT NOT NULL,
 monto_total DECIMAL(9,2) NOT NULL,
 fecha DATE NOT NULL,
 hora TIME NOT NULL,
 user_db VARCHAR(45) NOT NULL,
 PRIMARY KEY (id_log),
 UNIQUE KEY id_log_UNIQUE (`id_log`)
);

-- STORE PROCEDURE
-- SP 1 -- ORDENAMIENTO SEGUN PARAMETRO
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `borrar_Registros_sp`(in tabla CHAR(20), nombre_campo CHAR(20), campo CHAR(20))
BEGIN
	SET @error_carga = 0;
	IF tabla = '' or nombre_campo = '' or campo = '' THEN
		SET @vacio = 'SELECT \'ERROR: campos vacios\' AS Error';
        set @error_carga = 1;
    ELSE
		SET @sentencia = CONCAT('DELETE FROM ', tabla, ' WHERE ',  nombre_campo, ' = ',campo); 
	END IF;       
    
    PREPARE querySQL FROM @sentencia;    
    EXECUTE querySQL;
    DEALLOCATE PREPARE querySQL;
    
END$$
DELIMITER ;


-- SP 2 -- ORDENAR CLIENTES

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ordenar_clientes`(in campo_para_ordenar CHAR(20), tipo_de_orden CHAR(20))
BEGIN
	IF campo_para_ordenar <> '' THEN
		SET @campo_orden = CONCAT('ORDER BY ', campo_para_ordenar, ' ',tipo_de_orden);
    ELSE
		SET @campo_orden = '';
	END IF;       
    
    SET @clausula = CONCAT('SELECT * FROM CLIENTE ', @campo_orden);
    
    PREPARE querySQL FROM @clausula;
    
    EXECUTE querySQL;
    DEALLOCATE PREPARE querySQL;
END$$
DELIMITER ;



-- FUNCIONES
-- FUNCION 1 - DECUENTO DE PRECIO

DELIMITER $$
CREATE FUNCTION venta_con_descuento (porcentaje_descuento DECIMAL(9,2), precio
DECIMAL(9,2))
RETURNS DECIMAL (9,2)
BEGIN
DECLARE monto_con_descuento DECIMAL(9,2);
 SET monto_con_descuento = precio - ((precio * porcentaje_descuento) / 100 );
 RETURN monto_con_descuento;
 END$$
DELIMITER ;


-- FUNCION DOS - CANTIDAD DE CLIENTES POR PAIS
DELIMITER $$
CREATE FUNCTION clientes_por_pais (id_del_pais INT)
RETURNS INT
BEGIN
DECLARE CANTIDAD INT;

 SELECT COUNT(C.id_cliente) INTO CANTIDAD FROM CLIENTE AS C
 INNER JOIN CIUDAD CI ON C.ID_CIUDAD = CI.ID_CIUDAD
 INNER JOIN PROVINCIA P ON P.ID_PROVINCIA = CI.ID_PROVINCIA
 INNER JOIN PAIS PA ON PA.ID_PAIS = P.ID_PAIS
 WHERE PA.ID_PAIS = id_del_pais;

 RETURN CANTIDAD;
END$$
DELIMITER ;


TRIGGER
-- TRIGGER AFETER - AGREGA UN DETALLE DEL LOG DE VENTA
DELIMITER $$
CREATE TRIGGER tr_detalle_venta_log
AFTER INSERT ON venta
FOR EACH ROW
BEGIN
insert into log_venta_detalle
values (null,NEW.id_venta,
NEW.id_cliente,NEW.monto_total,current_date(),current_time(), session_user());
END$$
DELIMITER ;
-- TRIGGER BEFOR - AGREGA UN 10% DE DESCUENTO AL CLIENTE SI TIENE MAS DE 5 COMPRAS
DELIMITER $$
CREATE TRIGGER tr_descuento_por_ventas
BEFORE INSERT ON venta
FOR EACH ROW
BEGIN
 DECLARE contador INT;

 SELECT COUNT(*)
 INTO contador
 FROM venta
 where id_cliente = NEW.id_cliente;

 IF contador > 5 THEN
 UPDATE cliente
 SET descuento = 10
 where id_cliente = NEW.id_cliente;
 END IF;
END$$
DELIMITER ;

-- VISTAS
-- 1 MOSTRAR LOS CLIENTES Y A QUE CIUDAD PERTENECE
CREATE OR REPLACE VIEW Clientes_x_Ciudad_vw
AS
select cl.nombre as Nombre_Cliente, c.nombre as Ciudad
from cliente cl
inner join ciudad c on cl.id_ciudad = c.id_ciudad;

-- 2 MOSTRAR LOS CLIENTES CON VENTAS MAYORES A 2000
CREATE OR REPLACE VIEW clientes_ventas_mayores_2000_vw 
AS 
select c.nombre AS Nombre_Cliente,sum(v.monto_total) AS Monto_Total 
from (venta v join cliente c on (v.id_cliente = c.id_cliente)) 
where v.monto_total > 2000 
group by c.nombre;


-- 3 MOSTRAR LAS COMPRAS MAYORES A 5000
CREATE OR REPLACE VIEW Compras_Mayores_5000_vw
AS
select p.nombre as Nombre_Proveedor, SUM(c.monto_total) as Monto_Total
from compra c
inner join proveedor p on c.id_proveedor = p.id_proveedor
where c.monto_total > 5000
group by p.nombre;

-- 4 CLIENTES SOLO DEL PAIS ARGENTINA
CREATE OR REPLACE VIEW Clientes_Solo_Argentina_vw
AS
select c.nombre as Nombre_Cliente, pa.nombre as Pais
from cliente c
inner join ciudad ci on c.id_ciudad = ci.id_ciudad
inner join provincia pr on pr.id_provincia = ci.id_provincia
inner join pais pa on pa.id_pais = pr.id_pais
where pa.id_pais = 1;

-- 5 TODAS LAS VENTAS POR TIPO PRODUCTO LIQUIDO
CREATE OR REPLACE VIEW Ventas_Tipo_Producto_Liquido_vw
AS
select pr.nombre as Nombre_Produto, tp.nombre as Nombre_Tipo_Producto,
SUM(v.monto_total) as Monto_Venta
from venta v
inner join venta_detalle vd on v.id_venta = vd.id_venta
inner join producto pr on vd.id_producto = pr.id_producto
inner join tipo_producto tp on pr.id_tipo_producto = tp.id_tipo_producto
where tp.id_tipo_producto = 1
group by pr.nombre