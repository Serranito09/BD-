--EJERCICIO 2 EXAMEN
select l.nombre as "nombreLocalidad", count(v.localidad) as "total", (((sysdate-min(v.fechanacimiento))/365)-((sysdate-max(v.fechanacimiento))/365)) as "diferencia" 
  from localidades l, votantes v
  where v.localidad=l.idlocalidad and length(substr(v.nombrecompleto,1,instr(v.nombrecompleto,' ')-1))<v.localidad
  group by l.nombre
  order by l.nombre;

--EJERCICIO tercera parte 
set serveroutput on ;
declare
cursor c is select *
            from localidades l,votantes v
            where l.idlocalidad=v.localidad
            order by v.dni desc;
    votante_ultimo votantes.nombrecompleto%type;
    votante_anterior votantes.nombrecompleto%type;
    localidad_ultimo localidades.nombre%type;
    localidad_anterior localidades.nombre%type;
    i int :=0;
begin
for fila in c 
loop
    votante_ultimo:=substr(fila.nombrecompleto,1,instr(fila.nombrecompleto,' ')-1);
    localidad_ultimo:=fila.nombre;
    if i=0
    then 
    i:=i+1;
    else
    dbms_output.put_line(votante_anterior||' de '||localidad_anterior||' va antes de '||votante_ultimo||' de '||localidad_ultimo);
    end If;
       votante_anterior:=votante_ultimo;
    localidad_anterior:=localidad_ultimo;
    end loop;
    dbms_output.put_line(votante_ultimo ||' de '||localidad_ultimo||' es el ultimo');
    
    end;
    
    --ejercicio 1examen
    select v.nombrecompleto,count(c.votante) as "consultas"
    from votantes v,consultas c
    where v.dni=c.votante  and  v.dni LIKE '%1%0%' having count (c.votante)>3
    group by v.nombrecompleto
    order by count(c.votante) 
    --ejercicio 2 examen 
    select nombrecompleto,avg(c.certidumbre) as media
    from partidos p,consultas_datos c
    where p.idpartido=c.partido and p.fechacreacion<(SELECT max(fechacreacion)
                        from partidos
                        WHERE fechacreacion<(select max(fechacreacion) from partidos))
    group by p.nombrecompleto 
    order by media asc;
    
    --ejercicio constrain
    ALTER TABLE votantes
    add constraint email_ck
     CHECK(email like '%_@_%.__%');
