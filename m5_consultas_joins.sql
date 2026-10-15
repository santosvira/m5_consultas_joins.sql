-- Coderhouse | Modulo 5: Consultas con JOINs para el proyecto
-- Base de datos: Ventas_Tech_DB | SQL Server
USE Ventas_Tech_DB;
GO

-- Consulta 1: Vista base del proyecto (INNER JOIN)
-- Proposito: enriquecer las ventas con datos de cliente, producto y categoria
-- para utilizar el resultado como fuente principal de Power BI.
SELECT
    v.id_venta,
    v.fecha_venta AS fecha,
    c.id_cliente,
    c.nombre AS nombre_cliente,
    c.ciudad,
    p.id_producto,
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    v.cantidad * v.precio_unitario AS total_venta
FROM dbo.ventas AS v
INNER JOIN dbo.clientes AS c ON v.id_cliente = c.id_cliente
INNER JOIN dbo.productos AS p ON v.id_producto = p.id_producto
INNER JOIN dbo.categorias AS cat ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta, v.id_venta;
-- Hallazgo: Se integraron 10 ventas por un total de 6444.00.
-- La vista permite analizar facturacion por ciudad y categoria en Power BI.

-- Consulta 2: Clientes sin ventas (LEFT JOIN)
-- Proposito: identificar clientes registrados sin compras para acciones de CRM.
SELECT
    c.id_cliente,
    c.nombre,
    c.email,
    c.fecha_registro
FROM dbo.clientes AS c
LEFT JOIN dbo.ventas AS v ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL
ORDER BY c.id_cliente;
-- Hallazgo: 0 clientes sin ventas; todos los clientes registrados compraron.
-- CRM no tiene clientes inactivos por ausencia total de compras en estos datos.

-- Consulta 3: Productos sin ventas (LEFT JOIN)
-- Proposito: detectar articulos sin movimiento para revisar el catalogo.
SELECT
    p.id_producto,
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM dbo.productos AS p
INNER JOIN dbo.categorias AS cat ON p.id_categoria = cat.id_categoria
LEFT JOIN dbo.ventas AS v ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL
ORDER BY p.id_producto;
-- Hallazgo: 0 productos sin ventas; todo el catalogo registro movimiento.
-- Producto no identifica articulos sin ventas en el periodo analizado.

-- Consulta 4: Consolidado por periodo (UNION ALL)
-- Proposito: comparar la facturacion de la primera y segunda quincena.
-- La columna origen se genera como texto literal; no existe en las tablas.
SELECT
    consolidado.origen,
    SUM(consolidado.total) AS total_origen
FROM (
    SELECT
        fecha_venta,
        cantidad * precio_unitario AS total,
        'Primera quincena' AS origen
    FROM dbo.ventas
    WHERE DAY(fecha_venta) BETWEEN 1 AND 15

    UNION ALL

    SELECT
        fecha_venta,
        cantidad * precio_unitario AS total,
        'Segunda quincena' AS origen
    FROM dbo.ventas
    WHERE DAY(fecha_venta) >= 16
) AS consolidado
GROUP BY consolidado.origen
ORDER BY total_origen DESC;
-- Hallazgo: La primera quincena genero 6444.00 (100% de las ventas).
-- La segunda quincena no registro operaciones; diferencia: 6444.00.
