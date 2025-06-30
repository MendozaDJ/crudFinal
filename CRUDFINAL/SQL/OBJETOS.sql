CREATE TYPE TipoListaLibros AS TABLE (
    id_libro INT,
    titulo VARCHAR(200),
    estado VARCHAR(20)
);
GO
CREATE PROCEDURE sp_ProcesarLibros
    @Libros TipoListaLibros READONLY
AS
BEGIN
    -- Ejemplo: Mostrar libros en estado DISPONIBLE
    SELECT *
    FROM @Libros
    WHERE estado = 'DISPONIBLE';
END;
GO

DECLARE @misLibros TipoListaLibros;

INSERT INTO @misLibros (id_libro, titulo, estado)
SELECT id_libro, titulo, 'DISPONIBLE'
FROM LIBRO
WHERE titulo LIKE '%Base de Datos%';

EXEC sp_ProcesarLibros @misLibros;
