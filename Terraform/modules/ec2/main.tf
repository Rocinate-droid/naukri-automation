resource "aws_instance" "s3-instance" {
    ami = "ami-020cba7c55df1f615"
    instance_type = "t2.medium"
    key_name = "demokey"
    iam_instance_profile = var.instance-profile
    user_data = file("${path.module}/install-packages.sh")
    tags = {
      name = "s3-instance"
    }
    network_interface {
      network_interface_id = aws_network_interface.s3-network-interface.id
      device_index = 0
    }
}

resource "aws_network_interface" "s3-network-interface" {
  subnet_id = var.subnet-id
  security_groups = [var.security-group-id]
}

resource "aws_eip" "s3-eip" {
    domain = "vpc"
}

resource "aws_eip_association" "s3-eip-association" {
  allocation_id = aws_eip.s3-eip.id
  network_interface_id = aws_network_interface.s3-network-interface.id
}
