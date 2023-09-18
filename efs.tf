# create key from key management system
resource "aws_kms_key" "efskey-kms" {
  description = "KMS key "
  policy      = <<EOF
  {
  "Version": "2012-10-17",
  "Id": "kms-key-policy",
  "Statement": [
    {
      "Sid": "Enable IAM User Permissions",
      "Effect": "Allow",
      "Principal": { "AWS": "arn:aws:iam::696742900004:user/project16" },
      "Action": "kms:*",
      "Resource": "*"
    }
  ]
}
EOF
}

# create key alias
resource "aws_kms_alias" "alias" {
  name          = "alias/kms"
  target_key_id = aws_kms_key.efskey-kms.key_id
}

# create Elastic file system
resource "aws_efs_file_system" "project-efs" {
  encrypted  = true
  kms_key_id = aws_kms_key.efskey-kms.arn

  tags = {
    Name            = "file-system"
  }

}
