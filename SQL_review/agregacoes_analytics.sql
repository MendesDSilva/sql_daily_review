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

SELECT
	c.id as id_categoria,
	c.nome as categoria,
	COUNT(a.nota) as total_avaliacoes,
	ROUND(AVG(a.nota),2) as nota_media
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_categorias as c 
INNER JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_produtos as p
ON p.categoria_id = c.id 
INNER JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_avaliacoes as a 
ON a.produto_id = p.id 
GROUP BY id_categoria, categoria
ORDER BY total_avaliacoes, nota_media DESC;


/* 8. Como identificar categorias com maior volume de vendas? */

SELECT 
	c.id as id_categoria,
	c.nome as categoria,
	SUM(i.quantidade) as total_vendido
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_categorias as c
INNER JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_produtos as p
ON p.categoria_id = c.id 
INNER JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_itens_pedidos as i 
ON i.produto_id = p.id
INNER JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_pedidos as pe
ON pe.id = i.pedido_id 
WHERE pe.status = 'concluído'
GROUP BY id_categoria, categoria
ORDER BY total_vendido DESC;


/* 9. Como calcular quantidade total vendida por produto? */

SELECT 	
	p.id as id_produto,
	SUM(i.quantidade) as qtd_vendida
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_produtos as p
INNER JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_itens_pedidos as i
ON i.produto_id = p.id 
INNER JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_pedidos as pe
ON pe.id = i.pedido_id 
WHERE pe.status = 'concluído'
GROUP BY id_produto
ORDER BY qtd_vendida DESC;


/* 10. Como calcular receita por marca? */

SELECT
	p.marca as marca,
	COUNT(DISTINCT pe.id) as total_pedidos,
	SUM(i.quantidade) as unidades_vendidas, 
	ROUND(SUM(i.quantidade*i.preco_unitario),2) as receita
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_produtos as p 
INNER JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_itens_pedidos as i 
ON i.produto_id  = p.id 
INNER JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_pedidos as pe
ON pe.id = i.pedido_id 
WHERE pe.status = 'concluído'
GROUP BY marca 
ORDER BY total_pedidos, unidades_vendidas, receita DESC;


/* 11. Como calcular a quantidade de novos clientes por mês? */

SELECT 
	FORMAT_DATE('%Y-%m', c.data_registro ) as ano_mes,
	COUNT(DISTINCT c.id) as total_clientes
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_clientes as c 
GROUP BY ano_mes
ORDER BY ano_mes;


/* 12. Como calcular a taxa de recompra? */
/* Para calcular a taxa de recompra, precisamos identificar quantos clientes realizaram dois ou mais pedidos concluídos em relação ao total de clientes que realizaram pelo menos um pedido concluído.*/

WITH compras_por_cliente AS (
    SELECT
        cliente_id,
        COUNT(DISTINCT id) AS total_compras
    FROM `dbt-project-508815.dbt_airflow_dw_stg.stg_pedidos`
    WHERE status = 'concluído'
    GROUP BY cliente_id
)

SELECT
    COUNT(*) AS clientes_compradores,
    COUNTIF(total_compras >= 2) AS clientes_recorrentes,
    ROUND(
        SAFE_DIVIDE(
            COUNTIF(total_compras >= 2),
            COUNT(*)
        ) * 100,
        2
    ) AS taxa_recompra_pct
FROM compras_por_cliente;


/* 13. Como identificar clientes com mais de três pedidos concluídos? */
/* No BigQuery, o WHERE é processado antes do agrupamento. Portanto, não pode filtrar o resultado de COUNT(). */

SELECT 
	c.id as id_cliente,
	c.nome as cliente,
	COUNT(DISTINCT p.id) as total_pedidos
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_clientes as c 
INNER JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_pedidos as p
ON p.cliente_id = c.id 
WHERE p.status = 'concluído'
GROUP BY id_cliente, cliente
HAVING COUNT(DISTINCT p.id) > 3
ORDER BY total_pedidos DESC; 


/* 14. Como calcular a participação percentual de cada categoria no faturamento? */ 

