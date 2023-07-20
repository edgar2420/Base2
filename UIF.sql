CREATE DATABASE PEP;
USE PEP;

﻿-- Database PEP;


CREATE TABLE public.tblclientes
(
  codigo_id bigserial NOT NULL PRIMARY KEY,
  snit text NOT NULL,
  snombre text NOT NULL,
  sappaterno text NOT NULL,
  sapmaterno text NOT NULL,
  iconcurrencia_id integer NOT NULL,
  bdeleted boolean NOT NULL,
  dtcreated timestamp without time zone,
  dcmodified timestamp without time zone,
  access_id integer NOT NULL);

INSERT INTO public.tblclientes VALUES 
(DEFAULT,'327584','German Ernesto','Bravo','Roca',1,false,'2015-04-02 14:19:15.611','2015-04-02 14:19:15.611',1),
(DEFAULT,'468861','ANA PAOLA','MENDEZ','HURTADO',1,false,'2015-04-02 14:20:59.456','2015-04-02 14:20:59.456',22),
(DEFAULT,'159701','MIGUEL ANGEL','BARBA','ESCALANTE',1,false,'2015-04-06 11:45:48.34','2015-04-06 11:45:48.34',9),
(DEFAULT,'128127029','COOPERATIVA ABIERTA LA MERCED LTDA','','',1,false,'2015-04-28 16:02:35.598','2015-04-28 16:02:35.598',7),
(DEFAULT,'10436337','Clinica de Rehabilitacion Odontologica','','',2,false,'2014-10-08 15:47:34.882','2014-10-08 15:56:18.507',1),
(DEFAULT,'3106409','Gilmar','Guzman','Merino',1,false,'2015-04-29 12:18:52.222','2015-04-29 12:18:52.222',10),
(DEFAULT,'317461','Ana Desiree','Mostajo','Flores',1,false,'2015-04-28 14:56:16.978','2015-04-28 14:56:16.978',10),
(DEFAULT,'7848411','Diego Armando','Landivar','Rossel',1,false,'2015-04-28 16:06:15.46','2015-04-28 16:06:15.46',10),
(DEFAULT,'13067029','RINA MARIA','SALAZAR','ANEZ',1,false,'2015-04-29 16:23:22.182','2015-04-29 16:23:22.182',9),
(DEFAULT,'E-16412678','MATIAS','WESKOTT','',1,false,'2015-05-06 10:39:07.019','2015-05-06 10:39:07.019',7);
