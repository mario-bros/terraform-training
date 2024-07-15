provider "aws" {
  profile = "default"
  region  = "ap-southeast-1"
}

resource "aws_key_pair" "example" {
  key_name   = "examplekey"
  # public_key = file("~/.ssh/terraform.pub")
  public_key = file("C:/Users/Mario/.aws/aws-public-key")
  
}

resource "aws_instance" "example" {
  key_name      = aws_key_pair.example.key_name
  ami           = "ami-04590e7389a6e577c"
  instance_type = "t2.micro"

  connection {
    type        = "ssh"
    user        = "ec2-user"
    # private_key = file("~/.ssh/terraform")
    private_key = file("C:/Users/Mario/.ssh/id_ed25519")
    
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras enable nginx1.12",
      "sudo yum -y install nginx",
      "sudo systemctl start nginx"
    ]
  }
}