--Actividad 9: reportes relacionales para operaciones de OmniBank

--Reporte 1:

SELECT t.transaction_id, c.first_name, c.last_name, a.account_number, t.tx_type, t.amount
FROM core.transactions t
    JOIN core.accounts a
    ON t.account_id = a.account_id
    JOIN core.customers c
    ON a.customer_id = c.customer_id
ORDER BY t.tx_timestamp, t.transaction_id;

--Cada fila representa un movimiento porque parte de core.transactions

--Reporte 2

SELECT a.account_number, a.is_active,
FROM core.accounts a
   LEFT JOIN core.transactions t
   ON a.account_id = t.account_id
WHERE t.transaction_id IS NULL;

--Se utiliza un LEFT JOIN para conservar todas las cuentas y después el WHERE t.transaction_id IS NULL para localizar aquellas que no tienen transacciones relacionadas.
--ACCT-1002 Desactivada
--ACCT-3002 Activa

--Reporte 3:

SELECT c.email, a.account_number, a.balance
FROM core.customers c
   LEFT JOIN core.accounts a
   ON c.customer_id = a.customer_id
AND a.balance > 0;

--El filtro a.balance > 0 se coloca dentro del ON para conservar todos los clientes aunque no cumplan con la condición, si el mismo filtro se mueve a WHERE las filas que no cumplan son eliminadas y desaparecen del resultado.