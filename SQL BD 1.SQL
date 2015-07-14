--AH
USE master
GO


/*===============================
 Borrar o Crear la BD  SYNOPSIS
===============================*/


IF EXISTS(SELECT * FROM SYS.DATABASES WHERE NAME='SYNOPSIS')
DROP DATABASE SYNOPSIS
GO
CREATE DATABASE SYNOPSIS
GO
USE SYNOPSIS
GO



/*===============================
	Creando Tablas
===============================*/

-------solicitud del recurso una solicitud x cada reserva --------


CREATE TABLE SOLICITUD
  (
    Co_Solicitud        NUMERIC (10) NOT NULL , -- PK codigo de solicitud correlativo
    Co_Cliente          VARCHAR (11) NOT NULL , --  RUC del cliente (Se debe buscar en otra bd y tabla)
    Rs_Cliente			VARCHAR (100) NOT NULL , -- razon social del cliente (Se hereda de la busqueda)
    Co_Proyecto         NUMERIC (10) NOT NULL ,-- codigo del proyecto (Se debe buscar en otra bd y tabla)
    De_Proyecto			VARCHAR (100) NOT NULL , -- descripcion o nombre del proyecto (Se hereda de la busqueda)
    Co_Perfil			NUMERIC (10) NOT NULL , -- FK codigo del perfil que se solicita (Se debe buscar en otra tabla )
    De_Perfil           VARCHAR (100) NOT NULL , -- desripcion del perfil Jefe de Proyec, Anal Funcinal,  programador (Se hereda de la busqueda)
    Cn_Perfil			VARCHAR (100) NOT NULL , -- conoccimiento que se solicita en si, x ejemplo del perfil programador : conocimiento de Java
    Es_Solicitud        CHAR (1) NOT NULL , -- estado solici : 1 registrado 2 Reservado (cuando se registra reserva) 3 Atendida (cuando se aprueba la reserva) 9 anulado 
    Fe_Inicio			DATE , --(Se hereda de la busqueda del proyecto)
    Fe_Fin				DATE , -- (Se hereda de la busqueda del proyecto)
    Fe_Creacion			DATE ,
   )
GO



-------perfil------ Tabla con datos ya registrados

CREATE TABLE PERFIL
  (
	Co_Perfil			NUMERIC (10) NOT NULL , --  PK codigo del perfil 001 ,002, 003
    De_Perfil           VARCHAR (100) NOT NULL , -- desripcion del perfil 001:Jefe de Proyec,002: Anal Funcional,  003:programador
    Fl_Perfil           CHAR (1) NOT NULL , -- estado del perfil : 1 Activo 2 Anulado 
    Fe_Creacion			DATE ,
  )
GO

-------trabajador--------- creo que debe tener ya datos y tbm podemos registrar otros 



CREATE TABLE [dbo].[RECURSO](
	[CODTRABAJADOR] [int] IDENTITY(1,1) NOT NULL,
	[NOMBRE] [varchar](50) NULL,
	[APEPAT] [varchar](50) NULL,
	[APEMAT] [varchar](50) NULL,
	[EDAD] [int] NULL,
	[NRODCOC] [varchar](50) NULL,
	[ESPECIALIDAD] [varchar](50) NULL,
	[PERFIL] [int] NULL,
 CONSTRAINT [PK_RECURSO] PRIMARY KEY CLUSTERED 
(
	[CODTRABAJADOR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO



-------reserva de recurso ---------  una reserva x un recurso de la solicitud 
 
CREATE TABLE RESERVA
  (
	Co_Reserva			NUMERIC (10) NOT NULL , -- PK codigo de reserva se genera al grabar
    Co_Solicitud        NUMERIC (10) NOT NULL , -- FK codigo de solicitud (Se ingresa)
    Co_Perfil			NUMERIC (10) NOT NULL , -- FK codigo del perfil que se solicita (Se debe heredar  al ingresar la solicitud)
    De_Perfil           VARCHAR (100) NOT NULL , -- desripcion del perfil Jefe de Proyec, Anal Funcinal,  programador ((Se debe heredar  al ingresar la solicitud)
    Cn_Perfil			VARCHAR (100) NOT NULL , -- conoccimiento que se solicita en si, x ejemplo del perfil programador : conocimiento de Java (Se hereda del detalle de solicitud)
	Co_Trabajador		NUMERIC (8) NOT NULL , -- FK DNI codigo del trabajador
    Es_Reserva          CHAR (1) NOT NULL , -- estado solici : 1 registrado 2 Aprobado  9 Anulado 
    Fe_Inicio			DATE , --(Se hereda de la solicitud)
    Fe_Fin				DATE , -- (Se hereda de la solicitud)
    Fe_Creacion			DATE ,
   )
GO


CREATE TABLE RESERVATRABAJADOR
  (
	Co_RTrabajador		NUMERIC (10) NOT NULL , -- PK codigo de reserva
	Co_Perfil			NUMERIC (10) NOT NULL , -- FK codigo del perfil que se solicita (Se debe heredar  al ingresar la solicitud)
    Co_Trabajador		NUMERIC (8) NOT NULL , -- FK DNI codigo del trabajador (Se hereda al aprobar la reserva)
    Es_RTrabajador	    CHAR (1) NOT NULL , -- estado reservatrabajador : 1 activo 2 anulado
    Fe_Inicio			DATE , --(Se hereda al aprobar la reserva)
    Fe_Fin				DATE , --(Se hereda al aprobar la reserva)
    Fe_Creacion			DATE ,
   )
GO


------- CREACION DE LA OTRA BD PARA LAS CONSULTAS DE CLIENTE Y DEL PROYECTO

USE master
GO

/*===============================
 Borrar o Crear la BD  SVENTAS
===============================*/

IF EXISTS(SELECT * FROM SYS.DATABASES WHERE NAME='SVENTAS')
DROP DATABASE SVENTAS
GO
CREATE DATABASE SVENTAS
GO
USE SVENTAS
GO

/*===============================
	Creando Tablas
===============================*/


-------cliente--------   ya creadas y con datos para hacer la busqueda en la solicitud


CREATE TABLE CLIENTE
  (
    Co_Cliente          VARCHAR (11) NOT NULL , -- PK RUC del cliente : 10101010101 
    Rs_Cliente			VARCHAR (100) NOT NULL , --razon social del cliente: Banco de credito del Peru
    Di_Cliente          VARCHAR (100) NOT NULL , -- Direccion del cliente : Av. la molina 2225 La Molina - Lima
    Fl_Cliente          CHAR (1) NOT NULL , -- estado cliente : 1 Activo 2 Anulado 
    Fe_Creacion			DATE ,
   )
GO



CREATE TABLE PROYECTO
  (
    Co_Proyecto         NUMERIC (10) NOT NULL ,-- PK codigo del proyecto: 001 
    De_Proyecto			VARCHAR (100) NOT NULL , -- nombre del proyecto: Proyecto atencion cliente
    Co_Cliente          VARCHAR (11) NOT NULL , --FK RUC del cliente que de estar en la tabla cliente: 10101010101
    Fl_Proyecto         CHAR (1) NOT NULL , -- estado proyecto : 1 activo 2 Cerrado    9 anulado 
    Fe_PeriodoInicio	DATE ,
    Fe_PeriodoFin		DATE ,
    Fe_Creacion			DATE ,
   )
GO




