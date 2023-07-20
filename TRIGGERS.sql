

CREATE OR REPLACE FUNCTION ge_cod(p_nombre TEXT, p_apellido TEXT, p_nacimiento DATE)
RETURNS TEXT AS
$$
BEGIN
RETURN to_char(p_nacimiento,'yyyymmdd')||'-'||LEFT(p_nombre,1)||LEFT(p_apellido,1);
END
$$
LANGUAGE plpgsql;

select *,ge_cod(snombre,sapellido,dtnacimiento) from personas


CREATE OR REPLACE FUNCTION ins_persona(p_nombre TEXT, p_telefono TEXT, p_direccion TEXT, p_nacimiento DATE)
RETURNS VOID AS
$$
DECLARE
v_codigo TEXT;
v_nombre TEXT := split_part(p_nombre,' ',1);
v_apellido TEXT := split_part(p_nombre,' ',2);
BEGIN
SELECT ge_cod(v_nombre, v_apellido, p_nacimiento) INTO v_codigo;
INSERT INTO personas VALUES(v_codigo, v_nombre, v_apellido, p_telefono, p_direccion, p_nacimiento);
END
$$
LANGUAGE plpgsql;
SELECT ins_persona('Julian Howard','7876906','Calle Velarde','2002-06-08'); 


CREATE OR REPLACE FUNCTION ins_persona2(p_nombre text, 
	p_telefono text, p_direccion text, p_nacimiento DATE)
RETURNS VOID AS 
$$
DECLARE
	v_codigo TEXT;
	v_nombre TEXT :=split_part(p_nombre,' ',1);
	v_apellido TEXT :=split_part(p_nombre,' ',2);
BEGIN
	SELECT gen_codigo(v_nombre,v_apellido,p_nacimiento) INTO v_codigo;
	IF p_nombre !~* '\m[a-z]+$' THEN
		RAISE EXCEPTION 'El nombre o apellido contiene numeros';
	ELSIF p_telefono !~ '^[0-9]+$' THEN
		RAISE EXCEPTION 'No se aceptan letas en los numeros de telefono';
	ELSIF age(p_nacimiento) < interval '18 years' THEN
		RAISE EXCEPTION 'No se acepta el registro de personas menores a 18 años';
	ELSE
		INSERT INTO personas VALUES (v_codigo,v_nombre,v_apellido,
		p_telefono,p_direccion,p_nacimiento);
	END IF;
END
$$
language plpgsql;


CREATE OR REPLACE FUNCTION ins_persona3()
RETURNS TRIGGER AS 
$$
DECLARE
	v_codigo TEXT;
BEGIN
	SELECT ge_cod(NEW.snombre,NEW.sapellido,NEW.dtnacimiento) INTO v_codigo;
	IF NEW.snombre !~* '\m[a-z]+$' AND NEW.sapellido !~* '\m[a-z]+$' THEN
		RAISE EXCEPTION 'El nombre o apellido contiene numeros';
	ELSIF NEW.stelefono !~ '^[0-9]+$' THEN
		RAISE EXCEPTION 'No se aceptan letas en los numeros de telefono';
	ELSIF age(NEW.dtnacimiento) < interval '18 years' THEN
		RAISE EXCEPTION 'No se acepta el registro de personas menores a 18 años';
	ELSE
		NEW.codigo_id := v_codigo;
		RETURN NEW;
	END IF;
END
$$
language plpgsql;

CREATE TRIGGER rev_personas
BEFORE INSERT OR UPDATE ON personas
FOR EACH ROW
EXECUTE FUNCTION ins_persona3();




