--Tarea 13: Extensión de CTE y pipeline de métricas por cuenta

--Reporte final extendido de la actividad 13 - Una fila por moneda

SELECT currency,
    COUNT(*) AS total_accounts,
    SUM(gross_volume) AS total_volume,
    ROUND(AVG(gross_volume),2) AS avg_volume
FROM account_activity
GROUP BY currency
ORDER BY currency;

--Control 1 - Cuentas activas

SELECT COUNT(*) AS active_accounts
FROM core.accounts
WHERE is_active = TRUE;

--Control 2 - Volumen bruto total

SELECT SUM(amount) AS total_volume
FROM core.transactions;