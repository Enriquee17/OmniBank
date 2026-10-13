--Actividad 11: Transformaciones escalares y fechas de OmniBank

--Reporte cuentas

SELECT a.account_number, a.is_active, c.email,
    UPPER(TRIM(c.first_name)) AS account_nombre,
    RIGHT(a.account_number,4) AS account_digitos,
    a.balance, a.balance::text As balance_texto
FROM core.accounts a
JOIN core.customers c
    ON a.customer_id = c.customer_id
ORDER BY a.account_number;

--Reporte fecha movimientos

SELECT transaction_id, amount, tx_timestamp, tx_timestamp + INTERVAL '15 days' AS review, amount:text AS amount_nombre
    EXTRACT(YEAR FROM tx_timestamp) AS tx_year,
    EXTRACT(MONTH FROM tx_timestamp) AS tx_month
FROM core.transactions
WHERE tx_timestamp < '2026-09-10 00:00+00'
ORDER BY tx_timestamp, transaction_id;

--Recuentos

SELECT COUNT(*) AS total_accounts
FROM core.accounts;

SELECT COUNT(*) AS total_transactions
FROM core.transactions;