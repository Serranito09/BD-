--EJERCICIO 1
select SUBSTR(nombrecompleto,1,instr(nombrecompleto,' ')-1)as nombre,l.nombre as localidad,comunidad as comunidad
from votantes v,localidades l,provincias p
where v.localidad=l.idlocalidad and l.provincia=p.idprovincia and v.localidad=any(1,3,9);

--EJERCICIO 2
select concat(concat(l.nombre,' va antes que '),l1.nombre)
from localidades l ,localidades l1
where l1.idlocalidad like l.idlocalidad +1;

--EJERCICIO 3
select distinct nombre
from localidades l,votantes v
where fechanacimiento not in(select min(fechanacimiento)
from localidades l,votantes v
where fechanacimiento>(select min(fechanacimiento)
from localidades l,votantes v))and numerohabitantes>(select numerohabitantes
from votantes v,localidades l
where v.localidad=l.idlocalidad and fechanacimiento =(select min(fechanacimiento)
from localidades l,votantes v
where  fechanacimiento >(select min(fechanacimiento)
from localidades l,votantes v )));



--EJERCICIO 4
select nombrecompleto, decode(b, null, 'menor de edad', b) edad, localidad --llamamos a esta columna edad
from(select v.nombrecompleto,(select concat(' ', 'mayor d edad') 
from votantes  --ponemos el select dentro del select para que nos salgan tambien los dni con los menores de edad con un null, si los pusieramos en un where solo nos saldrian los que cumple la condicion
where nombrecompleto=v.nombrecompleto and (sysdate-fechanacimiento)/365>18) b, 
localidad --llamo b a esta columna
from votantes v
where (localidad=2 or localidad=4 or localidad=8));

--EJERCICIO 5
Select l.nombre,l.numerohabitantes,comunidad
from localidades l,provincias p
where l.provincia=p.idprovincia and (l.provincia='1' or l.provincia='2'or  l.provincia='3')
and l.numerohabitantes>(select numerohabitantes
from localidades
where idlocalidad='4');

--EJERCICIO 6
select  nombrecompleto
from votantes v,consultas c
where v.dni=c.votante and situacionlaboral='Activo' having count(votante)<(SELECT AVG(COUNT(votante)) FROM consultas GROUP BY votante)
group by nombrecompleto;

--EJERCICIO 7
select  nombre
from localidades l,votantes v
where l.idlocalidad=v.localidad
group by nombre
order by AVG(decode(estudiossuperiores,'Basicos',1,'Superiores',2,'Doctorado',3,0))desc;


--EJERCICIO 8
select  nombre 
from localidades l,votantes v
where l.idlocalidad=v.localidad having avg(decode(estudiossuperiores,'Basicos',1,'Superiores',2,'Doctorado',3,0))
>ALL(select avg(decode(estudiossuperiores,'Basicos',1,'Superiores',2,'Doctorado',3,0))
from localidades l,votantes v,provincias p
where v.localidad=l.idlocalidad and l.provincia=p.idprovincia
group by p.nombre)
group by nombre;


select avg(decode(estudiossuperiores,'Basicos',1,'Superiores',2,'Doctorado',3,0))
from localidades l,votantes v,provincias p
where v.localidad=l.idlocalidad and l.provincia=p.idprovincia
group by p.nombre;

