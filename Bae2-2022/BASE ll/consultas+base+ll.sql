 use sistema_inventario;
show tables;


insert into centro values ('1','ccn-306');
insert into centro values ('2','Ccn-305');
insert into centro values ('3','ccn-304');
insert into centro values ('4','ccn-303');


insert into computadora values ('1','m-1','123456',1);
insert into computadora values ('2','m-2','123456',2);
insert into computadora values ('3','m-3','123456',3);
insert into computadora values ('4','m-4','123456',4);



insert into estado values ('2','ccn-303','123456','En uso');
insert into estado values ('3','Ccn-305','123456','En mantenimiento');
insert into estado values ('4','ccn-306','123456','De baja');


insert into inventario values ('1','ccn-306','m-1',' se clono');
insert into inventario values ('2','Ccn-305','m-1',' se clono');
insert into inventario values ('3','ccn-304','m-1',' se clono');
insert into inventario values ('4','ccn-306','m-1',' se clono');


select * from mantenimiento;

insert into mantenimiento values ('1','ccn-306','2018-05-12',1,1);
insert into mantenimiento values ('2','Ccn-305',' 2018-05-11',2,2);
insert into mantenimiento values ('3','ccn-303',' 2018-05-10',3,3);
insert into mantenimiento values ('4','ccn-303',' 2018-05-9',4,4);
insert into mantenimiento values ('5','ccn-306','2018-05-15',1,1);


insert into supervisor values (1,'leonardo','soliz',' 52816A','18 ','Masculino' ,'Supervisor' , 1);
insert into supervisor values (2,'gonzalo','cabrera',' 546768','19','masculino' , 'Asistente'  , 2     );
insert into supervisor values (3,'yessica','suarez',' 521345',' 20','Femenino'  ,    'secretaria', 3   );
insert into supervisor values (4,'mariana','peredo',' 568909','21 ','femenino'  ,    'supervisor' , 4);
insert into supervisor values (5,'leonardo','padilla',' 528166','19 ','Masculino' ,'Supervisor' , 4);

select * from centro;
select * from supervisor;

-- CONSULTAS BASE ll


-- 10pts
select 
* from computadora 
where Maquina_co  like 'M-1'AND fkCentro = 1;

Select Nombre_su,Apellido_su
from supervisor
where Edad_su >=20;


select 
* from inventario 
where Fecha_in between '2018-09-05'
AND '2018-09-05';

select *
from supervisor 
WHERE fkCentro is null;

select Nombre_su,Apellido_su
from supervisor
WHERE Sexo_su = 'Masculino'and Edad_su > 20;


select idEstado,Centro
from Estado
WHERE Centro = 'ccn-306'and Maquina='M-1';

-- 10pts

select Nombre_su,Apellido_su,Registro_su from supervisor group by idSupervisor like Cargo_su='Supervisor'and fkCentro= 2;
select Mantenimiento_ma,fkComputadora,fkSupervisor,Fecha_ma from mantenimiento group by idMantenimiento like Fecha_ma = '2018-05-12'AND fkSupervisor=1;
select Centro,Maquina  from estado group by idEstado like Estado = 'monitor';
select COUNT(*) , Maquina from estado group by idEstado;


-- 5pts
select COUNT(*) from supervisor where Nombre_su like '%leonardo%';
select COUNT(*) from mantenimiento where Mantenimiento_ma like '%ccn-306%';
select count(*) from computadora where Maquina_co=null ;
select COUNT(*) Maquina_co from computadora
where Serie_co =123456;
select min(Maquina_co) from computadora
  where fkCentro like 1;
  
-- 15pts

SELECT * FROM inventario I
LEFT JOIN centro C
ON I.idInventario = C.idCentro where Centro_cn like '%ccn-306%' ;

SELECT * FROM Computadora CO
LEFT JOIN centro C
ON CO.idComputadora = C.idCentro where centro_cn= null;


SELECT * FROM centro C
 JOIN supervisor S
ON C.idCentro = S.idSupervisor where Apellido_su  like '%soliz%';


SELECT *
from centro C
JOIN supervisor S
ON C.Centro_cn = S.idSupervisor;


-- 10pts

select co.idComputadora as Codigo , co.Maquina_co as Maquina , co.Serie_co as Serie , Centro_cn as Centro
from computadora co , centro C where C.idCentro=co.fkCentro and fkCentro=null ;


select distinct supervisor.Nombre_su,mantenimiento.Mantenimiento_ma
from supervisor inner join mantenimiento
on supervisor.idSupervisor= mantenimiento.fkSupervisor;


select distinct centro.Centro_cn,supervisor.Nombre_su,supervisor.Cargo_su
from centro inner join supervisor
on centro.idcentro = supervisor.fkCentro;



-- 10 pts

select * from supervisor;
select * from computadora;
select * from estado;
select * from supervisor;


use sistema_inventario;


select CONCAT(Registro_su,'U') as registro_su from supervisor;
SELECT CONCAT( Nombre_su,'  ' ,Apellido_su, '  ',Registro_su,'  ')
from supervisor;
SELECT CONCAT( Maquina,'  ' ,Centro, '  ',Estado,'')
from estado;

SELECT DISTINCT S.idSupervisor,CONCAT(S.Nombre_su,' ',S.Apellido_su)
FROM centro C, supervisor S
WHERE S.idSupervisor=C.idCentro;

select * from supervisor;
use sistema_inventario;

SELECT* FROM centro;

SELECT DISTINCT C.Centro_cn
FROM supervisor S, computadora C, estado E,centro CE
WHERE S.idSupervisor=CE.idCentro AND S.idSupervisor=C.idCentro AND C.idComputadora=E.idCentro;

SELECT DISTINCT C.Centro_cn
FROM supervisor E
JOIN centro C ON E.fkCentro=C.idCentro
WHERE E.idsupervisor IS NULL;



-- TOTAL = 60 




