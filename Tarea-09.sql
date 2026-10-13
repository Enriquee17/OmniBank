--Tarea 9: diagnóstico de combinaciones sin relación en OmniBank

--1. Cuantifica la matriz sin relaciones

SELECT COUNT(*) AS total_combinations
FROM core.customers c
CROSS JOIN core.accounts a
CROSS JOIN core.transactions t;

--2. Repara el reporte de movimientos

SELECT c.email, a.account_number, t.tx_type, t.amount, t.tx_timestamp
FROM core.transactions t
   INNER JOIN core.accounts a
   ON t.account_id = a.account_id
   INNER JOIN core.customers c
   ON a.customer_id = c.customer_id
WHERE c.is_active = TRUE AND t.amount >= 100
ORDER BY t.tx_timestamp, t.transaction_id;
