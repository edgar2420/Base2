
-- Obtener las consultas registradas en el sistema bajo el siguiente formato:
			-- | FECHA  | NOMBRE CLINICA| N.C. PACIENTE| N.C. DOCTOR  |
--			 ========================================================
			-- |27/09/21| ProSalud	    |Maria Cardenas| Jose Quino	  |
--			 --------------------------------------------------------
-- La consulta debe obtener todos los doctores que ganan mas del minimo nacional (2160)
-- y que trabajen en clinicas de tercer nivel.
-- Anidada y CTE
select to_char(c.dtfecha, 'DD/MM/YY'), c2.snombre as clinica, concat(p2.snombre, ' ', p2.sapellido) as paciente, concat(p1.snombre, ' ', p1.sapellido) as doctor
from consultas c
join clinicas c2 on c.clinica_id = c2.codigo_id
join personas p1 on c.doctor_id = p1.codigo_id
join personas p2 on c.paciente_id = p2.codigo_id
WHERE EXISTS(
	select *
	from consultas f
	join doctores d ON d.codigo_id = f.doctor_id
	join clinicas c2 on c2.codigo_id = f.clinica_id
	where c2.inivel = 3 and d.nsalario > 2160
	AND c.codigo_id=f.codigo_id 
	)
	
	
WITH filtro AS (
	select f.codigo_id
	from consultas f
	join doctores d ON d.codigo_id = f.doctor_id
	join clinicas c2 on c2.codigo_id = f.clinica_id
	where c2.inivel = 3 and d.nsalario > 2160
)
select to_char(c.dtfecha, 'DD/MM/YY'), c2.snombre as clinica, concat(p2.snombre, ' ', p2.sapellido) as paciente, concat(p1.snombre, ' ', p1.sapellido) as doctor
from consultas c
join clinicas c2 on c.clinica_id = c2.codigo_id
join personas p1 on c.doctor_id = p1.codigo_id
join personas p2 on c.paciente_id = p2.codigo_id
JOIN filtro X on c.codigo_id = X.codigo_id


select to_char(c.dtfecha, 'DD/MM/YY'), c2.snombre as clinica, concat(p2.snombre, ' ', p2.sapellido) as paciente, X.doctor
from consultas c
join clinicas c2 on c.clinica_id = c2.codigo_id
join (
	select d.codigo_id, concat(p.snombre, ' ', p.sapellido) as doctor
	from doctores d 
	join personas p on d.codigo_id = p.codigo_id and d.nsalario > 2160) X on c.doctor_id = X.codigo_id
join personas p2 on c.paciente_id = p2.codigo_id
where c2.inivel = 3;
	


-- LISTA DE PERSONAS
CREATE VIEW lista_personas AS(
	select 
	CASE
  	WHEN gsangre IS NULL AND sespecialidad IS NULL THEN 'NINGUNO'
	  WHEN gsangre IS NOT NULL AND sespecialidad IS NOT NULL THEN 'AMBOS'
	  WHEN gsangre IS NOT NULL THEN 'PACIENTE'
  	ELSE 'DOCTOR' END AS TIPO, *
	from personas p 
	LEFT JOIN pacientes p2 USING (codigo_id )
	LEFT JOIN doctores d USING (codigo_id) order by 1 asc)


SELECT 'AMBOS',p.* FROM personas p 
NATURAL JOIN pacientes p2 
NATURAL JOIN doctores d 
UNION
SELECT 'NINGUNO',p.* FROM personas p 
LEFT JOIN pacientes p2 USING(codigo_id)
LEFT JOIN doctores d USING(codigo_id)
WHERE p2.gsangre IS NULL AND d.sespecialidad IS NULL
UNION
SELECT 'PACIENTES',p.* FROM personas p 
LEFT JOIN pacientes p2 USING(codigo_id)
LEFT JOIN doctores d USING(codigo_id)
WHERE p2.gsangre IS NOT NULL AND d.sespecialidad IS NULL
union 
SELECT 'DOCTORES',p.* FROM personas p 
LEFT JOIN pacientes p2 USING(codigo_id)
LEFT JOIN doctores d USING(codigo_id)
WHERE p2.gsangre IS NULL AND d.sespecialidad IS NOT NULL
