/* Joins e relacionamentos 10/10/2026 */

/* Como retornar cada pedido com o nome do cliente? */

SELECT 
	pd.id as id_pedido
	,pd.cliente_id as id_cliente
	,c.nome as nome_cliente
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_pedidos as pd
LEFT JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_clientes as c
ON c.id = pd.cliente_id


/* Como listar produtos com os nomes de suas categorias? */ 

SELECT 
	p.nome as nome_produto
	,c.nome as nome_categoria
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_produtos as p 
LEFT JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_categorias as c
on p.categoria_id = c.id 


/* Como retornar pedidos com seus respectivos pagamentos? */

SELECT 
	p.id as id_pedido
	,pg.id as id_pagamento
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_pedidos as p
LEFT JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_pagamentos as pg
on p.id = pg.pedido_id 


/* Como listar os produtos de cada pedido? */

SELECT 
	it.pedido_id
	,it.produto_id
	, p.nome as nome_produto
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_itens_pedidos as it
LEFT JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_produtos as p
ON it.produto_id = p.id;












