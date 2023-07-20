

-- LOOP
CREATE OR REPLACE FUNCTION bucle(p_limite int)
RETURNS text AS
$$
DECLARE
v_int INT := 1;
v_resultado TEXT := '';
BEGIN
LOOP
--condicion
EXIT WHEN v_int > p_limite;
--operacion
RAISE NOTICE 'Nro: %', v_int;
v_resultado := v_resultado || ', ' || v_int;
v_int := v_int + 1; 
END LOOP;
RAISE NOTICE  'largo %', LENGTH(v_resultado);
RETURN RIGHT(v_resultado, LENGTH(v_resultado)-2);
END
$$
LANGUAGE plpgsql;

SELECT bucle(5)


CREATE OR REPLACE FUNCTION bucl2(p_limite INT)
RETURNS SETOF INT AS
$$
DECLARE
v_int INT := 0;
BEGIN
LOOP
--condicion
EXIT WHEN v_int >= p_limite;
--operacion
v_int := v_int +1;
RETURN NEXT v_int;
END LOOP;
END
$$
LANGUAGE plpgsql;

SELECT bucl2(5);


CREATE OR REPLACE FUNCTION buclefor(p_limite int)
RETURNS TEXT AS
$$
DECLARE
v_int INT := 1;
v_resultado TEXT := '';
BEGIN
FOR v_int IN 1..10 LOOP
IF v_int % 2 = 0 THEN
v_resultado := v_resultado ||', '|| v_int;
END IF;
END LOOP;
RETURN RIGHT(v_resultado, LENGTH(v_resultado)-2);
END
$$
LANGUAGE plpgsql;

SELECT buclefor(6);


CREATE OR REPLACE FUNCTION buclefor2()
RETURNS TEXT AS
$$
DECLARE
v_fila RECORD;
v_resultado TEXT := '';
BEGIN
FOR v_fila IN SELECT * FROM personas LOOP
v_resultado := v_resultado ||', '|| v_fila.snombre||' '||v_fila.sapellido;
END LOOP;
RETURN RIGHT(v_resultado, LENGTH(v_resultado)-2);
END
$$
LANGUAGE plpgsql;

SELECT buclefor2();


CREATE OR REPLACE FUNCTION mismaSangre(p_paciente_id TEXT)
RETURNS TEXT AS
$$
DECLARE
v_fila RECORD;
v_gsangre public.pacientes.gsangre%TYPE;
v_resultado TEXT := '';
BEGIN
SELECT gsangre INTO v_gsangre FROM pacientes WHERE codigo_id = p_paciente_id;
FOR v_fila IN SELECT * FROM pacientes WHERE gsangre = v_gsangre AND codigo_id <> p_paciente_id LOOP
v_resultado := v_resultado || ', ' || v_fila.codigo_id;
END LOOP;
RETURN RIGHT(v_resultado,LENGTH(v_resultado)-2);
END
$$
LANGUAGE plpgsql; 

SELECT mismaSangre('19821109-MC');