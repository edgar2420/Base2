--Realizar una consulta que devuelva los datos de la tabla "empleados" de la base de datos "Empresa", teniendo como primera columna el nuevo código de empleado.

--La estructura del codigo es la siguiente:

--    Departamento(tres primeras letras), Iniciales del empleado (apellido, nombre), ultimos dos digitos del año, mes y día. Por ejemplo:

--            "SIS-PJ-89-06-02"

--            "GER-VC-79-09-22"

--Una vez diseñana la consulta, adicionar una columna "codigo_id" a la tabla empleados y llenar dicha columna con la codificación correspondiente de cada empleado
select CONCAT(UPPER(left(D.snombre,3)),'-',left(E.sappaterno,1),left(E.snombre,1),'-',to_char(E.dtnacimiento,'yy-mm-dd'))
as CODIGO, D.snombre,E.sappaterno,E.snombre,E.dtnacimiento
from empleados E join departamentos D on E.ci_id = D.numero_id