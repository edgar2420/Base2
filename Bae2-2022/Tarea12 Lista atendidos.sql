--Realizar una consulta utilizando CTE que indique la cantidad total de consultas que realizó un doctor en una clinica en particular, 
--indicando el nombre de la clinica, nombre completo del doctor y el total de pacientes atendidos, 
--se debe incluir en el informe aquellos doctores registrados que no realizaron ninguna consulta.
--Modelo de ejemplo:
--+------------+---------------------+---------------+
--| Clinica    | Doctor              | Nro Atendidos |
--+------------+---------------------+---------------+
--| Clinica A  | Alejandro Fernandez | 3             |
--+------------+---------------------+---------------+
--| Clinica A  | Javier Quino        | 2             |
--+------------+---------------------+---------------+
--| Hospital B | Alejandro Fernandez | 1             |
--+------------+---------------------+---------------+
--| Centro C   | Javier Quino        | 3             |
--+------------+---------------------+---------------+
--| ...        | ...                 | ...           |
--+------------+---------------------+---------------+
--|    ---     | Victor Gutierrez    | 0             |
--+------------+---------------------+---------------+

select F.snombre as Clinica,concat(Q.snombre,' ',Q.sapellido) as Doctor,count(D.codigo_id)as Nro_Atendidos 
from doctores D left join consultas S on D.codigo_id = S.doctor_id
left join clinicas F on F.codigo_id = S.clinica_id 
join personas Q on Q.codigo_id = D.codigo_id group by F.snombre,Q.snombre,Q.sapellido
order by 3 desc