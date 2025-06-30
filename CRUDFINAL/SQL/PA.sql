--USUARIO
CREATE PROCEDURE sp_InsertarUsuario
    @nombre_usuario VARCHAR(50),
    @contrasena VARCHAR(100),
    @correo VARCHAR(100),
    @id_rol INT,
    @usuario_creacion VARCHAR(50)
AS
BEGIN
    INSERT INTO USUARIO(nombre_usuario, contrasena, correo, id_rol, estado, fecha_creacion, usuario_creacion)
    VALUES (@nombre_usuario, @contrasena, @correo, @id_rol, 'ACTIVO', GETDATE(), @usuario_creacion);
END;
GO
CREATE PROCEDURE sp_ActualizarUsuario
    @id_usuario INT,
    @correo VARCHAR(100),
    @estado VARCHAR(20),
    @usuario_modificacion VARCHAR(50)
AS
BEGIN
    UPDATE USUARIO
    SET correo = @correo,
        estado = @estado,
        fecha_modificacion = GETDATE(),
        usuario_modificacion = @usuario_modificacion
    WHERE id_usuario = @id_usuario;
END;
GO
CREATE PROCEDURE sp_EliminarUsuario
    @id_usuario INT
AS
BEGIN
    DELETE FROM USUARIO WHERE id_usuario = @id_usuario;
END;
GO

--ESTUDIANTE
CREATE PROCEDURE sp_InsertarEstudiante
    @id_usuario INT,
    @codigo_estudiante VARCHAR(20),
    @nombre VARCHAR(100),
    @apellido VARCHAR(100),
    @telefono VARCHAR(20),
    @carrera VARCHAR(100),
    @usuario_creacion VARCHAR(50)
AS
BEGIN
    INSERT INTO ESTUDIANTE(id_usuario, codigo_estudiante, nombre, apellido, telefono, carrera, estado, fecha_registro, fecha_creacion, usuario_creacion)
    VALUES (@id_usuario, @codigo_estudiante, @nombre, @apellido, @telefono, @carrera, 'ACTIVO', GETDATE(), GETDATE(), @usuario_creacion);
END;
GO
CREATE PROCEDURE sp_ActualizarEstudiante
    @id_estudiante INT,
    @telefono VARCHAR(20),
    @estado VARCHAR(20),
    @usuario_modificacion VARCHAR(50)
AS
BEGIN
    UPDATE ESTUDIANTE
    SET telefono = @telefono,
        estado = @estado,
        fecha_modificacion = GETDATE(),
        usuario_modificacion = @usuario_modificacion
    WHERE id_estudiante = @id_estudiante;
END;
GO
CREATE PROCEDURE sp_EliminarEstudiante
    @id_estudiante INT
AS
BEGIN
    DELETE FROM ESTUDIANTE WHERE id_estudiante = @id_estudiante;
END;
GO

--BIBLIOTECARIO
CREATE PROCEDURE sp_InsertarBibliotecario
    @id_usuario INT,
    @codigo_empleado VARCHAR(20),
    @nombre VARCHAR(100),
    @apellido VARCHAR(100),
    @telefono VARCHAR(20),
    @puesto VARCHAR(50),
    @usuario_creacion VARCHAR(50)
AS
BEGIN
    INSERT INTO BIBLIOTECARIO(id_usuario, codigo_empleado, nombre, apellido, telefono, puesto, estado, fecha_creacion, usuario_creacion)
    VALUES (@id_usuario, @codigo_empleado, @nombre, @apellido, @telefono, @puesto, 'ACTIVO', GETDATE(), @usuario_creacion);
END;
GO
CREATE PROCEDURE sp_ActualizarBibliotecario
    @id_bibliotecario INT,
    @telefono VARCHAR(20),
    @estado VARCHAR(20),
    @usuario_modificacion VARCHAR(50)
AS
BEGIN
    UPDATE BIBLIOTECARIO
    SET telefono = @telefono,
        estado = @estado,
        fecha_modificacion = GETDATE(),
        usuario_modificacion = @usuario_modificacion
    WHERE id_bibliotecario = @id_bibliotecario;
