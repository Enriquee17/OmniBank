SELECT a.account_number, a.account_type
FROM core.accounts a
LEFT JOIN core.transactions t ON t.account_id = a.account_id AND t.tx_type = 'DEPOSIT'
WHERE a.is_active AND t.transaction_id IS NULL
ORDER BY a.account_number;
-- Lectura de la solución: El catálogo de productos solicita una lista más operativa: cuentas activas que aún no registran un depósito. 
-- La actividad ya estableció cómo expresar ausencia; ahora la tarea aplica esa técnica a un tipo de evento concreto 
-- y conserva la comparación de pares de movimientos como evidencia.