/* 1. Como retornar nome e email de todos os clientes? -> SELECT nome, email */

SELECT
	nome
	,email
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_clientes;


/* Como selecionar produtos com preço superior a R$ 200? -> WHERE preco > 200 */

SELECT
	id
	,nome
	, descricao
	, preco
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_produtos
WHERE preco > 200 
ORDER BY preco desc;


/* Como listar pedidos com status concluído? -> WHERE status = "concluido" */ 

SELECT 
	id
	, status
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_pedidos
WHERE status = "concluido";


/* Como ordenar produtos pelo preço mais alto? -> ORDER BY preco DESC */

SELECT
	id
	,nome 
	,preco as maior_valor
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_produtos
ORDER BY preco DESC;


/* Como retornar os dez produtos mais caros? -> ORDER BY preco DESC LIMIT 10 */

SELECT 
	id 
	,nome 
	,preco as mais_caros
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_produtos
ORDER BY preco DESC
LIMIT 10;


/* Como identificar clientes com telefone NULL? WHERE telefon IS NULL*/

SELECT 
	nome
	, telefone
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_clientes
WHERE telefone IS NULL;


/* Como contar quantos clientes existem? COUNT(nome) */

SELECT 
	COUNT(nome) as total_clientes
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_clientes;


/* Como retornar os diferentes status dos pedidos? -> GROUP BY status */
SELECT 
	status
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_pedidos
GROUP BY status;


/* Como filtrar pedidos realizados em determinado mês? */

SELECT 
	id
	,FORMAT_DATE('%B', data_pedido) as mes
FROM `dbt-project-508815`.dbt_airflow_dw_stg.stg_pedidos
WHERE FORMAT_DATE('%B', data_pedido) = "August";










