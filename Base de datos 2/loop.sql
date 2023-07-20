
-- LOOP 


CREATE OR REPLACE FUNCTION bucle(p_limite int)
RETURNS int AS
$$
DECLARE
v_int INT := 1;
v_resultado TEXT := '';
BEGIN
LOOP
-- condicion
EXIT WHEN v_int > p_limite;
RAISE NOTICE 'Nro: %', v_int;
v_int := v_int + 1;
-- operacion
END LOOP;
END
$$
LANGUAGE plpgsql;

-- BUCLE FOR

