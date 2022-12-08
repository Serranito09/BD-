--EJERCICIO 1
select nombrecompleto 
from votantes v
where substr(dni,LENGTH(DNI),1)-1=localidad;

--EJERCICIO 2
Select nombrecompleto,DECODE(v.localidad,1,'Madrid',2,'Madrid',3,'Madrid',l.nombre)as localidad
from votantes v,localidades l
where v.localidad=l.idlocalidad
order by 2 desc;

--EJERCICIO 3
Select siglas
from partidos p,eventos_resultados er
where p.idpartido=er.partido having count(er.evento)=(SELECT MAX(COUNT(er.evento))
    FROM partidos p, eventos_resultados er
    WHERE er.partido=p.idpartido
    GROUP BY p.siglas)
    group by p.siglas;
    
--EJERCICIO 4
select dni
from votantes v
where fechanacimiento=(SELECT MIN(fechanacimiento)
from votantes v
where fechanacimiento>(SELECT MIN(fechanacimiento)
from votantes v));

--EJERCICIO 5
SELECT dni,count(evento)as consultas
FROM votantes v,consultas c
where v.dni=c.votante
group by dni
order by 2 desc;


--EJERCICIO 6
select dni,count(evento)
from votantes v,consultas c
where v.dni=c.votante having count(evento)>(select avg(evento)
from votantes v,consultas c
where v.dni=c.votante)
group by dni
order by 2 desc;

--EJERCICIO 7
select nombrecompleto
from votantes v,consultas c
where v.dni=c.votante having count(evento)>(select avg(evento)
from votantes v,consultas c
where v.dni=c.votante)
group by nombrecompleto;

--EJERCICIO 8
SELECT dni,count(evento)as consultas
FROM votantes v,consultas c
where v.dni=c.votante and fechanacimiento not in(select min(fechanacimiento)
from votantes v
where fechanacimiento>(select min (fechanacimiento)
from votantes v))
group by dni
order by 2 desc;
                                         
                                          
                                          
                                          



