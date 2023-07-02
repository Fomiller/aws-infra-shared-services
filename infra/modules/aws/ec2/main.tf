resource "aws_instance" "app_server" {
  ami           = "ami-0aeeebd8d2ab47354"
  instance_type = "t2.micro"

  tags = {
    Name = "RemoteStateInstance"
  }
}
