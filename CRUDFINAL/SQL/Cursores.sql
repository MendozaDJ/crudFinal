--Cursores (Explícitos)
--préstamos vencidos automáticamente
DECLARE @id_prestamo INT, @fecha_esperada DATE;

DECLARE curPrestamos CURSOR FOR
SELECT id_prestamo, fecha_devolucion_esperada
FROM PRESTAMO
WHERE estado = 'ACTIVO';

OPEN curPrestamos;
FETCH NEXT FROM curPrestamos INTO @id_prestamo, @fecha_esperada;

WHILE @@FETCH_STATUS = 0
BEGIN
    IF @fecha_esperada < CAST(GETDATE() AS DATE)
    BEGIN
        UPDATE PRESTAMO
        SET estado = 'VENCIDO'
        WHERE id_prestamo = @id_prestamo;
    END

    FETCH NEXT FROM curPrestamos INTO @id_prestamo, @fecha_esperada;
END;

CLOSE curPrestamos;
DEALLOCATE curPrestamos;


-----------------
