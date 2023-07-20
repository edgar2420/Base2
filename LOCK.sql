CREATE DATABASE lock;
USE lock;

CREATE TABLE tblinterfaces (
    codigo_id text NOT NULL,
    snombre text NOT NULL,
    sdescripcion text
);

CREATE TABLE tblpermisos (
    codigo_id bigint NOT NULL,
    rol_id integer,
    interfaz_id text,
    soperacion text,
    sdescripcion text,
    bstate boolean,
    bdeleted boolean NOT NULL,
    access_id integer NOT NULL
);

CREATE TABLE tblroles (
    codigo_id integer NOT NULL,
    snombre text NOT NULL,
    iestado_fl integer NOT NULL,
    bdeleted boolean NOT NULL,
    access_id integer NOT NULL
);

CREATE TABLE tblusuarios (
    codigo_id integer NOT NULL,
    rol_id integer NOT NULL,
    scuenta text NOT NULL,
    spassword text NOT NULL,
    scorreo text,
    iestado_fl integer NOT NULL,
    bdeleted boolean NOT NULL,
    access_id integer NOT NULL
);

INSERT INTO tblinterfaces VALUES ('Litepos-IA', 'InternalAnular', 'Interfaz para ver el registro y el detalle de las facturas anuladas y validas mas una visualizacion');
INSERT INTO tblinterfaces VALUES ('Litepos-IE', 'InternalEmpresa', 'Interfaz para ver las opciones generales y los datos de las empresa');
INSERT INTO tblinterfaces VALUES ('Litepos-IP', 'InternalProductos', 'Interfaz para ver y modificar los productos almacenados y disponibles para las ventas');
INSERT INTO tblinterfaces VALUES ('Litepos-IR', 'InternalReporte', 'Interfaz para ver los reportes de facturacion de ciertos periodos');
INSERT INTO tblinterfaces VALUES ('Litepos-IV', 'InternalVentas', 'Interfaz para realizar las ventas de los productos');

INSERT INTO tblpermisos VALUES (5, 3, 'Litepos-IE', 'U', 'Actualizar', true, false, 0);
INSERT INTO tblpermisos VALUES (14, 3, 'Litepos-IV', 'U', 'Actualizar', false, false, 0);
INSERT INTO tblpermisos VALUES (4, 3, 'Litepos-IE', 'I', 'Insertar', true, false, 0);
INSERT INTO tblpermisos VALUES (7, 3, 'Litepos-IP', 'I', 'Insertar', true, false, 0);
INSERT INTO tblpermisos VALUES (13, 3, 'Litepos-IV', 'I', 'Insertar', true, false, 0);
INSERT INTO tblpermisos VALUES (17, 3, 'Litepos-IE', 'S', 'Seleccionar', true, false, 0);
INSERT INTO tblpermisos VALUES (18, 3, 'Litepos-IP', 'S', 'Seleccionar', true, false, 0);
INSERT INTO tblpermisos VALUES (20, 3, 'Litepos-IV', 'S', 'Seleccionar', true, false, 0);
INSERT INTO tblpermisos VALUES (19, 3, 'Litepos-IR', 'S', 'Seleccionar', true, false, 0);
INSERT INTO tblpermisos VALUES (8, 3, 'Litepos-IP', 'U', 'Actualizar', false, false, 0);
INSERT INTO tblpermisos VALUES (6, 3, 'Litepos-IE', 'D', 'Eliminar', false, false, 0);
INSERT INTO tblpermisos VALUES (9, 3, 'Litepos-IP', 'D', 'Eliminar', false, false, 0);
INSERT INTO tblpermisos VALUES (15, 3, 'Litepos-IV', 'D', 'Eliminar', false, false, 0);
INSERT INTO tblpermisos VALUES (21, 3, 'Litepos-IE', 'BD','Acceso Dosificacion', true, false, 0);
INSERT INTO tblpermisos VALUES (22, 3, 'Litepos-IE', 'BP', 'Acceso Parametros', true, false, 0);
INSERT INTO tblpermisos VALUES (23, 3, 'Litepos-IE', 'BC', 'Acceso Conexion', true, false, 0);
INSERT INTO tblpermisos VALUES (26, 3, 'Litepos-IR', 'E', 'Obtener reportes', true, false, 0);
INSERT INTO tblpermisos VALUES (27, 3, 'Litepos-IR', 'L', 'Filtrar Datos', true, false, 0);
INSERT INTO tblpermisos VALUES (28, 3, 'Litepos-IV', 'F', 'Buscar Facturas', true, false, 0);
INSERT INTO tblpermisos VALUES (2, 3, 'Litepos-IA', 'U', 'Actualizar', false, false, 0);
INSERT INTO tblpermisos VALUES (25, 3, 'Litepos-IA', 'P', 'Imprimir', true, false, 0);
INSERT INTO tblpermisos VALUES (24, 3, 'Litepos-IA', 'A', 'Anular', true, false, 0);
INSERT INTO tblpermisos VALUES (16, 3, 'Litepos-IA', 'S', 'Buscar', true, false, 0);
INSERT INTO tblpermisos VALUES (1, 3, 'Litepos-IA', 'I', 'Insertar', true, false, 0);
INSERT INTO tblpermisos VALUES (3, 3, 'Litepos-IA', 'D', 'Eliminar', false, false, 0);
INSERT INTO tblpermisos VALUES (11, 3, 'Litepos-IR', 'U', 'Actualizar', false, false, 0);
INSERT INTO tblpermisos VALUES (12, 3, 'Litepos-IR', 'D', 'Eliminar', true, false, 0);
INSERT INTO tblpermisos VALUES (10, 3, 'Litepos-IR', 'I', 'Insertar', false, false, 0);

