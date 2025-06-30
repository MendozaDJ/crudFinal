---BD

-- Crear la base de datos si no existe
IF NOT EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = 'Biblioteca')
BEGIN
    CREATE DATABASE Biblioteca;
END
GO

USE Biblioteca;
GO

-- Tabla PARAMETROS_SISTEMA
CREATE TABLE PARAMETROS_SISTEMA (
    id_parametro INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL,
    valor VARCHAR(200) NOT NULL,
    descripcion VARCHAR(500),
    fecha_actualizacion DATE DEFAULT GETDATE() NOT NULL,
    usuario_actualizacion VARCHAR(50) NOT NULL
);

-- Tabla ROL
CREATE TABLE ROL (
    id_rol INT IDENTITY(1,1) PRIMARY KEY,
    nombre_rol VARCHAR(50) UNIQUE NOT NULL,
    descripcion VARCHAR(200)
);

-- Tabla USUARIO
CREATE TABLE USUARIO (
    id_usuario INT IDENTITY(1,1) PRIMARY KEY,
    nombre_usuario VARCHAR(50) UNIQUE NOT NULL,
    contrasena VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    id_rol INT NOT NULL,
    fecha_registro DATE DEFAULT GETDATE() NOT NULL,
    estado VARCHAR(20) CHECK (estado IN ('ACTIVO', 'INACTIVO', 'BLOQUEADO')) NOT NULL,
    fecha_creacion DATETIME DEFAULT GETDATE(),
    usuario_creacion VARCHAR(50),
    fecha_modificacion DATETIME,
    usuario_modificacion VARCHAR(50),
    FOREIGN KEY (id_rol) REFERENCES ROL(id_rol)
);

-- Tabla ESTUDIANTE
CREATE TABLE ESTUDIANTE (
    id_estudiante INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT UNIQUE,
    codigo_estudiante VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    carrera VARCHAR(100),
    estado VARCHAR(20) CHECK (estado IN ('ACTIVO', 'INACTIVO', 'SUSPENDIDO')) NOT NULL,
    fecha_registro DATE DEFAULT GETDATE() NOT NULL,
    fecha_creacion DATETIME DEFAULT GETDATE(),
    usuario_creacion VARCHAR(50),
    fecha_modificacion DATETIME,
    usuario_modificacion VARCHAR(50),
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
);

-- Tabla BIBLIOTECARIO
CREATE TABLE BIBLIOTECARIO (
    id_bibliotecario INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT UNIQUE,
    codigo_empleado VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    puesto VARCHAR(50),
    estado VARCHAR(20) CHECK (estado IN ('ACTIVO', 'INACTIVO')) NOT NULL,
    fecha_creacion DATETIME DEFAULT GETDATE(),
    usuario_creacion VARCHAR(50),
    fecha_modificacion DATETIME,
    usuario_modificacion VARCHAR(50),
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
);

-- Tabla CATEGORIA_LIBRO
CREATE TABLE CATEGORIA_LIBRO (
    id_categoria INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(200),
    dias_prestamo INT NOT NULL,
    renovable CHAR(1) CHECK (renovable IN ('S', 'N')) NOT NULL,
    id_parametro_categoria INT,
    FOREIGN KEY (id_parametro_categoria) REFERENCES PARAMETROS_SISTEMA(id_parametro)
);

-- Tabla LIBRO
CREATE TABLE LIBRO (
    id_libro INT IDENTITY(1,1) PRIMARY KEY,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    titulo VARCHAR(200) NOT NULL,
    editorial VARCHAR(100),
    anio_publicacion INT,
    edicion VARCHAR(20),
    id_categoria INT NOT NULL,
    ubicacion VARCHAR(100),
    resumen VARCHAR(MAX),
    fecha_creacion DATETIME DEFAULT GETDATE(),
    usuario_creacion VARCHAR(50),
    fecha_modificacion DATETIME,
    usuario_modificacion VARCHAR(50),
    FOREIGN KEY (id_categoria) REFERENCES CATEGORIA_LIBRO(id_categoria)
);

-- Tabla AUTOR
CREATE TABLE AUTOR (
    id_autor INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    pais_origen VARCHAR(50),
    fecha_nacimiento DATE,
    biografia TEXT
);

-- Tabla LIBRO_AUTOR
CREATE TABLE LIBRO_AUTOR (
    id_libro INT,
    id_autor INT,
    PRIMARY KEY (id_libro, id_autor),
    FOREIGN KEY (id_libro) REFERENCES LIBRO(id_libro),
    FOREIGN KEY (id_autor) REFERENCES AUTOR(id_autor)
);

-- Tabla EJEMPLAR
CREATE TABLE EJEMPLAR (
    id_ejemplar INT IDENTITY(1,1) PRIMARY KEY,
    id_libro INT NOT NULL,
    codigo_barras VARCHAR(50) UNIQUE NOT NULL,
    estado VARCHAR(20) CHECK (estado IN ('DISPONIBLE', 'PRESTADO', 'REPARACION', 'PERDIDO')) NOT NULL,
    fecha_adquisicion DATE,
    ubicacion_fisica VARCHAR(100),
    FOREIGN KEY (id_libro) REFERENCES LIBRO(id_libro)
);

