provider "aws" {
  region = "us-west-2"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "eadskill-vpc"
  }
}

resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name = "private-subnet-2"
  }
}

resource "aws_db_instance" "postgres_db" {
  identifier        = "eadskill-db"
  engine            = "postgres"
  engine_version    = "17.2"
  instance_class    = "db.t3.medium"
  allocated_storage = 20
  db_name           = "PostgreSQL"  
  username          = "PostgreSQL"
  password          = "PostgreSQL"
  db_subnet_group_name = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  multi_az          = false
  storage_type      = "gp2"
  publicly_accessible = false
  backup_retention_period = 7
  backup_window           = "02:00-03:00"
  skip_final_snapshot  = true
  
  tags = {
    Name = "PostgreSQL"
  }
}

resource "aws_db_subnet_group" "main" {
  name       = "eadskill-db-subnet-group"
  subnet_ids = [aws_subnet.private_1.id, aws_subnet.private_2.id]

  tags = {
    Name = "eadskill-db-subnet-group"
  }
}

resource "aws_security_group" "db_sg" {
  name_prefix = "db-sg-"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "db-security-group"
  }
}

resource "aws_s3_bucket" "eadskill_backups" {
  bucket = "eadskill-backups-bucket"
  force_destroy = true

  tags = {
    Name = "eadskill-backups"
  }
}

resource "aws_eks_cluster" "main" {
  name     = "eadskill-cluster"
  version  = "1.32"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = [aws_subnet.private_1.id, aws_subnet.private_2.id]
  }

  depends_on = [aws_iam_role_policy_attachment.eks_cluster_AmazonEKSClusterPolicy]
}

resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "eks_nodes"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = [aws_subnet.public_1.id, aws_subnet.public_2.id]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  instance_types = ["t3.medium"]

  depends_on = [aws_iam_role_policy_attachment.eks_node_AmazonEKSWorkerNodePolicy]
}

resource "aws_iam_role" "eks_cluster_role" {
  name = "eks_cluster_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_node_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "eks_node_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "eks_node_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_role.name
}

resource "aws_route53_zone" "eadskill" {
  name = "eadskill.com" # Substitua pelo domínio que deseja registrar futuramente
}
resource "aws_route53_record" "nginx_ingress_cname" {
  zone_id = aws_route53_zone.eadskill.zone_id
  name    = "nginx.eadskill.com" # Subdomínio para seu Nginx
  type    = "CNAME"
  ttl     = 300
  records = ["placeholder.eadskill.com"] # Altere depois para o DNS real do seu Nginx
}