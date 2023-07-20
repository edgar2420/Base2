-- PARCIAL 2
CREATE DATABASE parcial2;
USE parcial2;

-- MONEDAS (>simbolo<,nombre)
	-- $us, Dolares Americanos
    -- € , Euro

CREATE TABLE monedas(
	simbolo varchar(5) primary key,
    nombre varchar(50)
    );

INSERT INTO monedas VALUES ('Bs','Bolivianos'),
('$us','Dolares Americanos'),('UFV','Unidad Fomento Vivienda'),('€','Euro');


-- GESTION (>numero<, activo)
	-- 2017,t ; 2016,f
CREATE TABLE gestiones(
	numero int PRIMARY KEY,
    activo boolean DEFAULT true
);
INSERT INTO gestiones VALUES(2017,true);
-- TASA_CAMBIOS(>codigo<,fecha,
-- moneda_id,valor)
	-- 1, 05/08/2017, $us, 6.96
CREATE TABLE tasa_cambios(
	codigo int primary key auto_increment,
    fecha date,
    moneda_id varchar(5),
    valor numeric(8,5),
    FOREIGN KEY (moneda_id) REFERENCES monedas(simbolo)
);

INSERT INTO tasa_cambios VALUES
(DEFAULT,'2017-08-05','$us',6.96),
(DEFAULT,'2017-07-15','$us',6.95),
(DEFAULT,'2017-06-07','$us',6.943),
(DEFAULT,'2017-05-09','$us',6.932),
(DEFAULT,'2017-04-12','$us',6.912),
(DEFAULT,'2017-03-16','$us',6.936),
(DEFAULT,'2017-02-04','$us',6.975),
(DEFAULT,'2017-01-01','$us',6.965),
(DEFAULT,'2017-09-05','$us',6.961),
(DEFAULT,'2017-10-25','$us',6.966),
(DEFAULT,'2017-11-15','$us',6.969),
(DEFAULT,'2017-08-05','UFV',2.54),
(DEFAULT,'2017-07-04','UFV',2.22199),
(DEFAULT,'2017-06-07','UFV',2.22220),
(DEFAULT,'2017-05-12','UFV',2.22241),
(DEFAULT,'2017-04-15','UFV',2.22262),
(DEFAULT,'2017-03-17','UFV',2.22283),
(DEFAULT,'2017-02-09','UFV',2.22304),
(DEFAULT,'2017-01-27','€',7.49531);
(DEFAULT,'2017-02-22','€',7.52111);
(DEFAULT,'2017-03-12','€',7.65664);
(DEFAULT,'2017-04-02','€',7.45674);
(DEFAULT,'2017-05-06','€',7.53450);
(DEFAULT,'2017-05-18','€',7.52002);