END;
GO
CREATE PROCEDURE sp_EliminarBibliotecario
    @id_bibliotecario INT
AS
BEGIN
    DELETE FROM BIBLIOTECARIO WHERE id_bibliotecario = @id_bibliotecario;
END;
GO

--LIBRO
CREATE PROCEDURE sp_InsertarLibro
    @isbn VARCHAR(20),
    @titulo VARCHAR(200),
    @editorial VARCHAR(100),
    @anio_publicacion INT,
    @edicion VARCHAR(20),
    @id_categoria INT,
    @ubicacion VARCHAR(100),
    @resumen TEXT,
    @usuario_creacion VARCHAR(50)
AS
BEGIN
    -- ✅ Validar usuario_creacion vacío
    IF (@usuario_creacion IS NULL OR @usuario_creacion = '')
    BEGIN
        SET @usuario_creacion = 'sistema'
    END

    INSERT INTO LIBRO(isbn, titulo, editorial, anio_publicacion, edicion, id_categoria, ubicacion, resumen, fecha_creacion, usuario_creacion)
    VALUES (@isbn, @titulo, @editorial, @anio_publicacion, @edicion, @id_categoria, @ubicacion, @resumen, GETDATE(), @usuario_creacion);
END;

GO
CREATE PROCEDURE sp_ActualizarLibro
    @id_libro INT,
    @ubicacion VARCHAR(100),
    @usuario_modificacion VARCHAR(50)
AS
BEGIN
    UPDATE LIBRO
    SET ubicacion = @ubicacion,
        fecha_modificacion = GETDATE(),
        usuario_modificacion = @usuario_modificacion
    WHERE id_libro = @id_libro;
END;
GO
CREATE PROCEDURE sp_EliminarLibro
    @id_libro INT
AS
BEGIN
    DELETE FROM LIBRO WHERE id_libro = @id_libro;
END;
GO


create PROCEDURE sp_ObtenerLibrosDisponibles
AS
BEGIN
    SELECT DISTINCT
        L.id_libro,
        L.isbn,
        L.titulo,
        L.editorial,
        L.anio_publicacion,
        L.edicion,
        L.id_categoria,
        L.ubicacion,
        L.resumen
    FROM LIBRO L
    JOIN EJEMPLAR E ON L.id_libro = E.id_libro
    WHERE E.estado = 'DISPONIBLE';
END;


--PRESTAMO
CREATE PROCEDURE sp_InsertarPrestamo
    @id_estudiante INT,
    @id_ejemplar INT,
    @id_bibliotecario INT,
    @fecha_devolucion_esperada DATE,
    @usuario_creacion VARCHAR(50)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM EJEMPLAR WHERE id_ejemplar = @id_ejemplar AND estado = 'DISPONIBLE')
    BEGIN
        INSERT INTO PRESTAMO(id_estudiante, id_ejemplar, id_bibliotecario, fecha_devolucion_esperada, estado, renovaciones, fecha_creacion, usuario_creacion)
        VALUES (@id_estudiante, @id_ejemplar, @id_bibliotecario, @fecha_devolucion_esperada, 'ACTIVO', 0, GETDATE(), @usuario_creacion);

        UPDATE EJEMPLAR SET estado = 'PRESTADO' WHERE id_ejemplar = @id_ejemplar;
    END
END;
GO
CREATE PROCEDURE sp_EliminarPrestamo
    @id_prestamo INT
AS
BEGIN
    DELETE FROM PRESTAMO WHERE id_prestamo = @id_prestamo;
END;
GO


