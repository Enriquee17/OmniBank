--Actividad 13: CTE y pipeline de métricas por cuenta

--CTE 1 - Una fila por cuenta con movimientos

WITH transaction_account AS (
   SELECT account_id, COUNT(transaction_id) AS total_events, SUM(amount) AS gross_volume
   FROM core.transactions
   GROUP BY account_id
),

--CTE 2 - Una fila por cuenta activa

account_activity AS (
    SELECT a.account_id, a.customer_id, a.account_number, a.currency,
    COALESCE(ta.total_events,0) AS total_events,
    COALESCE(ta.gross_volume,0) AS gross_volume
    FROM core.accounts a
    LEFT JOIN transaction_account ta
        ON a.account_id = ta.account_id
    WHERE a.is_active = TRUE)

--Consulta final

SELECT aa.account_number, c.first_name, c.last_name, aa.currency, aa.total_events, aa.gross_volume,
    CASE WHEN aa.total_events = 0 THEN 'SIN ACTIVIDAD' WHEN aa.total_events <= 1 THEN 'BAJA' ELSE 'ALTA' END AS banda
FROM account_activity aa
JOIN core.customers c
    ON aa.customer_id = c.customer_id
ORDER BY aa.account_number;