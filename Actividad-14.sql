--Actividad 14: Self JOIN, matriz de productos y anti JOIN

--SELF JOIN - Una fila por pareja de movimientos

SELECT t.account_id, t.transaction_id AS primero, x.transaction_id AS segundo, t.amount AS primer_volumen, x.amount AS segundo_volumen
FROM core.transactions t
JOIN core.transactions x
    ON t.account_id = x.account_id
    AND t.transaction_id < x.transaction_id
ORDER BY t.account_id, x.account_id;

--Matriz de posibilidades

WITH tipos AS (SELECT unnest(enum_range(NULL::core.tipo_cuenta)) AS account_type)
SELECT c.first_name, t.account_type
FROM core.customers c
CROSS JOIN tipos t;

--ANTI JOIN - Una fila por combinacion ausente

WHERE NOT EXISTS (SELECT 1 FROM core.accounts a WHERE a.customer_id = c.customer_id AND a.account_type = t.account_type)
ORDER BY t.account_type;