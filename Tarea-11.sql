--Tarea 11: Porcentaje de cuentas desactivadas y ventana de revisión temporal

--Porcentaje cuentas desactivadas

SELECT COUNT(*) AS total_accounts,
    COUNT(*) FILTER (WHERE is_active = FALSE) AS inactivo,
    ROUND((COUNT(*) FILTER (WHERE is_active = FALSE)::numeric / COUNT(*)::numeric) * 100,2) AS porcentaje_inactivo
FROM core.accounts;

--Reporte extendido

SELECT transaction_id, tx_timestamp, tx_timestamp + INTERVAL '15 days' AS review,
    AGE(TIMESTAMPTZ '2026-10-01 00:00+00', tx_timestamp) AS age,
FROM core.transactions
WHERE tx_timestamp < TIMESTAMPTZ '2026-09-10 00:00+00'
ORDER BY tx_timestamp, transaction_id;

--Por utilizar una fecha explicita y no CURRENT_DATE, el resultado es reproducible y no cambia aunque el archivo se ejecute otro dia.