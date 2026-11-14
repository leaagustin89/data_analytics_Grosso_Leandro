USE Ventas_Tech_DB;
GO

-- Consulta 1: ver cada venta con los datos del cliente, producto y categoría.
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

-- Hallazgo: se muestran 10 ventas con su cliente, producto y categoría.

-- Consulta 2: identificar clientes que todavía no realizaron compras.
SELECT
    c.id_cliente,
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes AS c
LEFT JOIN ventas AS v
    ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;

-- Hallazgo: no aparecen clientes sin ventas en los datos revisados.

-- Consulta 3: identificar productos que todavía no fueron vendidos.
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

-- Hallazgo: no aparecen productos sin ventas en los datos revisados.

-- Consulta 4: comparar la facturación del primer y segundo trimestre.
-- La columna canal etiqueta cada período para poder agrupar el resultado.
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

-- Hallazgo: el primer trimestre suma 6.444,00; no hay ventas en el segundo.
