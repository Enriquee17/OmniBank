--Actividad 12: Subconsultas correlacionadas y cuentas sin movimientos

--Comprobar promedios

SELECT account_id, AVG(amount) AS promedio
FROM core.transactions
GROUP BY account_id
ORDER BY account_id;

--Subconsulta

SELECT transaction_id, account_id, amount,
    (SELECT AVG(tx.amount)FROM core.transactions tx
     WHERE t.account_id = t.account_id) AS account_avg
FROM core.transactions t
WHERE amount > (SELECT AVG(x.amount) FROM core.transactions x
     WHERE x.account_id = t.account_id)
ORDER BY account_id;

--Uso de NOT EXISTS

SELECT account_number, is_active
FROM core.accounts a
WHERE NOT EXISTS (SELECT 1 FROM core.transactions t WHERE t.account_id = a.account_id)
ORDER BY account_number;

--En la subconsulta del promedio solo aparece un movimiento porque es el que supera la condición de que el monto debe ser mayor a su promedio y 
--en la otra consulta solo aparecen las cuentas sin movimientos, una activa y la otra desactivada. ACCT-1002 = FALSE y ACCT-3002 = TRUE.