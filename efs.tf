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


# first mount target for the EFS 
resource "aws_efs_mount_target" "subnet-1" {
  file_system_id  = aws_efs_file_system.project-efs.id
  subnet_id       = aws_subnet.privateSubnet-1.id
  security_groups = [aws_security_group.datalayer-sg.id]
}


# second mount target for the EFS 
resource "aws_efs_mount_target" "subnet-2" {
  file_system_id  = aws_efs_file_system.project-efs.id
  subnet_id       = aws_subnet.privateSubnet-2.id
  security_groups = [aws_security_group.datalayer-sg.id]
}


# Access point for wordpress
resource "aws_efs_access_point" "wordpress" {
  file_system_id = aws_efs_file_system.project-efs.id

  posix_user {
    gid = 0
    uid = 0
  }

  root_directory {
    path = "/wordpress"

    creation_info {
      owner_gid   = 0
      owner_uid   = 0
      permissions = 0755
    }

  }

}


# Access point for tooling
resource "aws_efs_access_point" "tooling" {
  file_system_id = aws_efs_file_system.project-efs.id
  posix_user {
    gid = 0
    uid = 0
  }

  root_directory {

    path = "/tooling"

    creation_info {
      owner_gid   = 0
      owner_uid   = 0
      permissions = 0755
    }

  }
}
