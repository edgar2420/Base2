create database Academico;
CREATE SCHEMA params;
CREATE SCHEMA RRHH;

Create table params.Pais (
 	paisID serial  primary key  not null,
	Nombre varchar(50)  not null
 
);
Create table Materia(
	materiaID serial primary key not null,
	Nombre varchar(100) not null,
	Descripcion text not null,
	Creditos int not null
);

Create table params.Grupo (
	Nombre varchar(100) primary key  not null
);
Create table params.Aula (
	AulaID serial primary key not null,
	Nombre varchar(100) not null,
	Tipo varchar(100) not null,
	Capacidad int not null
);
Create table params.Carrera(
	CarreraID serial primary key not null,
	Nombre varchar(100) not null,
	Descripcion text not null
);
Create table Pensum(
	PensumID serial primary key not null,
	CarreraID int not null,
	MateriaID int not null
);
Alter table Pensum add foreign key (CarreraID) references params.Carrera(CarreraID);
Alter table Pensum add foreign key (MateriaID) references Materia(MateriaID);

Create table params.Horario(
	HorarioID serial primary key not null,
	HInicio time not null,
	HFinal time not null,
	Primerdia varchar(100) not null,
	SegundoDia varchar(100)
	
);
Create table RRHH.Persona (
	PersonaID serial primary key not null,
	Nombre varchar(100) not null,
	CI int not null,
	Ciudad text not null,
	Apellidos varchar(100) not null,
	FNacimiento date not null,
	Direccion text not null,
	Genero text not null
);
Alter table RRHH.Persona add Tipo int;
Alter table RRHH.Persona add PaisID int;
Alter table RRHH.Persona add foreign key (PaisID) references params.Pais(PaisID);
Alter table RRHH.Persona add check(Genero IN('M','F'));
Alter table RRHH.Persona add check(CI >0);
Alter table RRHH.Persona add Salario numeric;

Create table RRHH.Telefono(
	TelefonoID serial not null,
	PersonaID int not null,
	Numero varchar(100)
);
Alter table RRHH.Telefono add foreign key(PersonaID) references RRHH.Persona(PersonaID);
Alter table RRHH.Telefono add primary key(PersonaID,TelefonoID);
Create table RRHH.Documento(
	DocumentoID serial primary key not null,
	PersonaID int not null,
	direccionDocumento text not null,
	foreign key (PersonaID) references RRHH.Persona(PersonaID)
);
Alter table RRHH.Documento add FEmision date;
Alter table RRHH.Documento add FVencimiento date;
Create table params.Curso (
	CursoID serial primary key not null,
	DocenteID int not null,
	AulaID int not null,
	GrupoID varchar(100) not null,
	MateriaID int not null,
	HorarioID int not null
);

Alter table params.Curso add foreign key(DocenteID) references RRHH.Persona(PersonaID);
Alter table params.Curso add foreign key(AulaID) references params.Aula(AulaID);
Alter table params.Curso add foreign key(GrupoID) references params.Grupo(Nombre);
Alter table params.Curso add foreign key(MateriaID) references Materia(MateriaID);
Alter table params.Curso add foreign key(HorarioID) references params.Horario(HorarioID);
Alter table params.Curso add costoMateria numeric;

Create table Inscripcion (
	InscripcionID serial primary key not null,
	EstudianteID int not null,
	CursoID int not null
);
Alter table Inscripcion add foreign key(EstudianteID) references RRHH.Persona(PersonaID);
Alter table Inscripcion add foreign key(CursoID) references params.Curso(CursoID);
alter table inscripcion add column semestreGestion text not null;


Create table Nota(
	NotaID serial primary key not null,
	Nota numeric not null,
	InscripcionID int not null,
	Descripcion varchar(100) not null,
	Fecha timestamp not null,
	foreign key (InscripcionID) references Inscripcion(InscripcionID)
);
Create table Asistencia(
	AsistenciaID serial primary key not null,
	FClase timestamp not null,
	Asistencia int not null,
	InscripcionID int not null,
	foreign key (InscripcionID) references Inscripcion(InscripcionID)
);

Create table PlanDePago(	
	PlanDePagoID serial primary key not null,
	Nombre varchar(100) not null,
	TipoPlan int not null,
	Descuento numeric not null,
	Interes numeric not null,
	PagoUnico numeric,
	FVencimiento timestamp not null,
	Estado varchar(100) not null,
	InscripcionID int not null,
	NroCuota int not null,
	FechaPago timestamp not null
);
Alter table PlanDePago add foreign key (InscripcionID) references Inscripcion(InscripcionID);

Create table CarreraEstudiante (
	CarreraEstudiante serial primary key not null,
	CarreraID int not null,
	EstudianteID int not null
);
Alter table CarreraEstudiante add foreign key (CarreraID) references params.Carrera(CarreraID);
Alter table CarreraEstudiante add foreign key (EstudianteID) references RRHH.Persona(PersonaID);

Create table RRHH.Solicitud (
	SolicitudID serial primary key not null,
	TipoSolicitud text not null,
	FEnvio TIMESTAMP not null,
	FInicio Timestamp not null,
	FFin Timestamp not null,
	Comentario text not null
	
);
Alter table RRHH.Solicitud add SolicitanteID int not null;
Alter table RRHH.Solicitud add foreign key (SolicitanteID) references RRHH.Persona(PersonaID);

Create table RRHH.aprobadoPor(
	AprobadoPorID serial primary key not null,
	FRespuesta TIMESTAMP,
	Estado int not null,
	Comentario text,
	SolicitudID int not null,
	EncargadoID int not null
	
);
Alter table RRHH.aprobadoPor add foreign key (SolicitudID) references RRHH.Solicitud(SolicitudID);
Alter table RRHH.aprobadoPor add foreign key (EncargadoID) references RRHH.Persona(PersonaID);

alter table materia
add column siguientemateria int;

alter table materia
add foreign key (siguientemateria) references materia(materiaid);

alter table plandepago
add column estudiante_semestre text;

alter table plandepago
drop column Nombre;