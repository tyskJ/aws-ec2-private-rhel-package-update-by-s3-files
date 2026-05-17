# フォルダ構成

- フォルダ構成は以下の通り

```
.
├── envs
│   ├── backend.tf                    tfstateファイル管理定義ファイル
│   ├── data.tf                       外部データソース定義ファイル
│   ├── locals.tf                     ローカル変数定義ファイル
│   ├── main.tf                       デプロイリソース定義ファイル
│   ├── outputs.tf                    リソース戻り値定義ファイル
│   ├── providers.tf                  プロバイダー定義ファイル
│   ├── variables.tf                  変数定義ファイル
│   └── versions.tf                   Terraformバージョン定義ファイル
└── modules
    ├── ec2                           Amazon EC2
    │   ├── data.tf
    │   ├── main.tf
    │   ├── outputs.tf
    │   ├── userdata
    │   │   └── linux_init.sh
    │   └── variables.tf
    ├── iam_role                      AWS IAM Role
    │   ├── custom_policy.tf
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    ├── internet_gateway              Internet Gateway
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    ├── key_pair                      Key Pair
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    ├── privateLink                   PrivateLink
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    ├── route_table                   Route Table
    │   ├── locals.tf
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    ├── s3                            S3
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    ├── s3_files                      S3 Files
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    ├── security_group                Security Group
    │   ├── locals.tf
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    ├── subnet                        Subnet
    │   ├── locals.tf
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    └── vpc                           VPC
        ├── main.tf
        ├── outputs.tf
        └── variables.tf
```
