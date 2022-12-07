--1
SELECT dni 
FROM votantes 
WHERE telefono LIKE '%6%6%' AND telefono NOT LIKE '%6%6%6%6%';
--2
SELECT dni 
FROM votantes 
WHERE telefono LIKE '%66%6%' OR telefono LIKE '%6%66%' AND telefono NOT LIKE '%6%6%6%6%';
--3
SELECT localidades.nombre, provincias.nombre 
FROM localidades, provincias 
WHERE localidades.provincia=provincias.idprovincia AND localidades.provincia=SUBSTR(localidades.numeroHabitantes,LENGTH(numerohabitantes), 1);
--4
SELECT nombreCompleto 
FROM votantes 
WHERE SUBSTR(telefono, LENGTH(telefono), 1)=SUBSTR(dni,LENGTH(DNI), 1);
--5
SELECT nombreCompleto 
FROM votantes 
WHERE nombreCompleto LIKE '%s%' AND fechaNacimiento<'12/02/1990';
--6
SELECT DISTINCT votantes.dni 
FROM votantes, consultas 
WHERE consultas.votante=votantes.dni 
ORDER BY votantes.dni DESC;
--7
SELECT votante 
FROM consultas HAVING COUNT(votante)>3 
GROUP BY votante;
--8
SELECT v.nombrecompleto, COUNT(c.votante)
FROM consultas c, votantes v 
WHERE c.votante=v.dni HAVING COUNT(c.votante)>3 
GROUP BY v.nombrecompleto ORDER BY COUNT(c.votante) ASC;
--9
SELECT DISTINCT nombreCompleto, nombre 
FROM votantes v, localidades l, consultas c
WHERE v.localidad=l.idlocalidad AND v.dni=c.votante AND l.numeroHabitantes>300000;
--10
SELECT p.nombreCompleto, MAX(c.certidumbre)
FROM partidos p, consultas_datos c
WHERE p.idPartido=c.partido 
GROUP BY p.nombreCompleto;

--EJERCICIO 11
SELECT v.nombreCompleto, AVG(cd.certidumbre) as media
FROM partidos p, consultas_datos cd,consultas c,votantes v
WHERE p.idPartido=cd.partido and c.idconsulta=cd.consulta and v.dni=c.votante and cd.respuesta='Si'
GROUP BY v.nombreCompleto
ORDER BY media desc;

--EJERCICIO 12
SELECT v.nombreCompleto, AVG(cd.certidumbre) as media
FROM partidos p, consultas_datos cd,consultas c,votantes v
WHERE p.idPartido=cd.partido and c.idconsulta=cd.consulta and v.dni=c.votante and cd.respuesta='Si'
having avg(cd.certidumbre)>0.5  and avg(cd.certidumbre)<0.8
GROUP BY v.nombreCompleto
ORDER BY media desc;


--EJERCICIO 13
SELECT p.nombrecompleto,avg(certidumbre) as media
FROM partidos p,consultas_datos cd,votantes v,consultas c
WHERE p.idpartido=cd.partido and c.idconsulta=cd.consulta and cd.respuesta='No' and cd.certidumbre>0.6
group by p.nombrecompleto;
