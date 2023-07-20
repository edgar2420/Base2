CREATE TYPE incident_types AS ENUM ('Acceso', 'Error','Disabled');

CREATE TABLE Usuarios(
    codigo_id VARCHAR(20) NOT NULL PRIMARY KEY,
    snickname VARCHAR(30) NOT NULL,
    spassword TEXT NOT NULL,	
    snombre VARCHAR(20) NOT NULL,
    sapellido VARCHAR(20) NOT NULL,
    email TEXT,
    fecha_creacion TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE
    );

CREATE TABLE login_logs(
 incident_id SERIAL PRIMARY KEY NOT NULL,
 dtIncident TIMESTAMP NOT NULL,
 user_id VARCHAR(20) REFERENCES Usuarios(codigo_id),
 incident_type incident_types NOT NULL
);

INSERT INTO Usuarios VALUES ('19-ROO-05-R-26-R','root','root','root','root','root@nur.edu','20190526',false),
('19-ADM-05-A-15-S','admin','admin','admin','system','admin@nur.edu','20190515',false),
('18-USE-08-U-03-P','user','password','user','password','user@nur.edu','2018-08-03',DEFAULT);