WITH faturamento_categoria AS (
    SELECT
        c.id AS id_categoria,
        c.nome AS categoria,
        SUM(i.quantidade * i.preco_unitario) AS faturamento
    FROM `dbt-project-508815.dbt_airflow_dw_stg.stg_categorias` AS c
    INNER JOIN `dbt-project-508815.dbt_airflow_dw_stg.stg_produtos` AS p
    ON p.categoria_id = c.id
    INNER JOIN `dbt-project-508815.dbt_airflow_dw_stg.stg_itens_pedidos` AS i
    ON i.produto_id = p.id
    INNER JOIN `dbt-project-508815.dbt_airflow_dw_stg.stg_pedidos` AS pe
    ON pe.id = i.pedido_id
    WHERE pe.status = 'concluído'
    GROUP BY c.id, c.nome
)

SELECT
    id_categoria,
    categoria,
    ROUND(faturamento, 2) AS faturamento,
    ROUND(
        SAFE_DIVIDE(
            faturamento,
            SUM(faturamento) OVER ()
        ),
        2
    ) AS participacao_percentual
FROM faturamento_categoria
ORDER BY participacao_percentual DESC;



/* 15. Como identificar produtos com estoque baixo? */

SELECT 
	p.id as id_produto,
	p.nome as produto,
	CASE
		WHEN p.estoque >= 900 THEN 'Estoque Alto'
		WHEN p.estoque >= 300 THEN 'Estoque Médio'
		ELSE 'Estoque Baixo'
	END AS nivel_estoque,
	p.estoque as estoque
	
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_produtos as p 
WHERE p.estoque < 300
ORDER BY estoque DESC;


/* 16. Como calcular o valor financeiro total do estoque? */

SELECT 
	ROUND(SUM(p.preco*p.estoque),2) as valor_estoque
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_produtos as p 



/* 17. Como calcular o valor total de pagamentos por método? */

SELECT 
	pg.metodo as metodo,
	COUNT(*) as total_transacoes,
	ROUND(SUM(pg.valor),2) as valor
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_pagamentos as pg
INNER JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_pedidos as p 
ON p.id = pg.pedido_id 
WHERE p.status = 'concluído' AND pg.status ='pago'
GROUP BY metodo
ORDER BY valor DESC;


/* 18. Como calcular o percentual de pagamentos aprovados por método? */

SELECT
    pg.metodo AS metodo,
    COUNT(*) AS total_pagamentos,
    COUNTIF(pg.status = 'pago') AS pagamentos_aprovados,
    ROUND(
        SAFE_DIVIDE(
            COUNTIF(pg.status = 'pago'),
            COUNT(*)
        ) ,
        2
    ) AS percentual_aprovados
FROM `dbt-project-508815.dbt_airflow_dw_stg.stg_pagamentos` AS pg
GROUP BY pg.metodo
ORDER BY percentual_aprovados DESC;


/* 19. Como comparar faturamento mensal e quantidade de pedidos? */

SELECT 
	FORMAT_DATE('%Y-%m',p.data_pedido) as ano_mes,
	COUNT(DISTINCT p.id) as total_pedidos
	,
	ROUND(SUM(i.quantidade*i.preco_unitario),2) as faturamento,
	ROUND(
		SAFE_DIVIDE(
			SUM(i.quantidade*i.preco_unitario),
			COUNT(DISTINCT p.id)
		),
	2
	) as ticket_medio
	
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_pedidos as p
INNER JOIN `dbt-project-508815`.dbt_airflow_dw_stg.stg_itens_pedidos as i 
ON i.pedido_id = p.id
WHERE p.status = 'concluído'
GROUP BY ano_mes
ORDER BY ano_mes;



/* 20. Como calcular a taxa de conversão de carrinhos em compras, considerando as limitações das tabelas disponíveis? */

WITH clientes_carrinho AS (
    SELECT DISTINCT
        cliente_id
    FROM `dbt-project-508815.dbt_airflow_dw_stg.stg_carrinho`
    WHERE cliente_id IS NOT NULL
),

clientes_compras AS (
    SELECT DISTINCT
        cliente_id
    FROM `dbt-project-508815.dbt_airflow_dw_stg.stg_pedidos`
    WHERE status = 'concluído'
)

SELECT
    COUNT(*) AS clientes_com_carrinho,
    COUNTIF(p.cliente_id IS NOT NULL) AS clientes_com_compras,
    ROUND(
        SAFE_DIVIDE(
            COUNTIF(p.cliente_id IS NOT NULL),
            COUNT(*)
        ),
        2
    ) AS percentual_clientes_com_compras
FROM clientes_carrinho AS c
LEFT JOIN clientes_compras AS p
    ON p.cliente_id = c.cliente_id;



