

-- mostrar fecha, nombre clinica, nombre y apell doctor, nombre y apell paciente

select to_char (c.dtfecha, 'dd/MM/YY'), c2.snombre as clinica, concat(d.snombre, ' ' , d.sapellido) as doctor,
 concat(p.snombre, ' ', p.sapellido) as paciente
 from consultas c
 join clinicas c2 on c2.codigo_id = c.clinica_id
 join personas d on c.doctor_id = d.codigo_id
 join personas p on c.paciente_id = p.codigo_id
 order by c.dtfecha asc;



select to_char(c.dtfecha,'dd/MM/YY'),c2.snombre as clinica, concat(d.snombre,' ',d.sapellido) as doctor,
p.snombre ||' '|| p.sapellido as paciente
from consultas c
join clinicas c2 on c2.codigo_id = c.clinica_id
join personas d on c.doctor_id = d.codigo_id
join personas p on c.paciente_id = p.codigo_id order by c.dtfecha asc;


-- para saber los que son doctores y personas

 select *
 from personas r
 join doctores d on r.codigo_id = d.codigo_id;

"Javier"	"Quino"        "19791001-JQ" 
"Maria"	    "Cardenas"     "19821109-MC"
"Martin"	"Zabala"       "20020202-MZ" 
"Victor"	"Gutierrez"    "19760402-VG"
"Paco"	    "Guerra"       "19960311-PG"
"Andrea"	"Tejerina"     "19931001-AT"


-- para saber los que son pacientes y personas

select * 
from personas r 
join pacientes e on r.codigo_id = e.codigo_id;

"19905130-AF"        "19905130-AF"
"19861224-EG"        "19861224-EG"
"19791001-JQ"        "19791001-JQ"
"19870827-RS"        "19870827-RS"
"19821109-MC"        "19821109-MC"
"20060513-EP"        "20060513-EP"
"19800405-IR"        "19800405-IR"
"19990619-CS"        "19990619-CS"
"19900415-LT"        "19900415-LT"
"19810721-AR"        "19810721-AR"

    
-- para saber los que son doctores y pacientes

select * 
from personas r
join pacientes e on r.codigo_id = e.codigo_id
join doctores d on r.codigo_id = d.codigo_id;

"19791001-JQ"           "19791001-JQ"          "19791001-JQ"
"19800405-IR"
"19990619-CS"
"19861224-EG"
"19905130-AF"
"19821109-MC"           "19821109-MC"          "19821109-MC"
"20060513-EP"
"19870827-RS"
"19810721-AR"
"19900415-LT"


-- para saber quien es solo persona

"19905130-AF"                     "19905130-AF"
"19861224-EG"                     "19861224-EG"
"19791001-JQ"    "19791001-JQ"    "19791001-JQ"
"19870827-RS"                     "19870827-RS"
"19821109-MC"    "19821109-MC"    "19821109-MC"
"20020202-MZ"    "20020202-MZ"
"20060513-EP"                     "20060513-EP"
"19800405-IR"                     "19800405-IR"
"19760402-VG"    "19760402-VG"
"19990619-CS"                     "19990619-CS"
"19920809-PP"        
"19960311-PG"    "19960311-PG"
"19900415-LT"                     "19900415-LT"
"19810721-AR"                     "19810721-AR"
"19891231-JF"                    
"19931001-AT"    "19931001-AT"




"20060513-EP"
"19760402-VG"
"19931001-AT"
"20020202-MZ"
"19861224-EG"
"19900415-LT"
"19870827-RS"
"19800405-IR"
"19905130-AF"
"19960311-PG"
"19891231-JF"
"19920809-PP"
"19990619-CS"
"19810721-AR"


-- deberia ser JF y PP

select *
from personas r
where not exists (select * 
from personas r
join pacientes e on r.codigo_id = e.codigo_id
join doctores d on r.codigo_id = d.codigo_id);


select *
from personas r
where r.codigo_id not in (select codigo_id from doctores d) 
union
select *
from personas r
where codigo_id not in (select codigo_id from pacientes s);



-- consulta con doctores que trabajen en hospoitales de 3er nivel y ganen más de 2160
select *
from consultas c
join doctores d on d.codigo_id = c.doctor_id
join clinicas c2 on c2.codigo_id = c.clinica_id
where c2.inivel = 3 AND d.nsalario > 2160;


-- consulta con doctores que trabajen en hospoitales de 3er nivel y ganen más de 2160
-- y mostrar fecha, nombre clinica, nombre y apell doctor, nombre y apell paciente

select to_char (c.dtfecha, 'dd/MM/YY'), c2.snombre as clinica, concat(d.snombre, ' ' , d.sapellido) as doctor,
 concat(p.snombre, ' ', p.sapellido) as paciente
 from consultas c
 join clinicas c2 on c2.codigo_id = c.clinica_id
 join personas d on c.doctor_id = d.codigo_id
 join personas p on c.paciente_id = p.codigo_id
 where exists (select *
from consultas c
join doctores d on d.codigo_id = c.doctor_id
join clinicas c2 on c2.codigo_id = c.clinica_id
where c2.inivel = 3 AND d.nsalario > 2160)



-- procedimientos
CREATE OR REPLACE PROCEDURE ins_paciente(
nombre text,
apellido text,
fecha date,
grupo_sangre text
) AS
$$
BEGIN
INSERT INTO personas(codigo_id,snombre,sapellido,dtnacimiento) VALUES ('XXX',nombre,apellido,fecha);
INSERT INTO pacientes VALUES ('XXX',grupo_sangre);
END
$$
LANGUAGE plpgsql;


call ins_paciente('Adolf','Hitler','20020101','O+')

select * from personas







 