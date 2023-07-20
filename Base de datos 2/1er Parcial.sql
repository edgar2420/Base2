create user dcasasola with superuser login password 'root';

create schema clinicaA;
create schema clinicaB;

-- Clinica A

create extension postgres_fdw;

create server svr_remoto1
foreign data wrapper postgres_fdw
options (host '127.0.0.1', port '5432', dbname 'clínicaA');

create user mapping for postgres
server svr_remoto1 options(user 'dcasasola', password 'root');

import foreign schema public
from server svr_remoto1 into clinicaa;

-- Clinica B

create server svr_remoto2
foreign data wrapper postgres_fdw
options (host '127.0.0.1', port '5432', dbname 'clínicaB');

create user mapping for postgres
server svr_remoto2 options(user 'dcasasola', password 'root');

import foreign schema public
from server svr_remoto2 into clinicab;

--Consulta #1
select * from personas;

select p.snombre ||' '|| p.sapellido as, C.dtfecha 
from clinicaa.consultas C
join  personas P on C.paciente_id = P.codigo_id
UNION
select p.snombre ||' '|| p.sapellido, C.dtfecha 
from clinicab.consultas C
join  personas P on C.paciente_id = P.codigo_id;

-- Consulta #2
select count(c.doctor_id)
from clinicab.consultas C
join personas P on c.doctor_id = p.codigo_id
group by doctor_id;
UNION
select count(c.doctor_id)
from clinicab.consultas C
join personas P on c.doctor_id = p.codigo_id
group by doctor_id;

-- Consulta #3


-- Consulta #4
select p.snombre, p.codigo_id, D.dtfecha
from clinicab.doctores c
join personas P on p.codigo_id = c.codigo_id
join clinicaa.consultas D on D.paciente_id = c.codigo_id

-- Consulta #5
