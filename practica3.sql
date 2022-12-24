select nombrecompleto from votantes where substr(dni,-1)=localidad+1 ;-- ejercicio1



-- ejercicio 3
select p.siglas
from partidos p,eventos_resultados er
where p.idpartido=er.partido
group by p.siglas
having count(er.partido)=(select max(count(partido))
                            from eventos_resultados
                            group by partido);
                            
                            
                        
-- ejercicio 5 plus
select l.nombre ,l.numerohabitantes,p.comunidad
from localidades l,provincias p
where l.provincia=p.idprovincia and p.idprovincia in(1,2,3) and 
l.numerohabitantes >(select min(numerohabitantes)from localidades where provincia=4)



--ejercicio 8 plus
select l.nombre 
from localidades l,votantes v
where l.idlocalidad=v.localidad
group by l.nombre 
having avg(decode(v.estudiossuperiores,'Basicos',1,'Superiores',2,'Doctorado',3,0))>
all((select avg(decode(v2.estudiossuperiores,'Basicos',1,'Superiores',2,'Doctorado',3,0))
    from localidades l2,votantes v2
    where v2.localidad=l2.idlocalidad
    group by l2.provincia));


