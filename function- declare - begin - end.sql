

-- FUNCTION 

CREATE OR REPLACE FUNCTION ins_consulta(
p_nombre_clinica TEXT,
p_nombre_paciente TEXT,
p_nombre_doc TEXT
) RETURNS void AS
$$
DECLARE
v_clinica_id INT;
v_paciente_id TEXT;
v_doctor_id TEXT;
BEGIN
select c.codigo_id into v_clinica_id from clinicas c where c.snombre = p_nombre_clinica;
select p2.snombre into v_paciente_id from personas p2 join pacientes p on p2.codigo_id = p.codigo_id where p_nombre_paciente = p2.snombre;
select p.snombre into v_doctor_id from personas p join doctores d on p.codigo_id = d.codigo_id where p_nombre_doc = p.snombre;
insert into consultas values ((select max(codigo_id)+1 from consultas),v_clinica_id,v_doctor_id,v_paciente_id, CURRENT_TIMESTAMP);
END
$$
LANGUAGE plpgsql;

select ins_consulta ('prosalud','victor arredondo','alejandro gutierrez');