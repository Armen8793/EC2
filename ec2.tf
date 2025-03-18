resource "aws_instance" "ubuntu_vm" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.medium"
  key_name               = var.key
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids        = [aws_security_group.ubuntu_sg.id]
  associate_public_ip_address = true
  tags = {
    Name = "Armen-Ubuntu-24"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y python3-pip",
      "pip3 install ansible",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = var.SSH_PRIVATE_KEY
      host        = self.public_ip
     }
  } 
  
 
  provisioner "local-exec" {
  command = <<EOT
    echo "$SSH_PRIVATE_KEY" > /tmp/ssh_key
    chmod 600 /tmp/ssh_key
    eval $(ssh-agent -s)
    ssh-add /tmp/ssh_key > /dev/null
    export ANSIBLE_SSH_ARGS="-o StrictHostKeyChecking=no -i /tmp/ssh_key"
    export ANSIBLE_HOST_KEY_CHECKING=False
    ansible-playbook -i ${self.public_ip}, -u ubuntu docker.yaml -b --private-key /tmp/ssh_key
    rm /tmp/ssh_key
  EOT
}

}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = [var.ami_owner] 

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-${var.ubuntu_version}-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


