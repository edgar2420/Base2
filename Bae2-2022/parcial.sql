--1.- Mostrar Course ID, Course Title y Classroom de todos los cursos enseñados por el instructor
--‘I06’.
Select cid, title, crid from demo_course where iid = 'I06';
--2.- Obtener el instructor ID de quien enseña mas de un curso de la tabla “demo_course”
select iid, count(*) from demo_course group by iid having count(*) > 1;
--3.- Obtener todas las columnas de “demo_course” solamente cuando el instructor (instructor
--ID) enseña mas de un curso y su materia está relacionada a “business” o si su “course credit
--hour” (horas crédito del curso) no es mayor a 2 horas.
select * from demo_course where iid in 
(select iid from demo_course where title ilike '%business%' group by iid having count(*) > 1) 
union 
select iid from demo_course dc where "hour" < 2;
--4.- Obtener “Name” y “Dept” de la table “demo_instructor” solamente cuando el instructor
--enseña exactamente un curso
select name, dept from demo_instructor 
--5.- Obtener el CID, el total de nro de estudiantes registrados o matriculados para cada curso de
--la tabla “demo_registration”.
select cid, count(sid) from demo_registration dr 
group by cid group by cid order by 2 desc;

--8.- Obtener todas las columnas de la table “demo_student” para los estudiantes de primer año
--que están teniendo el GPA más bajo (GPA < 2 ).
SELECT * FROM DEMO_STUDENT
WHERE ((YEAR = 1) AND (GPA < 2));

--9.- Obtener el CID, SID de la tabla “demo_registration” para los estudiantes cuyo “major”
--(área) es “Computer”
SELECT r.SID, r.CID, s.MAJOR 
FROM DEMO_REGISTRATION r
JOIN DEMO_STUDENT s ON r.SID = s.SID
WHERE s.MAJOR = 'Computer';

--11.- Crear un usuario “parcial” que solamente pueda seleccionar e insertar datos en la tabla
--DEMO_REGISTRATION
CREATE USER parcial WITH PASSWORD 'parcial';
GRANT SELECT, INSERT ON demo_registration TO parcial;