INSERT INTO tblroles VALUES (8, 'clientes', 1, false, 0);
INSERT INTO tblroles VALUES (14, 'contadores', 1, false, 0);
INSERT INTO tblroles VALUES (18, 'operadores', 1, false, 0);
INSERT INTO tblroles VALUES (19, 'gerencia', 1, false, 0);
INSERT INTO tblroles VALUES (21, 'visor', 1, false, 0);
INSERT INTO tblroles VALUES (22, 'monitor', 1, false, 0);
INSERT INTO tblroles VALUES (3, 'Administradores', 1, false, 0);

INSERT INTO tblusuarios VALUES (1, 8, 'test', '$1$68oC8s/2$H2iLmLAlrTChyCzusBGLq1', 'test@test.com', 1, false, 0);
INSERT INTO tblusuarios VALUES (2, 21, 'usuario', '$1$wdgfD7N7$tCJKnoTE5vX6wXTqnTQYX.', 'test2@test.com', 1, false, 0);
INSERT INTO tblusuarios VALUES (3, 3, 'gerencia', '$1$TYbMonTa$g..Mx54cPIDYyjkvcgjLf0', 'test3@test.com', 1, false, 0);
INSERT INTO tblusuarios VALUES (4, 3, 'opnur1', '$1$uVMX88PY$FmXDgscd7qFlmzJjPqrtn0', 'opnur@base2.com', 1, false, 0);
INSERT INTO tblusuarios VALUES (6, 3, 'opnur2', '$1$egce9Arj$RPOr.QSl7oF1COHO5SUWL1', 'test@test.com', 1, false, 0);
INSERT INTO tblusuarios VALUES (5, 3, 'sistemas', '$1$CsG8ra7f$Zs.vvgw7SG8GWZPhvlgNv1', '', 1, true, 0);
INSERT INTO tblusuarios VALUES (7, 8, 'vpnusr', '$1$wHY/pr1T$A0CPo0MeMbgfLgwSEJAuq/', 'admin@base2.end', 1, false, 0);


ALTER TABLE tblinterfaces ADD CONSTRAINT tblinterfaces_pkey PRIMARY KEY (codigo_id);

ALTER TABLE tblinterfaces ADD CONSTRAINT tblinterfaces_snombre_key UNIQUE (snombre);

ALTER TABLE tblpermisos
    ADD CONSTRAINT tblpermisos_pkey PRIMARY KEY (codigo_id);

ALTER TABLE tblpermisos
    ADD CONSTRAINT tblpermisos_rol_id_interfaz_id_soperacion_key UNIQUE (rol_id, interfaz_id, soperacion);

ALTER TABLE tblroles
    ADD CONSTRAINT tblroles_pkey PRIMARY KEY (codigo_id);

ALTER TABLE tblroles
    ADD CONSTRAINT tblroles_snombre_key UNIQUE (snombre);

ALTER TABLE tblusuarios
    ADD CONSTRAINT tblusuarios_pkey PRIMARY KEY (codigo_id);

ALTER TABLE tblusuarios
    ADD CONSTRAINT tblusuarios_scuenta_key UNIQUE (scuenta);

ALTER TABLE tblpermisos
    ADD CONSTRAINT tblpermisos_interfaz_id_fkey FOREIGN KEY (interfaz_id) REFERENCES tblinterfaces(codigo_id);

ALTER TABLE tblpermisos
    ADD CONSTRAINT tblpermisos_rol_id_fkey FOREIGN KEY (rol_id) REFERENCES tblroles(codigo_id);

ALTER TABLE tblusuarios
    ADD CONSTRAINT tblusuarios_rol_id_fkey FOREIGN KEY (rol_id) REFERENCES tblroles(codigo_id);

