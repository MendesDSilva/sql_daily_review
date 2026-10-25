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


/* 1. Como calcular faturamento total por mês? */

SELECT 
	FORMAT_DATE('%Y-%m', p.data_pedido) as ano_mes
	,ROUND(SUM(i.quantidade * i.preco_unitario),2) as total_faturamento

FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_pedidos as p
INNER JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_itens_pedidos as i
ON i.pedido_id = p.id 
WHERE p.status = 'concluído'
GROUP BY ano_mes
ORDER BY ano_mes;


/* 2. Como encontrar os cinco produtos com maior receita? */

SELECT 
	p.id as id_produto
	,p.nome as produto
	,ROUND(SUM(i.preco_unitario*i.quantidade),2) as total_faturamento
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_itens_pedidos as i
INNER JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_produtos as p
ON p.id = i.produto_id 
INNER JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_pedidos as pe
ON pe.id = i.pedido_id 
WHERE pe.status = 'concluído'
GROUP BY 1,2
ORDER BY total_faturamento DESC
LIMIT 5;


/* 3. Como calcular ticket médio por pedido? */

SELECT
    ROUND(
        SAFE_DIVIDE(
            SUM(i.quantidade * i.preco_unitario),
            COUNT(DISTINCT p.id)
        ),
        2
    ) AS ticket_medio
FROM `dbt-project-508815.dbt_airflow_dw_stg.stg_itens_pedidos` AS i
INNER JOIN `dbt-project-508815.dbt_airflow_dw_stg.stg_pedidos` AS p
    ON p.id = i.pedido_id
WHERE p.status = 'concluído';


/* 4. Como identificar os dez clientes que mais gastaram? */

SELECT 
	c.id as id_cliente,
	c.nome as cliente,
	ROUND(SUM(i.quantidade*i.preco_unitario),2) as faturamento
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_pedidos as p
INNER JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_itens_pedidos as i
ON i.pedido_id = p.id 
INNER JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_clientes as c
ON c.id = p.cliente_id 
WHERE p.status = 'concluído'
GROUP BY id_cliente, cliente
ORDER BY faturamento DESC
LIMIT 10;


/* 5. Como calcular o número de pedidos por cliente? */

SELECT 
	c.id as id_cliente, 
	COUNT(DISTINCT p.id) as pedidos
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_pedidos as p
INNER JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_clientes as c
ON c.id = p.cliente_id 
WHERE p.status = 'concluído'
GROUP BY id_cliente
ORDER BY pedidos DESC;


/* 6. Como calcular a nota média de cada produto? */

SELECT 
	p.id as produto,
	ROUND(AVG(a.nota),2) as nota_media
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_produtos as p 
INNER JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_avaliacoes as a
ON a.produto_id = p.id 
GROUP BY produto
ORDER BY nota_media DESC; 


/* 7. Como calcular a nota média por categoria? */



