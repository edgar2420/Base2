

-- FORMATO  DPTO APELL-NOMBRE YY-MM-DD 
-- FORMA #1

select upper(substring(d.snombre,1,3))||'-'||
substring(e.sappaterno ,1,1)||
substring(e.snombre ,1,1)||'-'||
to_char(dtnacimiento, 'YY')||'-'||
to_char(dtnacimiento, 'MM')||'-'||
to_char(dtnacimiento, 'DD') as codigo_id
from empleados e
join departamentos d on e.dpto_id = d.numero_id;


-- FORMATO  DPTO APELL-NOMBRE YY-MM-DD 
-- FORMA #2

SELECT(
select UPPER(substring(d.nombre,1,3))||'-'||
(select substring(e.sappaterno,1,1))||
(select substring (e.snombre,1,1))||'-'||
(to_char(e.dtnacimiento,'YY'))||'-'||
(to_char(e.dtnacimiento,'MM'))||'-'||
(to_char(e.dtnacimiento,'DD'))) as codigo_id
from empleados e join departamentos d on e.dpto_id = d.numero_id;


-- FORMATO  DPTO APELL-NOMBRE YY-MM-DD 
-- FORMA #3

SELECT e.*, CONCAT(UPPER(LEFT(d.nombre, 3)),'-',
LEFT(e.appaterno, 1),LEFT(e.nombre, 1),
TO_CHAR(dtnacimiento, '-YY-MM-DD')) as codigo_id
FROM empleados e
JOIN departamentos d ON e.dpto_id = d.numero_id;


-- FORMATO  DPTO APELL-NOMBRE YY-MM-DD 
-- FORMA #4

select UPPER(concat(left(d.nombre,3),'-',
left(e.appaterno,1),left(e.nombre,1),'-',
substring(e.dtnacimiento::text,3,11))),* 
from empleados e join departamentos d on e.dpto_id = d.numero_id;

