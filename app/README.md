# Store API Project

Este é um sistema básico para gerenciamento de produtos. O projeto é composto por uma API REST e uma ferramenta de população de banco de dados.

## Documentação

- [Backend API](backend/README.md)
- [Database Populate](populate/README.md)

## Estrutura do Projeto

O projeto é dividido em duas partes principais:

- `/backend` - API REST para consulta de produtos
- `/populate` - Ferramenta para popular o banco de dados PostgreSQL

## Fluxo de Trabalho

1. O projeto `populate` deve ser executado primeiro para criar e popular o banco de dados.
2. Em seguida, a API do `backend` pode ser iniciada para servir os endpoints.

## Deploy

O deploy deve ser automatizado via GitHub Actions para AWS ECS ou EKS.

### Pipeline de CI/CD

O pipeline de CI/CD realiza as seguintes etapas:

1. Build das imagens Docker para o `backend` e `populate`
2. Push das imagens para o Amazon ECR
3. Deploy dos serviços no Amazon ECS ou EKS

### Infraestrutura na AWS

A infraestrutura na AWS é composta pelos seguintes recursos:

- **ECR**: Armazenamento das imagens Docker
- **ECS ou EKS**: Orquestração dos containers
- **RDS**: Banco de dados PostgreSQL
- **VPC**: Rede isolada para os serviços
- **ALB**: Application Load Balancer para a API

## Sobre o Teste Técnico

Este projeto foi desenvolvido como parte do processo seletivo para a vaga de DevOps na EADSKILL. O objetivo é demonstrar conhecimentos em:

- Banco de dados PostgreSQL
- Containerização com Docker
- Orquestração de containers com AWS ECS ou EKS
- Infraestrutura como código (IaC)
- Pipelines de CI/CD com GitHub Actions

Para mais detalhes sobre cada componente do projeto, consulte a documentação específica linkada acima.