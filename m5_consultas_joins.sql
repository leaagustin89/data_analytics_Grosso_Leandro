USE Ventas_Tech_DB;
GO

SELECT
    v.fecha_venta,
    v.id_cliente,
    c.nombre AS nombre_cliente,
    c.ciudad,
    v.id_producto,
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    v.cantidad * v.precio_unitario AS total_venta
FROM ventas AS v
INNER JOIN clientes AS c
    ON v.id_cliente = c.id_cliente
INNER JOIN productos AS p
    ON v.id_producto = p.id_producto
INNER JOIN categorias AS cat
    ON p.id_categoria = cat.id_categoria;


SELECT
    c.id_cliente,
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes AS c
LEFT JOIN ventas AS v
    ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;


SELECT
    p.id_producto,
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM productos AS p
LEFT JOIN ventas AS v
    ON p.id_producto = v.id_producto
LEFT JOIN categorias AS cat
    ON p.id_categoria = cat.id_categoria
WHERE v.id_venta IS NULL;


SELECT
    canal,
    SUM(total_venta) AS total_facturado
FROM (
    SELECT
        'Primer trimestre' AS canal,
        cantidad * precio_unitario AS total_venta
    FROM ventas
    WHERE fecha_venta >= '2024-01-01'
      AND fecha_venta < '2024-04-01'

    UNION ALL

    SELECT
        'Segundo trimestre' AS canal,
        cantidad * precio_unitario AS total_venta
    FROM ventas
    WHERE fecha_venta >= '2024-04-01'
      AND fecha_venta < '2024-07-01'
) AS ventas_por_periodo
GROUP BY canal;


