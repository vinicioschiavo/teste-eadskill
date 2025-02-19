# EADSKILL Teste de Desenvolvimento de Infraestrutura
Projeto referente ao desafio para vaga de Devops para empresa EADSKILL.


## 1. Criar infraestrutura via terraform

Esta configuração do Terraform configura uma infraestrutura AWS com os seguintes componentes:

Visão Geral

1 - Rede:

 - Uma VPC com sub-redes públicas e privadas.

 - Gateway de Internet para sub-redes públicas.

 - Gateway NAT para sub-redes privadas.

2 - Armazenamento:

 - Bucket S3 para backups.

   ![Image](https://github.com/user-attachments/assets/3768e789-72c4-4166-acce-9d54c64bdcdc)

 - Repositório ECR (Elastic Container Registry) para imagens Docker.

   ![Image](https://github.com/user-attachments/assets/ada8759a-9ec4-4202-a386-e082377fbe72)

3 - EKS (Elastic Kubernetes Service):

 - Cluster EKS.

 - Nods Grupos
   
   ![Image](https://github.com/user-attachments/assets/c363ef11-29f6-4290-8f7b-e21a6c3be9fe)

4 - Route53:
  
  - Criação de Route53

    ![Image](https://github.com/user-attachments/assets/8bad22dd-bf67-44de-8931-b7e3d1d19217)

5 - RDS (Relational Database Service):

 - Instância de banco de dados PostgreSQL com grupo de sub-rede associado e grupo de segurança.

   ![Image](https://github.com/user-attachments/assets/f60195c3-e839-4353-bba7-2765efe8d4f7)


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

 - Checkout do Código
 - Configuração do Docker
 - Configuração do Credenciais-AWS
 - Login no Amazon ECR
 - Build e Push da Imagem Docker
 - Post log in to Amazon ECR

 ![Image](https://github.com/user-attachments/assets/e12c2e49-0d50-4fe8-9a05-47b2a3a0eab7) 

2. Deploy
Este job depende do job "build" e realiza as seguintes etapas:

 - Checkout do Código
 - Configuração das Credenciais AWS
 - Instalação do Kubectl
 - Atualização do Kubeconfig
 - Implantação no Kubernetes

 ![Image](https://github.com/user-attachments/assets/c2a88cf6-c7b0-40de-af0d-87b1aaaa9845)


## 4. Validação do backend rodando localmente.

acessar o cluster : aws eks update-kubeconfig --name eadskill-cluster

mudando para namespace correto : kubectl config set-context arn:aws:eks:us-west-2:399679827371:cluster/eadskill-cluster --namespace eadskill  

fazendo port-forward :"kubectl port-forward pods/backend-744b5bbc69-xt6q4 3000:3000 -n eadskill"

Assim podemos ver localmente app rodando.

 ![Image](https://github.com/user-attachments/assets/37458942-addf-43e6-a9e3-e793dcb695e5)










