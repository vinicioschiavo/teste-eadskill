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

resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}
