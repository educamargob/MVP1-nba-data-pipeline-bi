# NBA Analytics - MVP PUC-Rio

Projeto desenvolvido como entrega de MVP (Produto Mínimo Viável) para o curso de Pós-Graduação em Ciência de Dados e Analytics da PUC-Rio. O objetivo é criar um pipeline completo de dados da NBA, com armazenamento no Snowflake e visualização em dashboards interativos no Qlik Cloud.

## 🎯 Objetivo

O objetivo principal é construir um pipeline de dados eficiente para coletar, transformar e visualizar estatísticas da NBA, possibilitando a análise de tendências e extração de insights. A plataforma BI utilizada para apresentação dos dados será o Qlik, e o Snowflake será empregado para processamento e armazenamento dos dados (ETL)

---

## ⚙️ Tecnologias Utilizadas

- **Snowflake**: Ingestão, processamento e modelagem dos dados.
- **Qlik Cloud**: Visualização e análise interativa dos dados.
- **GitHub**: Versionamento e centralização dos scripts.
- **Datasets**:
  - [NBA Database](https://www.kaggle.com/datasets/wyattowalsh/basketball)
    - Fonte: API oficial do site [stats.nba.com](https://stats.nba.com)  
    - Autor: Wyatt Walsh
  - (https://www.kaggle.com/datasets/drgilermo/nba-players-stats
    - Fonte: [Basketball Reference](https://www.basketball-reference.com)   
    - Autor: Omri Goldstein

---

## 🏗️ Estrutura do Pipeline

- **Landing Zone**: Armazena os dados brutos.
- **Curated Zone**: Dados tratados e otimizados.
- **Consumption Zone**: Tabelas finais, prontos para consumo no BI.

---

## 📊 Dashboards Desenvolvidos

- **Dashboard**: Visão geral de jogadores e times.
- **Times**: Evolução por temporada, localização e origem.
- **Jogadores**: Dados individuais com filtros e comparações.
- **Estatísticas Jogadores**: Dados estatísticos de jogadores, PTS/G, AST/G, REB/G, etc.
- **Comparativo Jogadores**: Gráfico radar e métricas lado a lado.
- **Drafts**: Perfil dos jogadores draftados.

---

## ❓ Perguntas Respondidas

- Quais equipes revelaram mais estrelas da NBA?
- Como as estatísticas evoluíram ao longo do tempo?
- Qual o impacto da altura no desempenho dos jogadores?
- Quais universidades mais contribuíram para a NBA?

---

## 🔗 Referências dos Dados

- [NBA Database (Kaggle)](https://www.kaggle.com/datasets/wyattowalsh/basketball)
- [NBA Players Stats Since 1950 (Kaggle)](https://www.kaggle.com/datasets/drgilermo/nba-players-stats)

## 📌 Observações
- **Informações detalhadas do trabalho, como metodologia e resultados, podem ser obtidos no PDF do MVP**
- Algumas etapas de tratamento de dados foram feitas manualmente devido a inconsistências entre os datasets.
- O projeto foi estruturado em zonas de dados: Landing, Curated e Consumption.
