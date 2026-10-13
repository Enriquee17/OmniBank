--Tarea 10: Promedios con NULL y reporte de actividad de crédito

--1.Construye una muestra de cuatro valores

WITH muestra(valor) AS (
    VALUES(10000::numeric),(0),(0),(NULL::numeric)
)
--Calcula AVG sobre la muestra
SELECT
    AVG(valor) AS promedio_muestra,
    COUNT(valor) AS observacion
FROM muestra;
--Sobre la misma muestra con COALESCE a cero
SELECT
    AVG(COALESCE(valor,0)) AS promedio_coalesce,
    COUNT(COALESCE(valor,0)) AS observacion
FROM muestra;

--2.Reporte CREDIT

SELECT a.account_number, a.balance,
    COUNT(t.transaction_id) AS total_movements,
    COALESCE(SUM(t.amount),0) AS gross_volume
FROM core.accounts a
LEFT JOIN core.transactions t
    ON a.account_id = t.account_id
WHERE a.account_type = 'CREDIT' AND a.is_active = TRUE
GROUP BY a.account_id, a.account_number, a.balance
HAVING COUNT(t.transaction_id) = 0 OR COALESCE(SUM(t.amount),0) >= 300
ORDER BY gross_volume DESC, a.account_number;