CREATE TABLE ubicacion(
	ubicacion_id SERIAL PRIMARY KEY,
	descripcion VARCHAR(70) NOT NULL,
	calle VARCHAR(30) NOT NULL,
	nro_casa INT NOT NULL
	
);

CREATE TABLE clientes(
	ci_id INT NOT NULL PRIMARY KEY,
	nombres VARCHAR(30) NOT NULL,
	apellidos VARCHAR(30) NOT NULL,
	telefono INT NOT NULL,
	contraseña TEXT NOT NULL,
	id_ubicacion INT,
	FOREIGN KEY (id_ubicacion) REFERENCES ubicacion(ubicacion_id)
);

CREATE TABLE repartidor(
	ci_id INT NOT NULL PRIMARY KEY,
	nombre VARCHAR(30) NOT NULL,
	apellido VARCHAR(30) NOT NULL,
	telefono INT NOT NULL,	
	dt_nacimiento DATE NOT NULL,
	estado BOOLEAN NOT NULL,
	modelo VARCHAR(20),
	placa VARCHAR(15) NOT NULL,
	marca VARCHAR(20) NOT NULL
);

CREATE TABLE sucursal(
	id_sucursal INT NOT NULL PRIMARY KEY,
	nombre VARCHAR(30) NOT NULL,
	direccion VARCHAR(30) NOT NULL
);

CREATE TABLE hamburguesa(
	id_hamburguesa INT NOT NULL PRIMARY KEY,
	nombre VARCHAR(20) NOT NULL,
	precio DECIMAL(10,2) NOT NULL
);
 	CREATE TABLE acompañamiento(
	id INT NOT NULL PRIMARY KEY,
	nombre VARCHAR(30) NOT NULL,
	precio NUMERIC(10,2) NOT NULL
);

CREATE TABLE pedido_factura(
    pedido_factura_id INT NOT NULL PRIMARY KEY,
    detalle VARCHAR(30) NOT NULL,
    tipoPago VARCHAR(20) NOT NULL,
    nit VARCHAR(20),
    estado VARCHAR(20) NOT NULL,
    dt_emisión TIMESTAMP,
	ci_cliente INT,
	ci_repartidor INT,
	sucursal_id INT,
	FOREIGN KEY (ci_cliente) REFERENCES clientes(ci_id),
	FOREIGN KEY (ci_repartidor) REFERENCES repartidor(ci_id),
	FOREIGN KEY (sucursal_id) REFERENCES sucursal(id_sucursal)
    );

CREATE TABLE detalle_pedidos(
	detalle_pedido_id INT NOT NULL PRIMARY KEY,
	descripcion VARCHAR(30) NOT NULL,
	cantidad INT NOT NULL,
	id_hamburguesa INT,
	id_acompañamiento INT,
	id_factura INT,
	FOREIGN KEY (id_hamburguesa) REFERENCES hamburguesa(id_hamburguesa),
	FOREIGN KEY (id_acompañamiento) REFERENCES acompañamiento(id),
	FOREIGN KEY (id_factura) REFERENCES pedido_factura(pedido_factura_id)
	
);

CREATE TABLE repartidor_logs(
    log_id SERIAL PRIMARY KEY,
	dtoperacion TIMESTAMP,
	ci_id INT,
	nombre varchar(30),
	apellido varchar(30),
	modelo varchar(20),
	placa varchar(15),
	marca varchar(20)
);
