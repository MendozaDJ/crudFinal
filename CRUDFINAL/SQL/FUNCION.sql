CREATE FUNCTION fn_CalcularMulta
(
    @fecha_esperada DATE,
    @fecha_devolucion DATE,
    @monto_por_dia DECIMAL(5,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @dias INT = DATEDIFF(DAY, @fecha_esperada, @fecha_devolucion);
    RETURN CASE 
        WHEN @dias > 0 THEN @dias * @monto_por_dia
        ELSE 0 
    END;
END;
GO

SELECT dbo.fn_CalcularMulta('2025-06-01', GETDATE(), 2.5) AS MultaCalculada;
