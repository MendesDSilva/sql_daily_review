/* Joins e relacionamentos 10/10/2026 */

/* Como retornar cada pedido com o nome do cliente? */

SELECT 
	pd.id as id_pedido
	,pd.cliente_id as id_cliente
	,c.nome as nome_cliente
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_pedidos as pd
LEFT JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_clientes as c
ON c.id = pd.cliente_id
