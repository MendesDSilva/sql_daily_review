/* Joins e relacionamentos */

/* Como retornar cada pedido com o nome do cliente? */

SELECT 
	pd.id as id_pedido
	,pd.cliente_id as id_cliente
	,c.nome as nome_cliente
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_pedidos as pd
LEFT JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_clientes as c
ON c.id = pd.cliente_id;


/* Como listar produtos com os nomes de suas categorias? */ 

SELECT 
	p.nome as nome_produto
	,c.nome as nome_categoria
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_produtos as p 
LEFT JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_categorias as c
on p.categoria_id = c.id;


/* Como retornar pedidos com seus respectivos pagamentos? */

SELECT 
	p.id as id_pedido
	,pg.id as id_pagamento
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_pedidos as p
LEFT JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_pagamentos as pg
on p.id = pg.pedido_id;


/* Como listar os produtos de cada pedido? */

SELECT 
	it.pedido_id
	,it.produto_id
	, p.nome as nome_produto
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_itens_pedidos as it
LEFT JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_produtos as p
ON it.produto_id = p.id;


/* Como identificar clientes que nunca realizaram pedidos? -> LEFT JOIN + WHERE pedido_id IS NULL */ 

SELECT 
	c.id as id_cliente
	,c.nome as cliente
	,p.id as id_pedido
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_clientes as c
LEFT JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_pedidos as p
ON c.id = p.cliente_id 
WHERE p.id IS NULL
GROUP BY id_cliente, cliente, id_pedido;


/* Como identificar produtos que nunca foram vendidos? */

SELECT 
	pr.id as id_produto
	,pr.nome as nome_produto
	,ip.produto_id
	
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_produtos as pr 
LEFT JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_itens_pedidos as ip
ON pr.id = ip.produto_id 
WHERE ip.produto_id IS NULL
GROUP BY id_produto, nome_produto, ip.produto_id;


/* Como retornar clientes e suas avaliações de produtos? */

SELECT 
	c.id as cliente_id
	,c.nome
	,a.produto_id 
	,p.nome as produto
	,a.nota
	,a.comentario
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_clientes as c
INNER JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_avaliacoes as a 
ON c.id = a.cliente_id 
INNER JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_produtos as p
ON p.id = a.produto_id
GROUP BY cliente_id, nome, produto_id, produto, nota, comentario;


/* Como identificar produtos que nunca receberam avaliações? */ 

SELECT 
	p.id as id_produto
	,p.nome as produto 
	,a.nota
	,a.comentario 
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_produtos as p 
LEFT JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_avaliacoes as a 
ON a.produto_id = p.id 
WHERE a.comentario IS NULL;


/* Como listar os itens do carrinho com o nome do produto? */

SELECT 
	c.produto_id as id_produto
	,p.nome as produto
	,c.quantidade
	,c.data_adicionado
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_carrinho as c
LEFT JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_produtos as p 
ON p.id = c.produto_id 
GROUP BY 1,2,3,4;


/* Como relacionar clientes, pedidos e itens_pedidos? */

SELECT 
*
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_pedidos as p
INNER JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_clientes as c
ON p.cliente_id = c.id 
INNER JOIN  `dbt-project-508815`.dbt_airflow_dw_stg.stg_itens_pedidos as i
ON I.pedido_id = p.id;


/* Como calcular o total de cada pedido sem duplicar valores? */

SELECT
	pedido_id
	,produto_id
	,quantidade
	,preco_unitario
	,subtotal
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_itens_pedidos
GROUP BY 1,2,3,4,5;


/* Como identificar pedidos sem pagamento registrado? */

SELECT 
	p.id as id_pedido
	,pg.id as id_pagamento
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_pedidos as p
LEFT JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_pagamentos as pg
ON pg.pedido_id = p.id 
WHERE pg.id IS NULL;


/* Como retornar pagamentos de clientes específicos? */

SELECT 
	pg.id as id_pagamento
	,c.nome as nome_cliente
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_pedidos as p
LEFT JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_pagamentos as pg
ON pg.pedido_id = p.id 
LEFT JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_clientes as c
ON c.id = p.cliente_id 
WHERE c.nome = 'ryan da luz';


/* Como identificar produtos presentes no carrinho mas nunca comprados pelo mesmo cliente? */


