create PROCEDURE sp_SolicitarPrestamo
    @id_libro INT,
    @nombre_usuario VARCHAR(50),
    @estado VARCHAR(20) OUTPUT,
    @id_ejemplar INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @id_estudiante INT;
    DECLARE @id_bibliotecario INT = 1;

    -- Obtener id del estudiante
    SELECT @id_estudiante = E.id_estudiante
    FROM ESTUDIANTE E
    INNER JOIN USUARIO U ON U.id_usuario = E.id_usuario
    WHERE U.nombre_usuario = @nombre_usuario;

    IF @id_estudiante IS NULL
    BEGIN
        SET @estado = 'USUARIO NO ENCONTRADO';
        SET @id_ejemplar = NULL;
        RETURN;
    END

    -- Validar préstamo duplicado
    IF EXISTS (
        SELECT 1
        FROM PRESTAMO P
        INNER JOIN EJEMPLAR EJ ON P.id_ejemplar = EJ.id_ejemplar
        WHERE P.id_estudiante = @id_estudiante
          AND EJ.id_libro = @id_libro
          AND P.estado = 'ACTIVO'
    )
    BEGIN
        SET @estado = 'YA POSEE EL LIBRO';
        SET @id_ejemplar = NULL;
        RETURN;
    END

    -- Obtener ejemplar disponible
    SELECT TOP 1 @id_ejemplar = id_ejemplar
    FROM EJEMPLAR
    WHERE id_libro = @id_libro AND estado = 'DISPONIBLE';

    IF @id_ejemplar IS NULL
    BEGIN
        SET @estado = 'NO DISPONIBLE';
        SET @id_ejemplar = NULL;
        RETURN;
    END

    -- Insertar préstamo
    DECLARE @fecha_devolucion_esperada DATE = DATEADD(DAY, 7, GETDATE());

    INSERT INTO PRESTAMO(
        id_estudiante, id_ejemplar, id_bibliotecario,
        fecha_prestamo, fecha_devolucion_esperada,
        estado, renovaciones, fecha_creacion, usuario_creacion
    )
    VALUES (
        @id_estudiante, @id_ejemplar, @id_bibliotecario,
        GETDATE(), @fecha_devolucion_esperada,
        'ACTIVO', 0, GETDATE(), @nombre_usuario
    );

    -- Actualizar estado del ejemplar
    UPDATE EJEMPLAR
    SET estado = 'PRESTADO'
    WHERE id_ejemplar = @id_ejemplar;

    SET @estado = 'PRESTADO';
END;
GO

--DEVOLUCION


create PROCEDURE sp_DevolverPrestamo
    @id_prestamo INT,
    @fecha_devolucion DATE,
    @usuario_modificacion VARCHAR(50),
    @observaciones VARCHAR(200)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        DECLARE @id_ejemplar INT;
        DECLARE @id_estudiante INT;
        DECLARE @fecha_esperada DATE;

        -- Obtener datos del préstamo
        SELECT 
            @id_ejemplar = P.id_ejemplar,
            @id_estudiante = P.id_estudiante,
            @fecha_esperada = P.fecha_devolucion_esperada
        FROM PRESTAMO P
        WHERE P.id_prestamo = @id_prestamo;

        -- Insertar en DEVOLUCION
        INSERT INTO DEVOLUCION (
            id_prestamo,
            id_bibliotecario,
            fecha_devolucion,
            observaciones
        )
        VALUES (
            @id_prestamo,
            1,
            @fecha_devolucion,
            @observaciones
        );

        -- Actualizar préstamo
        UPDATE PRESTAMO
        SET estado = 'COMPLETADO',
            fecha_devolucion_real = @fecha_devolucion,
            fecha_modificacion = GETDATE(),
            usuario_modificacion = @usuario_modificacion
        WHERE id_prestamo = @id_prestamo;

        -- Actualizar estado del ejemplar
        UPDATE EJEMPLAR
        SET estado = 'DISPONIBLE'
        WHERE id_ejemplar = @id_ejemplar;

        -- Si hay retraso, insertar multa
        IF @fecha_esperada IS NOT NULL AND @fecha_devolucion > @fecha_esperada
        BEGIN
            DECLARE @dias_atraso INT = DATEDIFF(DAY, @fecha_esperada, @fecha_devolucion);
            DECLARE @monto DECIMAL(10, 2) = @dias_atraso * 1.00;

            INSERT INTO MULTA (
                id_prestamo,
                id_estudiante,
                monto,
                estado,
                motivo,
                id_parametro_multa
            )
            VALUES (
                @id_prestamo,
                @id_estudiante,
                @monto,
                'PENDIENTE',
                'Devolución tardía',
                1
            );
        END
    END TRY
    BEGIN CATCH
        -- Lanza el error al cliente
        THROW;
    END CATCH
END;