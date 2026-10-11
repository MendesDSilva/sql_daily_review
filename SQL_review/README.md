# SQL Daily Review | Prática Diária de SQL

Repositório dedicado ao estudo contínuo e ao aprimoramento de habilidades em **SQL**, por meio da resolução diária de exercícios, consultas analíticas e desafios inspirados em situações reais do mercado de trabalho.

O objetivo é desenvolver raciocínio lógico, domínio da linguagem SQL e capacidade de solucionar problemas relacionados à **Análise de Dados, Engenharia de Dados e Business Intelligence**, incluindo preparação para entrevistas técnicas.

## Tecnologias utilizadas

- **Google BigQuery:** armazenamento dos dados e execução das consultas SQL.
- **GoogleSQL (Standard SQL):** linguagem utilizada para manipulação e análise dos dados.
- **DBeaver:** desenvolvimento, execução e validação das queries.
- **Visual Studio Code:** organização e manutenção dos scripts SQL.
- **Git e GitHub:** versionamento de código e acompanhamento da evolução dos estudos.

## Estrutura do repositório

```text
sql_daily_review/
│
├── SQL_review/
│   ├── fundamentos_sql.sql
│   ├── joins_relacionamentos.sql
│   ├── agregacoes_analytics.sql
│   ├── window_functions.sql
│   ├── cte_subqueries_modelagem.sql
│   ├── performance_otimizacao.sql
│   ├── sql_eng_dados.sql
│   └── cenarios_reais_entrevistas.sql
│
└── README.md
```

## Conteúdo dos estudos

| Módulo | Conteúdo |
|---|---|
| Fundamentos SQL | SELECT, WHERE, ORDER BY, DISTINCT, CASE WHEN e operadores |
| JOINs e Relacionamentos | INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL JOIN e relacionamentos entre tabelas |
| Agregações e Analytics | GROUP BY, HAVING, COUNT, SUM, AVG, MIN e MAX |
| Window Functions | ROW_NUMBER, RANK, DENSE_RANK, LAG, LEAD e funções com OVER |
| CTEs, Subqueries e Modelagem | WITH, subconsultas, organização de consultas e modelagem relacional |
| Performance e Otimização | Otimização de queries, particionamento, clustering e redução de processamento |
| SQL para Engenharia de Dados | Deduplicação, MERGE, cargas incrementais, tratamento de dados e qualidade |
| Cenários Reais e Entrevistas | Desafios técnicos baseados em problemas empresariais e processos seletivos |

## Ambiente de dados

Os exercícios são desenvolvidos utilizando um banco de dados hospedado no **Google Cloud Platform (GCP)**, por meio do serviço **BigQuery**.

O ambiente permite trabalhar com consultas sobre tabelas relacionais, simulando operações de um sistema de e-commerce, como:

- Análise de clientes e pedidos.
- Relacionamento entre produtos e categorias.
- Análise de pagamentos e faturamento.
- Avaliação do comportamento de compra.
- Identificação de duplicidades e inconsistências.
- Construção de indicadores e métricas de negócio.

## Metodologia de estudo

A prática é organizada por níveis progressivos de dificuldade, com foco na aplicação dos conceitos em problemas reais.

**Nível básico:** desenvolvimento dos fundamentos da linguagem SQL e consultas simples.

**Nível intermediário:** relacionamento entre tabelas, agregações, CTEs e funções analíticas.

**Nível avançado:** otimização de consultas, processamento incremental, deduplicação e desafios de Engenharia de Dados.

**Simulação de entrevistas:** resolução de problemas técnicos que exigem interpretação de requisitos, construção de consultas e explicação da lógica utilizada.

## Objetivos do projeto

- Consolidar o conhecimento em SQL por meio da prática diária.
- Desenvolver autonomia na construção e interpretação de queries.
- Melhorar a capacidade de análise e resolução de problemas.
- Aplicar boas práticas de escrita, organização e otimização de SQL.
- Preparar-se para entrevistas técnicas de Analista de Dados e Engenheiro de Dados.
- Construir um histórico versionado de evolução técnica no GitHub.

## Versionamento e evolução

Os scripts são desenvolvidos e testados no DBeaver, utilizando o BigQuery como mecanismo de execução.

Após a validação, as consultas são organizadas em arquivos `.sql` e versionadas no GitHub.

O repositório será atualizado continuamente conforme novos conceitos, exercícios e desafios forem estudados.

---

**Projeto de estudo contínuo | SQL • BigQuery • Data Analytics • Data Engineering**

**Autor:** Mateus Mendes da Silva

**GitHub:** https://github.com/MendesDSilva/sql_daily_review