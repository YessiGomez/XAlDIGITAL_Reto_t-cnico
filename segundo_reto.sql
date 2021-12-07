/* Reto 2
Yessica Gomez Salgado*/

-- creacion de la base de datos --
create database vuelosMexico;
use vuelosMexico;

-- creacion de la tala aerolineas --
create table aerolineas(id_aerolinea int not null, nombre_aerolinea varchar(25), primary key (id_aerolinea));
-- creacioin de la tabla aeropuertos --
create table aeropuerto (id_aeropuerto int not null, nombre_aeropuerto varchar(25),primary key(id_aeropuerto));
-- creacion de latabla movimientos --
create table movimientos (id_movimiento int not null, descripcion varchar (25),primary key (id_movimiento));
-- creacion  de la tabla vuelos
create table vuelos (id_aerolinea int not null,id_aeropuerto int not null,id_movimiento int not null,dia date);
alter table vuelos add foreign key (id_aerolinea) references aerolineas(id_aerolinea);
alter table vuelos add foreign key (id_aeropuerto) references aeropuerto(id_aeropuerto);
alter table vuelos add foreign key (id_movimiento) references movimientos(id_movimiento);

-- registros en la tabla aerolineas --
insert into aerolineas  values(1,'Volaris');
insert into aerolineas  values(2,'Aeromar');
insert into aerolineas  values(3,'Interjet');
insert into aerolineas  values(4,'Aeromexico');

-- registros en la tabla aeropuerto --
insert into aeropuerto values(1,'Benito Juarez');
insert into aeropuerto  values(2,'Guanajuato');
insert into aeropuerto  values(3,'La paz');
insert into aeropuerto  values(4,'Oaxaca');

-- registros en la tabla movimientos --
insert into movimientos values(1,'Salida');
insert into movimientos values(2,'Llegada');

-- registros en la tabla vuelos --
insert into vuelos values(1,1,1,'2021-05-02');
insert into vuelos values(2,1,1,'2021-05-02');
insert into vuelos values(3,2,2,'2021-05-02');
insert into vuelos values(4,3,2,'2021-05-02');
insert into vuelos values(1,3,2,'2021-05-02');
insert into vuelos values(2,1,1,'2021-05-02');
insert into vuelos values(2,3,1,'2021-05-04');
insert into vuelos values(3,4,1,'2021-05-04');
insert into vuelos values(3,4,1,'2021-05-04');

-- Respuestas --
-- 1. ¿Cuál es el nombre aeropuerto que ha tenido mayor movimiento durante el año?
select nombre_aeropuerto 
from (select nombre_aeropuerto, count(id_aeropuerto)  total
	 from vuelos natural join aeropuerto 
	 group by id_aeropuerto) AS tablaa
where total in (select max(total)
		from (select id_aeropuerto,count(id_aeropuerto) total 			
        from vuelos natural join aeropuerto
			group by id_aeropuerto) AS tablab);
-- RESPUESTA: La paz, Benito Juarez

-- 2. ¿Cuál es el nombre aerolínea que ha realizado mayor número de vuelos durante el año?
select nombre_aerolinea 
from (select nombre_aerolinea, count(id_aerolinea) total
	 from vuelos natural join aerolineas 
	 group by id_aerolinea) AS tablaa
where total in (select max(total)
		from (select id_aerolinea,count(id_aerolinea) total 			
        from vuelos natural join aerolineas
			group by id_aerolinea) AS tablab);
-- RESPUESTA: Interjet, Aeromar

-- 3. ¿En qué día se han tenido mayor número de vuelos?
select dia from (select dia,count(dia) total
from vuelos group by dia) AS tablaa
 where total in (select max(total) from 
(select dia, count(dia) total from vuelos group by dia) AS tablab);
-- RESPUESTA: 2021-05-02

-- 4. ¿Cuáles son las aerolíneas que tienen mas de 2 vuelos por día?
Select nombre_aerolinea From vuelos natural join aerolineas Group By nombre_aerolinea, dia  Having count(*) > 2;
-- RESPUESTA: no existen aerolineas que tengan mas de dos vuelos por dia.