/************************************************************
Private EC2 Role
************************************************************/
resource "aws_iam_role" "private_ec2" {
  name = "private-ec2-role"
  tags = {
    Name = "private-ec2-role"
  }
  description = "Allows EC2 to call AWS services on your behalf"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = ""
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "private_ec2" {
  for_each = {
    ssm = "arn:${var.partition}:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }
  role       = aws_iam_role.private_ec2.name
  policy_arn = each.value
}

/************************************************************
Public EC2 Role
************************************************************/
resource "aws_iam_role" "public_ec2" {
  name = "public-ec2-role"
  tags = {
    Name = "public-ec2-role"
  }
  description = "Allows EC2 to call AWS services on your behalf"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = ""
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "public_ec2" {
  for_each = {
    ssm    = "arn:${var.partition}:iam::aws:policy/AmazonSSMManagedInstanceCore"
    s3_ops = aws_iam_policy.s3_ops.arn
  }
  role       = aws_iam_role.public_ec2.name
  policy_arn = each.value
}

/************************************************************
EC2 Instance Profile
************************************************************/
resource "aws_iam_instance_profile" "private_ec2" {
  name = aws_iam_role.private_ec2.name
  role = aws_iam_role.private_ec2.name
}

resource "aws_iam_instance_profile" "public_ec2" {
  name = aws_iam_role.public_ec2.name
  role = aws_iam_role.public_ec2.name
}


/************************************************************
S3 Files Role
************************************************************/
resource "aws_iam_role" "s3_files" {
  name = "s3-files-role"
  tags = {
    Name = "s3-files-role"
  }
  description = "Allows S3 Files (EFS) to call AWS services on your behalf"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowS3FilesAssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "elasticfilesystem.amazonaws.com"
        }
        Action = "sts:AssumeRole"
        Condition = {
          StringEquals = {
            "aws:SourceAccount" = var.account_id
          }
          ArnLike = {
            "aws:SourceArn" = "arn:${var.partition}:s3files:${var.region}:${var.account_id}:file-system/*"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_files" {
  for_each = {
    s3_files = aws_iam_policy.s3_files.arn
  }
  role       = aws_iam_role.s3_files.name
  policy_arn = each.value
}