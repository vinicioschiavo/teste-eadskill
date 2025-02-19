# EADSKILL Teste de Desenvolvimento de Infraestrutura
Projeto referente ao desafio para vaga de Devops para empresa EADSKILL.


## 1. Criar infraestrutura via terraform
Terraform (https://github.com/vinicioschiavo/teste-eadskill/tree/main/terraform)

Esta configuração do Terraform configura uma infraestrutura AWS com os seguintes componentes:

Visão Geral

1 - Rede:

 - Uma VPC com sub-redes públicas e privadas.

 - Gateway de Internet para sub-redes públicas.

 - Gateway NAT para sub-redes privadas.

2 - Armazenamento:

 - Bucket S3 para backups.

 - Repositório ECR (Elastic Container Registry) para imagens Docker.

3 - EKS (Elastic Kubernetes Service):

 - Cluster EKS.

 - Nods Grupos

 - helm install Nginx

4 - Route53:
  
  - Criação de Route53

5 - RDS (Relational Database Service):

 - Instância de banco de dados PostgreSQL com grupo de sub-rede associado e grupo de segurança.


## 2. Criar fluxo de CI/CD

Visão Geral

Este arquivo define um pipeline CI/CD no GitHub Actions para compilação, envio e implantação de uma aplicação no cluster EKS (Elastic Kubernetes Service). Ele abrange os seguintes estágios:

1 - Gatilhos: Configuração para execução em push ou pull request para o branch main.

2 - Variáveis de Ambiente: Configuração das variáveis necessárias para a execução do pipeline.

3 - Jobs:
 - Build: Compilação e envio da imagem Docker para o Amazon ECR.
 - Deploy: Implantação da aplicação no Kubernetes.

 Gatilhos
O pipeline é ativado pelos seguintes eventos:

![Image](https://github.com/user-attachments/assets/6b829786-0813-4225-b243-8294e3654978)

Isso garante que o pipeline execute quando houver atualizações no branch principal.

Variáveis de Ambiente

As variáveis configuradas para o pipeline incluem:

 - AWS_REGION: Região da AWS (us-west-2).

 - EKS_CLUSTER_NAME: Nome do cluster EKS (eadskill-cluster).

 - NAMESPACE: Namespace no Kubernetes (eadskill).

 - IMAGE_REPO_NAME: Nome do repositório de imagens Docker.

 - IMAGE_TAG: Tag gerada dinamicamente para a imagem Docker baseada no número de execução do GitHub.

Jobs

1. Build
Este job realiza as seguintes etapas:
 - Checkout do Código:
 
 - Configuração do Docker:

 - Configuração do Credenciais-AWS:
    
 - Login no Amazon ECR:
 
 - Build e Push da Imagem Docker:
 

2. Deploy
Este job depende do job "build" e realiza as seguintes etapas:

 - Checkout do Código: 


 - Configuração das Credenciais AWS:


 - Instalação do Kubectl:


 - Atualização do Kubeconfig:


 - Implantação no Kubernetes:



## 4. Validação do deploy via github action.


## 5. Validação do backend rodando localmente.










