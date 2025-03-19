resource "local_file" "inventory_file" {
  content = templatefile("./inventory.template",
    {
      ec2_public_ip = [aws_instance.ubuntu_vm.public_ip]
    }
  )
  filename = "./inventory"
}
