
-- INSERT PAIS
INSERT INTO pais VALUES
(1,'Argentina'),
(2,'Chile'),
(3,'Uruguay'),
(4,'Brasil');

-- INSERT PROVINCIAS
INSERT INTO provincia VALUES
(1,'Cordoba',1),
(2,'Buenos Aires',1),
(3,'Santa Fe',1),
(4,'Tocopilla',2),
(5,'Colonia',3),
(6,'Durazno',3),
(7,'Minas Gerais',4);

-- INSERT CIUDADES
INSERT INTO ciudad VALUES
(1,'Villa Maria','5900',1),
(2,'Villa Nueva','5900',1),
(3,'General Deheza','5400',1),
(4,'Tocopilla','1234',4),
(5,'Belo Horizonte','4324',7);

-- INSERT TIPO IVA
INSERT INTO tipo_iva VALUES
(1,'RI',21),
(2,'M',21),
(3,'CF',21);

-- INSERT CLIENTES
INSERT INTO cliente VALUES
(1,'Diego Bisego',1,'32934045','Bistech',1,10),
(2,'Telma Cordoba',3,'3245543',null,1,20),
(3,'Matias Perez',2,'12332123',null,4,0),
(4,'Dorrego Lorial',1,'41323321','Carioca Teach',5,10);

-- INSERT PROVEEDOR
INSERT INTO proveedor VALUES
(1,'AGD',1,'30324456439','AGD',1),
(2,'Molfino',1,'3034345439','MOLFINO',1),
(3,'Lucas Gonzalez ',2,'20458762349','La Marchesina',2),
(4,'Jose Pereyra',2,'45876234',null,3),
(5,'Brian Gomez',2,'14573456',null,3);

-- INSERT TIPO PRODUCTO
INSERT INTO tipo_producto VALUES
(1,'Comestible Liquido'),
(2,'Comestible Solido');

-- INSERT PRODUCTO
INSERT INTO producto VALUES
(1,'Aceite',2000,5000,1),
(2,'Aceitunas',1000,3000,2),
(3,'Huevos',500,2000,2),
(4,'Vinagre',200,6000,1),
(5,'Morrones',100,4500,2);

-- INSERT COMPRA
INSERT INTO compra VALUES
(1,1,12000),
(2,2,5000),
(3,2,8000),
(4,3,20000),
(5,4,34000),
(6,5,3000);

-- INSERT COMPRA DETALLE
INSERT INTO compra_detalle VALUES
(1,1,1,2000,2,4000),
(2,2,1,1000,8,8000),
(3,4,2,200,25,5000),
(4,2,3,1000,4,4000),
(5,5,3,100,40,4000),
(6,1,4,2000,10,20000),
(7,2,5,1000,20,20000),
(8,4,5,200,70,14000),
(9,3,6,500,6,3000);

-- INSERT TIPO PERSONA
INSERT INTO tipo_persona VALUES
(1,'Cliente'),
(2,'Proveedor');

-- INSERT EMAIL
INSERT INTO email VALUES
(1,1,'diegobisego@gmail.com',1),
(2,1,'BistechSRL@gmail.com',1),
(3,1,'AGD@gmail.com',2),
(4,1,'Aceitera@gmail.com',2),
(5,2,'Telma@gmail.com',1);

-- INSERT TELEFONO
INSERT INTO telefono VALUES
(1,1,'3534774748',1),
(2,1,'3533243243',1),
(3,2,'3532342324',1),
(4,3,'2342324343',1),
(5,1,'5464646546',2),
(6,2,'4353454535',2),
(7,2,'6757676565',2);

-- INSERT VENTA
INSERT INTO venta VALUES
(1,1,10000),
(2,2,4000),
(3,4,4600),
(4,3,5000),
(5,2,300),
(6,1,2000),
(7,4,8500);

-- INSERT VENTA DETALLE
INSERT INTO venta_detalle VALUES
(1,1,1,2000,4,8000),
(2,2,1,1000,2,2000),
(3,1,2,2000,2,2000),
(4,3,2,500,2,2000),
(5,4,3,200,23,4600),
(6,3,4,500,10,5000),
(7,5,5,100,3,300),
(8,2,6,1000,2,2000),
(9,1,7,2000,4,2000),
(10,3,7,500,1,500);