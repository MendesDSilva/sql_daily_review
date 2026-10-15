/* Joins e relacionamentos */

/* 1. Como retornar cada pedido com o nome do cliente? */

SELECT 
	pd.id as id_pedido
	,pd.cliente_id as id_cliente
	,c.nome as nome_cliente
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_pedidos as pd
LEFT JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_clientes as c
ON c.id = pd.cliente_id;


/* 2. Como listar produtos com os nomes de suas categorias? */ 

SELECT 
	p.nome as nome_produto
	,c.nome as nome_categoria
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_produtos as p 
LEFT JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_categorias as c
on p.categoria_id = c.id;


/* 3. Como retornar pedidos com seus respectivos pagamentos? */

SELECT 
	p.id as id_pedido
	,pg.id as id_pagamento
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_pedidos as p
LEFT JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_pagamentos as pg
on p.id = pg.pedido_id;


/* 4. Como listar os produtos de cada pedido? */

SELECT 
	it.pedido_id
	,it.produto_id
	, p.nome as nome_produto
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_itens_pedidos as it
LEFT JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_produtos as p
ON it.produto_id = p.id;


/* 5. Como identificar clientes que nunca realizaram pedidos? -> LEFT JOIN + WHERE pedido_id IS NULL */ 

SELECT 
	c.id as id_cliente
	,c.nome as cliente
	,p.id as id_pedido
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_clientes as c
LEFT JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_pedidos as p
ON c.id = p.cliente_id 
WHERE p.id IS NULL
GROUP BY id_cliente, cliente, id_pedido;


/* 6. Como identificar produtos que nunca foram vendidos? */

SELECT 
	pr.id as id_produto
	,pr.nome as nome_produto
	,ip.produto_id
	
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_produtos as pr 
LEFT JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_itens_pedidos as ip
ON pr.id = ip.produto_id 
WHERE ip.produto_id IS NULL
GROUP BY id_produto, nome_produto, ip.produto_id;


/* 7. Como retornar clientes e suas avaliações de produtos? */

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


/* 8. Como identificar produtos que nunca receberam avaliações? */ 

SELECT 
	p.id as id_produto
	,p.nome as produto 
	,a.nota
	,a.comentario 
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_produtos as p 
LEFT JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_avaliacoes as a 
ON a.produto_id = p.id 
WHERE a.comentario IS NULL;


/* 9. Como listar os itens do carrinho com o nome do produto? */

SELECT 
	c.produto_id as id_produto
	,p.nome as produto
	,c.quantidade
	,c.data_adicionado
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_carrinho as c
LEFT JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_produtos as p 
ON p.id = c.produto_id 
GROUP BY 1,2,3,4;


/* 10. Como relacionar clientes, pedidos e itens_pedidos? */

SELECT 
*
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_pedidos as p
INNER JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_clientes as c
ON p.cliente_id = c.id 
INNER JOIN  `dbt-project-508815`.dbt_airflow_dw_stg.stg_itens_pedidos as i
ON I.pedido_id = p.id;


/* 11. Como calcular o total de cada pedido sem duplicar valores? */

SELECT
	pedido_id
	,produto_id
	,quantidade
	,preco_unitario
	,subtotal
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_itens_pedidos
GROUP BY 1,2,3,4,5;


/* 12. Como identificar pedidos sem pagamento registrado? */

SELECT 
	p.id as id_pedido
	,pg.id as id_pagamento
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_pedidos as p
LEFT JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_pagamentos as pg
ON pg.pedido_id = p.id 
WHERE pg.id IS NULL;


/* 13. Como retornar pagamentos de clientes específicos? */

SELECT 
	pg.id as id_pagamento
	,c.nome as nome_cliente
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_pedidos as p
LEFT JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_pagamentos as pg
ON pg.pedido_id = p.id 
LEFT JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_clientes as c
ON c.id = p.cliente_id 
WHERE c.nome = 'ryan da luz';


/* 14. Como identificar produtos presentes no carrinho mas nunca comprados pelo mesmo cliente? */

SELECT DISTINCT
    c.cliente_id,
    c.produto_id
FROM `dbt-project-508815.dbt_airflow_dw_stg.stg_carrinho` AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM `dbt-project-508815.dbt_airflow_dw_stg.stg_pedidos` AS p
    INNER JOIN `dbt-project-508815.dbt_airflow_dw_stg.stg_itens_pedidos` AS it
        ON p.id = it.pedido_id
    WHERE p.cliente_id = c.cliente_id
      AND it.produto_id = c.produto_id
);


/* 15. Como retornar categorias que não possuem produtos? */

SELECT 
	c.nome  as categoria	
	,p.nome as produto
	
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_produtos as p
LEFT JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_categorias as c 
ON c.id = p.categoria_id 
WHERE p.nome IS NULL


/* 16. Como identificar clientes que avaliaram um produto que também compraram? */

SELECT 
	c.nome as cliente
	,p.id as pedido 
	,pr.id as id_produto
	,pr.nome as produto
	,a.nota
	,a.comentario
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_clientes as c
INNER JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_pedidos as p 
ON p.cliente_id = c.id 
INNER JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_itens_pedidos as i 
ON i.pedido_id = p.id 
INNER JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_produtos as pr
ON pr.id = i.produto_id 
INNER JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_avaliacoes as a 
ON a.produto_id = pr.id AND a.cliente_id = c.id 










































