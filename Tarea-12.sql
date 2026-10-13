--Tarea 12: Exclusión segura con NOT EXISTS y NULL

--Consulta extendida cuentas activas sin ningún movimiento

SELECT account_number, is_active
FROM core.accounts a
WHERE a.is_active = TRUE
AND NOT EXISTS (SELECT 1 FROM core.transactions t WHERE t.account_id = a.account_id)
ORDER BY account_number;

--Consulta ausencia de DEPOSIT

SELECT account_number, is_active
FROM core.accounts a
WHERE NOT EXISTS( SELECT 1 FROM core.transactions t WHERE t.account_id = a.account_id AND t.tx_type = 'DEPOSIT')
ORDER BY account_number;

--Demostración NOT IN con NULL

SELECT 5 NOT IN (1, 2, NULL) AS resultado_not_in;

--Cuando un listado contiene valores NULL, usando NOT IN produce un resultado UNKNOWN, ya que SQL no puede determinar si el valor buscado 
--coincide con el elemento nulo. Por esta razón, en consultas de ausencia es mas seguro utilizar NOT EXISTS ya que evita problemas causados por valores NULL.