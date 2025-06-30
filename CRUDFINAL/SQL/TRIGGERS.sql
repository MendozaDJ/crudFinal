--PARAMETROS_SISTEMA
CREATE TRIGGER trg_Parametros_ActualizarHistorial
ON PARAMETROS_SISTEMA
AFTER UPDATE
AS
BEGIN
    INSERT INTO HISTORIAL_PARAMETROS (
        id_parametro,
        valor_anterior,
        valor_nuevo,
        fecha_cambio,
        usuario_cambio,
        id_bibliotecario
    )
    SELECT 
        i.id_parametro,
        i.valor,
        d.valor,
        GETDATE(),
        d.usuario_actualizacion,
        NULL  -- puedes modificar si hay sesión de bibliotecario
    FROM deleted i
    JOIN inserted d ON i.id_parametro = d.id_parametro
    WHERE i.valor <> d.valor;
END;
GO

--PRESTAMO
CREATE TRIGGER trg_Prestamo_VencimientoAutomatico
ON PRESTAMO
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE p
    SET estado = 'VENCIDO'
    FROM PRESTAMO p
    INNER JOIN inserted i ON p.id_prestamo = i.id_prestamo
    WHERE p.estado = 'ACTIVO' AND p.fecha_devolucion_esperada < CAST(GETDATE() AS DATE);
END;
GO

--MULTA
CREATE TABLE HISTORIAL_MULTA (
    id_historial_multa INT IDENTITY(1,1) PRIMARY KEY,
    id_multa INT,
    estado_anterior VARCHAR(20),
    estado_nuevo VARCHAR(20),
    fecha_cambio DATETIME DEFAULT GETDATE(),
    motivo VARCHAR(200)
);
GO

CREATE TRIGGER trg_Multa_RegistrarHistorial
ON MULTA
AFTER UPDATE
AS
BEGIN
    INSERT INTO HISTORIAL_MULTA (id_multa, estado_anterior, estado_nuevo, motivo)
    SELECT 
        d.id_multa,
        d.estado,
        i.estado,
        i.motivo
    FROM inserted i
    JOIN deleted d ON i.id_multa = d.id_multa
    WHERE d.estado <> i.estado;
END;
GO

CREATE TRIGGER trg_Ejemplar_CambioEstado
ON EJEMPLAR
AFTER UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN deleted d ON i.id_ejemplar = d.id_ejemplar
        WHERE i.estado <> d.estado
    )
    BEGIN
        INSERT INTO HISTORIAL_EJEMPLAR (id_ejemplar, estado_anterior, estado_nuevo, fecha_cambio)
        SELECT d.id_ejemplar, d.estado, i.estado, GETDATE()
        FROM inserted i
        JOIN deleted d ON i.id_ejemplar = d.id_ejemplar
        WHERE i.estado <> d.estado;
    END
END;
