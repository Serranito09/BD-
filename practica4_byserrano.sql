
--EJERCICIO 1 
set serveroutput on;
BEGIN
dbms_output.put_line('hola mundo,hoy es el dia '||sysdate);
END;

--EJERCICIO 2
set serveroutput on;
DECLARE
nombrecompleto votantes.nombrecompleto%type;
correo votantes.email%type;
BEGIN
SELECT email into correo from votantes where dni=30983712;
select nombrecompleto into nombrecompleto from votantes where dni=30983712;
dbms_output.put_line(nombrecompleto||' con correo :'||correo);

end;


--EJERCICIO 3
set serveroutput on;
DECLARE
nombre votantes.nombrecompleto%type;
correo votantes.nombrecompleto%type;
BEGIN
select substr(nombrecompleto,0,instr(nombrecompleto,' ')) into nombre from votantes where dni=30983712;
select email into correo from votantes where dni=30983712;
dbms_output.put_line(nombre||'con correo '||correo);
END;

---EJERCICIO 4
set serveroutput on;
DECLARE
apellido votantes.nombrecompleto%type;
BEGIN
select substr(nombrecompleto,instr(nombrecompleto,' ')) into apellido from votantes where dni=30983712;
dbms_output.put_line('Pepe'||apellido);
END;


---EJERCICIO 5
set serveroutput on;
DECLARE
nombre votantes.nombrecompleto%type;
dni votantes.dni%type;
BEGIN

select nombrecompleto into nombre
from votantes 
where ((sysdate-fechanacimiento)/365)=(select max((sysdate-fechanacimiento)/365) from votantes);

select dni into dni
from votantes 
where ((sysdate-fechanacimiento)/365)=(select max((sysdate-fechanacimiento)/365) from votantes);

dbms_output.put_line('el señor '||nombre||' con dni '||dni||' es el votante mas longevo' );
END;

--EJERCICIO 6
set serveroutput on;
DECLARE 
nombre votantes.nombrecompleto%type;
nombre2 votantes.nombrecompleto%type;
email1 votantes.email%type;
email2 votantes.email%type;
BEGIN
select nombrecompleto into nombre
from votantes 
where ((sysdate-fechanacimiento)/365)=(select max((sysdate-fechanacimiento)/365) from votantes);

select nombrecompleto into nombre2 
from votantes 
where ((sysdate-fechanacimiento)/365)=(select min((sysdate-fechanacimiento)/365) from votantes);


select substr(email,0,instr(email,'@')) into email1
from votantes 
where ((sysdate-fechanacimiento)/365)=(select max((sysdate-fechanacimiento)/365) from votantes);

select substr(email,0,instr(email,'@')) into email2
from votantes 
where ((sysdate-fechanacimiento)/365)=(select min((sysdate-fechanacimiento)/365) from votantes);

dbms_output.put_line(nombre||'--'||email1||'uco.es');
dbms_output.put_line(nombre2||'--'||email2||'uco.es');
END;



--EJERCICIO 7
set serveroutput on;
DECLARE
apellido1 votantes.nombrecompleto%type;
apellido2 votantes.nombrecompleto%type;
BEGIN
select substr(nombrecompleto,instr(nombrecompleto,' '),instr(nombrecompleto,' ')+2) into apellido2 
from votantes 
where ((sysdate-fechanacimiento)/365)=(select min((sysdate-fechanacimiento)/365) from votantes 
);

select substr(nombrecompleto,instr(nombrecompleto,' '),(instr(nombrecompleto,' ')-1)) into apellido1 
from votantes
where ((sysdate-fechanacimiento)/365)=(select min((sysdate-fechanacimiento)/365) from votantes 
where ((sysdate-fechanacimiento)/365)>(select min((sysdate-fechanacimiento)/365) from votantes));
dbms_output.put_line('El hijo se llama Juan'||apellido1||apellido2);
END;

--EJERCICIO 8

set serveroutput on;
DECLARE
numlocalidades int;
habitantes int;
BEGIN
SELECT numeroHabitantes+(SELECT numeroHabitantes FROM localidades WHERE idlocalidad=(SELECT MIN(idlocalidad) FROM localidades WHERE idlocalidad>(SELECT MIN(idlocalidad) FROM localidades))) INTO habitantes FROM localidades WHERE idlocalidad=(SELECT MIN(idlocalidad) FROM localidades);
SELECT COUNT(nombre) INTO numlocalidades FROM localidades WHERE numeroHabitantes>habitantes;
dbms_output.put_line('Hay '||numlocalidades||' ciudades con mas habitantes de '||habitantes||' habitantes, que es la suma de las dos localidades con IDs mas peque?os');
END;

