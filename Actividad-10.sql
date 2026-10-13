--Actividad 10: tablero de saldos y actividad registrada de OmniBank

--1.Tablero de productos: una fila por tipo cuenta activo

SELECT account_type,
    COUNT(*) AS total_accounts,
    SUM(balance) AS total_balance,
    MIN(balance) AS min_balance,
    MAX(balance) AS max_balance,
    AVG(balance) AS avg_balance
FROM core.accounts
WHERE is_active = TRUE
GROUP BY account_type
ORDER BY total_balance DESC, account_type;

--2.Segmentación de titulares: una fila por cliente elegible

SELECT c.customer_id, c.email,
    COUNT(t.transaction_id)
    SUM(t.amount)
FROM core.customers c
LEFT JOIN core.accounts a
    ON c.customer_id = a.customer_id
LEFT JOIN core.transactions t
    ON a.account_id = t.account_id
GROUP BY c.customer_id,
HAVING COUNT(t.transaction_id) >= 2 OR SUM(t.amount) > 100
ORDER BY c.email;

--WHERE filtra filas antes de agrupar, mientras que  HAVING filtra "grupos" después de agrupar

--3.Control independiente

SELECT account_id,
    COUNT(transaction_id)
    SUM(amount)
FROM core.transactions
GROUP BY account_id
ORDER BY account_id;

--El saldo de CREDIT puede ser cero mientras su volumen registrado es 300 porque saldo viene de accounts.balance y volumen viene de transactions.amount, no son lo mismo.