-- Tabla PRESTAMO
CREATE TABLE PRESTAMO (
    id_prestamo INT IDENTITY(1,1) PRIMARY KEY,
    id_estudiante INT NOT NULL,
    id_ejemplar INT NOT NULL,
    id_bibliotecario INT NOT NULL,
    fecha_prestamo DATE DEFAULT GETDATE() NOT NULL,
    fecha_devolucion_esperada DATE NOT NULL,
    fecha_devolucion_real DATE,
    estado VARCHAR(20) CHECK (estado IN ('ACTIVO', 'COMPLETADO', 'VENCIDO')) NOT NULL,
    renovaciones INT DEFAULT 0 NOT NULL,
    id_parametro_prestamo INT,
    id_parametro_renovacion INT,
    fecha_creacion DATETIME DEFAULT GETDATE(),
    usuario_creacion VARCHAR(50),
    fecha_modificacion DATETIME,
    usuario_modificacion VARCHAR(50),
    FOREIGN KEY (id_estudiante) REFERENCES ESTUDIANTE(id_estudiante),
    FOREIGN KEY (id_ejemplar) REFERENCES EJEMPLAR(id_ejemplar),
    FOREIGN KEY (id_bibliotecario) REFERENCES BIBLIOTECARIO(id_bibliotecario),
    FOREIGN KEY (id_parametro_prestamo) REFERENCES PARAMETROS_SISTEMA(id_parametro),
    FOREIGN KEY (id_parametro_renovacion) REFERENCES PARAMETROS_SISTEMA(id_parametro)
);

-- Tabla DEVOLUCION
CREATE TABLE DEVOLUCION (
    id_devolucion INT IDENTITY(1,1) PRIMARY KEY,
    id_prestamo INT NOT NULL,
    id_bibliotecario INT NOT NULL,
    fecha_devolucion DATE DEFAULT GETDATE() NOT NULL,
    observaciones VARCHAR(500),
    FOREIGN KEY (id_prestamo) REFERENCES PRESTAMO(id_prestamo),
    FOREIGN KEY (id_bibliotecario) REFERENCES BIBLIOTECARIO(id_bibliotecario)
);

-- Tabla MULTA
CREATE TABLE MULTA (
    id_multa INT IDENTITY(1,1) PRIMARY KEY,
    id_prestamo INT NOT NULL,
    id_estudiante INT NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    fecha_generacion DATE DEFAULT GETDATE() NOT NULL,
    fecha_pago DATE,
    estado VARCHAR(20) CHECK (estado IN ('PENDIENTE', 'PAGADA', 'CANCELADA')) NOT NULL,
    motivo VARCHAR(200) NOT NULL,
    id_parametro_multa INT,
    FOREIGN KEY (id_prestamo) REFERENCES PRESTAMO(id_prestamo),
    FOREIGN KEY (id_estudiante) REFERENCES ESTUDIANTE(id_estudiante),
    FOREIGN KEY (id_parametro_multa) REFERENCES PARAMETROS_SISTEMA(id_parametro)
);

-- Tabla ROL_PARAMETRO
CREATE TABLE ROL_PARAMETRO (
    id_rol INT,
    id_parametro INT,
    nivel_acceso INT CHECK (nivel_acceso BETWEEN 1 AND 3),
    PRIMARY KEY (id_rol, id_parametro),
    FOREIGN KEY (id_rol) REFERENCES ROL(id_rol),
    FOREIGN KEY (id_parametro) REFERENCES PARAMETROS_SISTEMA(id_parametro)
);

-- Tabla HISTORIAL_PARAMETROS
CREATE TABLE HISTORIAL_PARAMETROS (
    id_historial INT IDENTITY(1,1) PRIMARY KEY,
    id_parametro INT NOT NULL,
    valor_anterior VARCHAR(200) NOT NULL,
    valor_nuevo VARCHAR(200) NOT NULL,
    fecha_cambio DATE DEFAULT GETDATE() NOT NULL,
    usuario_cambio VARCHAR(50) NOT NULL,
    id_bibliotecario INT,
    FOREIGN KEY (id_parametro) REFERENCES PARAMETROS_SISTEMA(id_parametro),
    FOREIGN KEY (id_bibliotecario) REFERENCES BIBLIOTECARIO(id_bibliotecario)
);

-- Tabla HISTORIAL_EJEMPLAR
CREATE TABLE HISTORIAL_EJEMPLAR (
    id_historial INT IDENTITY(1,1) PRIMARY KEY,
    id_ejemplar INT NOT NULL,
    estado_anterior VARCHAR(20) NOT NULL,
    estado_nuevo VARCHAR(20) NOT NULL,
    fecha_cambio DATETIME DEFAULT GETDATE(),
    usuario VARCHAR(50) NULL, -- opcional, si deseas registrar quién hizo el cambio
    FOREIGN KEY (id_ejemplar) REFERENCES EJEMPLAR(id_ejemplar)
);

