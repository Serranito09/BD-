--EJERCICIO 1
set serveroutput on;
DECLARE 
 cursor c is SELECT nombrecompleto from votantes v,localidades l
 where v.localidad=l.idlocalidad and substr(dni,LENGTH(dni),1)=l.idlocalidad+1 ;
 ncount int :=0;
 begin 
 
 FOR nRow IN c loop
  dbms_output.put_line(nRow.nombrecompleto);
  ncount:=ncount+1;
 end LOOP;
  dbms_output.put_line(ncount);
 end;
 
 
 --EJERCICIO 2
 
 set serveroutput on;
DECLARE 
 cursor c is SELECT * from votantes v;
votantesData votantes%rowtype;
ncount int :=0;
 begin 
 open c;
 LOOP
 FETCH c into votantesData;
 exit when c%notfound;
 if substr(votantesData.dni,length(votantesData.dni),1)=votantesData.localidad+1
 then
  dbms_output.put_line(votantesData.nombrecompleto);
  ncount:=ncount+1;
  end if;
 end LOOP;
 dbms_output.put_line(ncount);
 
 end;
 
  ---EJERCICIO 3
 set serveroutput on;
 DECLARE
 cursor c is SELECT * from votantes;
 fila c%rowtype;
 ncount int :=0;
 data votantes%rowtype; 
 BEGIN 
 open c;
 fetch c into fila;
 while c%found LOOP
 if substr(fila.dni,length(fila.dni),1)=fila.localidad+1
 then
 dbms_output.put_line(fila.nombrecompleto);
 ncount:=ncount+1;
 end if;
 fetch c into fila;
 end loop;
dbms_output.put_line(ncount);
END;

---EJERCICIO 4
set serveroutput on;
DECLARE 
cursor c is SELECT nombrecompleto,nombre from votantes v,localidades l where l.idlocalidad like DECODE(v.localidad,1,9,2,9,3,9,v.localidad);
contador number :=0;

BEGIN

FOR nrow in c loop
if nrow.nombre like 'Madrid' then
contador:=contador+1;
end if;
dbms_output.put_line(nrow.nombrecompleto||'es de '||nrow.nombre);
end loop;
dbms_output.put_line('Hay un total de '||contador||' de madrid');

END;


---EJERCICIO 5
set serveroutput on;
DECLARE
Cursor c is select  dni from votantes order by dni desc;
dniN votantes.dni%type;

BEGIN

FOR nrow in c loop
if dniN is null then
dniN:=nrow.dni;
else
dbms_output.put_line(dniN||' va antes que '|| nrow.dni);
dniN:=nrow.dni;
end if;

end loop;
dbms_output.put_line('el dni mas pequeño es el '||dniN);

END;


---EJERCICIO 6
set serveroutput on;
DECLARE
cursor c is select dni,count(votante) as p
from votantes v,consultas c
where v.dni=c.votante having count(votante)>(select avg(count (votante))
from consultas 
group by votante)
group by dni
order by p desc;
BEGIN 

for nrow in c loop
dbms_output.put_line(nrow.dni||' ha participado '||nrow.p);
end loop;
END;







