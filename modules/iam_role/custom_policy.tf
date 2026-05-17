/************************************************************
S3 Operation Policy
************************************************************/
resource "aws_iam_policy" "s3_ops" {
  name = "iam-policy-s3-ops-for-ec2"
  tags = {
    Name = "iam-policy-s3-ops-for-ec2"
  }
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowListAllBuckets"
        Effect = "Allow"
        Action = [
          "s3:ListAllMyBuckets"
        ],
        Resource = [
          "*"
        ]
      },
      {
        Sid    = "AllowListOfInsideSpecificBucket"
        Effect = "Allow"
        Action = [
          "s3:ListBucket"
        ],
        Resource = [
          "${var.file_integration_bucket_arn}"
        ]
      },
      {
        Sid    = "AllowWiteOfInsideSpecificBucket"
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject"
        ],
        Resource = [
          "${var.file_integration_bucket_arn}/*"
        ]
      }
    ]
  })
}

/************************************************************
S3 Files Policy
************************************************************/
resource "aws_iam_policy" "s3_files" {
  name = "iam-policy-s3-files"
  tags = {
    Name = "iam-policy-s3-files"
  }
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "S3BucketPermissions"
        Effect = "Allow"
        Action = [
          "s3:ListBucket*"
        ],
        Resource = ["${var.s3_files_bucket_arn}"],
        Condition = {
          StringEquals = {
            "aws:ResourceAccount" = var.account_id
          }
        }
      },
      {
        Sid    = "S3ObjectPermissions"
        Effect = "Allow"
        Action = [
          "s3:AbortMultipartUpload",
          "s3:DeleteObject*",
          "s3:GetObject*",
          "s3:List*",
          "s3:PutObject*"
        ],
        Resource = ["${var.s3_files_bucket_arn}/*"],
        Condition = {
          StringEquals = {
            "aws:ResourceAccount" = var.account_id
          }
        }
      },
      {
        Sid    = "UseKmsKeyWithS3Files"
        Effect = "Allow"
        Action = [
          "kms:GenerateDataKey",
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncryptFrom",
          "kms:ReEncryptTo"
        ],
        Resource = ["arn:${var.partition}:kms:${var.region}:${var.account_id}:*"],
        Condition = {
          StringLike = {
            "kms:ViaService" = "s3.${var.region}.amazonaws.com"
            "kms:EncryptionContext:aws:s3:arn" = [
              "${var.s3_files_bucket_arn}",
              "${var.s3_files_bucket_arn}/*"
            ]
          }
        }
      },
      {
        Sid    = "EventBridgeManage"
        Effect = "Allow"
        Action = [
          "events:DeleteRule",
          "events:DisableRule",
          "events:EnableRule",
          "events:PutRule",
          "events:PutTargets",
          "events:RemoveTargets"
        ],
        Resource = ["arn:${var.partition}:events:*:*:rule/DO-NOT-DELETE-S3-Files*"],
        Condition = {
          StringEquals = {
            "events:ManagedBy" = "elasticfilesystem.amazonaws.com"
          }
        }
      },
      {
        Sid    = "EventBridgeRead"
        Effect = "Allow"
        Action = [
          "events:DescribeRule",
          "events:ListRuleNamesByTarget",
          "events:ListRules",
          "events:ListTargetsByRule"
        ],
        Resource = ["arn:${var.partition}:events:*:*:rule/*"],
      }
    ]
  })
}