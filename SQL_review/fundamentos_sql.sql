
/* FUNDAMENTOS 10/10/2026 */

/* 1. Como retornar nome e email de todos os clientes? -> SELECT nome, email */

SELECT
	nome
	,email
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_clientes;


/* 2. Como selecionar produtos com preço superior a R$ 200? -> WHERE preco > 200 */

SELECT
	id
	,nome
	, descricao
	, preco
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_produtos
WHERE preco > 200 
ORDER BY preco desc;


/* 3. Como listar pedidos com status concluído? -> WHERE status = "concluido" */ 

SELECT 
	id
	, status
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_pedidos
WHERE status = "concluido";


/* 4. Como ordenar produtos pelo preço mais alto? -> ORDER BY preco DESC */

SELECT
	id
	,nome 
	,preco as maior_valor
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_produtos
ORDER BY preco DESC;


/* 5. Como retornar os dez produtos mais caros? -> ORDER BY preco DESC LIMIT 10 */

SELECT 
	id 
	,nome 
	,preco as mais_caros
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_produtos
ORDER BY preco DESC
LIMIT 10;


/* 6. Como identificar clientes com telefone NULL? WHERE telefon IS NULL*/

SELECT 
	nome
	, telefone
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_clientes
WHERE telefone IS NULL;


/* 7. Como contar quantos clientes existem? COUNT(nome) */

SELECT 
	COUNT(nome) as total_clientes
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_clientes;


/* 8. Como retornar os diferentes status dos pedidos? -> GROUP BY status */
SELECT 
	status
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_pedidos
GROUP BY status;


/* 9. Como filtrar pedidos realizados em determinado mês? -> FORMAT_DATE('%B', data_pedido) */

SELECT 
	id
	,FORMAT_DATE('%B', data_pedido) as mes
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_pedidos
WHERE FORMAT_DATE('%B', data_pedido) = "August";


/* 10. Como buscar produtos cujo nome contém uma palavra? -> WHERE nome LIKE '% %' */ 

SELECT 
	id
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_produtos
WHERE nome LIKE '% %';


/* 11. Como utilizar BETWEEN para selecionar preços em um intervalo? -> preco BETWEEN 300 and 500 */

SELECT 
	nome
	,preco 
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_produtos
WHERE preco BETWEEN 300 AND 500;


/* 12. Como usar CASE WHEN para classificar produtos por faixa de preço? */

SELECT 
	nome,
	preco,
	CASE 
		WHEN preco < 300 THEN 'baixo valor'
		WHEN preco BETWEEN 300 AND 500 THEN 'medio valor'
		WHEN preco > 500 THEN 'alto valor'
		ELSE 'sem classificacao'
	END AS classificacao
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_produtos
ORDER BY preco DESC;


/* 13. Como calcular o valor total de estoque de cada produto? -> somo, agrupo e ordeno */

SELECT 
	id 
	,nome
	,estoque
	,preco 
	,estoque * preco as total_estoque
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_produtos
ORDER BY total_estoque DESC;


/* 14. Como utilizar COALESCE em comentários de avaliações nulos? COALESCE(comentario, 'sem comentario) */

SELECT
	comentario,
	COALESCE(comentario, 'sem comentario') as comentario_tratado
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_avaliacoes;


/* 15. Como converter data_pedido em mês e ano? */

SELECT 
	data_pedido
	,FORMAT_DATE('%B', data_pedido ) as mes
	,FORMAT_DATE('%Y', data_pedido) as ano
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_pedidos;


/* 16. Como identificar produtos sem estoque? */ 

SELECT
	id
	,nome
	,estoque
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_produtos
WHERE estoque = 0 OR estoque IS NULL;


/* 17. Como retornar marcas distintas de produtos? */ 

SELECT DISTINCT 
	marca
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_produtos;


/* 18. Como calcular o preço médio dos produtos? */

SELECT
	nome
	, ROUND(AVG(preco),2) as preco_medio
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_produtos
GROUP BY nome
ORDER BY preco_medio;


/* 19. Como selecionar pagamentos com status pendente? */

SELECT  
	pedido_id
	,status
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_pagamentos
WHERE status = 'pendente';


/* 20. Como explicar a ordem lógica de execução de uma consulta sobre stg_pedidos? */

/* 
 Etapa	O que acontece
Ordem	Operação	Função
1	FROM	Identifica a tabela de origem
2	WHERE	Filtra os pedidos concluídos
3	GROUP BY	Agrupa os pedidos por mês
4	HAVING	Filtra meses com mais de 10 pedidos
5	SELECT	Define mês e total de pedidos
6	ORDER BY	Ordena pelo total
7	LIMIT	Retorna até cinco linhas
 
no caso do exemplo, 1-FROM acessa a base, depois retorna as colunas 
 */ 

SELECT
    EXTRACT(MONTH FROM data_pedido) AS mes,
    COUNT(*) AS total_pedidos
FROM `dbt-project-508815.dbt_airflow_dw_stg.stg_pedidos`
WHERE status = 'concluído'
GROUP BY mes
HAVING COUNT(*) > 10
ORDER BY total_pedidos DESC
LIMIT 5;



















