--Tarea 14: Extensión de Self JOIN, matriz de productos y anti JOIN

SELECT a.account_number, a.account_type, c.first_name, c.last_name
FROM core.accounts a
JOIN core.customers c
    ON a.customer_id = c.customer_id
WHERE a.is_active = TRUE
AND NOT EXISTS(SELECT 1 FROM core.transactions t WHERE t.account_id = a.account_id AND t.tx_type = 'DEPOSIT')
ORDER BY a.account_number;

--El reporte tiene una fila por cuenta activa sin depósitos registrados ACCT-1001, ACCT-2001 y ACCT-3002

--Cuentas activas que si tienen algún movimiento
SELECT COUNT(*) AS active_accounts
FROM core.accounts a
    JOIN core.transactions t
    ON a.transaction_id = t.transaction_id
WHERE is_active = TRUE;

--Una cuenta puede carecer de depósitos y aun asi registrar otros movimientos. Por ejemplo:
--ACCT-1001 tiene una transferencia y un retiro, pero no posee eventos de tipo 'DEPOSIT'. En cambio:
--ACCT-3002 no tiene movimientos de ningún tipo.
--Por ello, la ausencia de depósitos no equivale necesariamente a la ausencia total de movimientos.