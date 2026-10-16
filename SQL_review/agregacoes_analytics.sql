/* 1. Como calcular faturamento total por mês? */

SELECT 
	FORMAT_DATE('%Y-%m', p.data_pedido ) as ano_mes
	,ROUND(SUM(i.preco_unitario*i.quantidade),2) as total_faturamento
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_pedidos as p
INNER JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_itens_pedidos as i 
ON i.pedido_id = p.id 
WHERE p.status = 'concluído'
GROUP BY ano_mes
ORDER BY ano_mes;