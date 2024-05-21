
resource "aws_security_group" "dbserversg" {
  description = "DBserver Security Group"
  name = "dbserversg"
  ingress {
    description      = "HTTP from World"
    from_port        = "${var.dbport}"
    to_port          = "${var.dbport}"
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "SSH from World"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_ebs_volume" "dbservervolume" {
  availability_zone = "${var.az}"
  size              = "${var.dbsize}"
  tags = {
    Name = "dbserverVolume"
  }
}

resource "aws_instance" "dbserver" {
  availability_zone = "${var.az}"
  ami = "${var.ami}"
  instance_type = "${var.typeofinstance}"
  key_name = "${var.keyname}"
  vpc_security_group_ids = [aws_security_group.dbserversg.id]
  tags = {
    Name = "dbserverVolume"
  }
}

resource "aws_volume_attachment" "dbservervolumeattach" {
  device_name = "/dev/sdh"
  volume_id = aws_ebs_volume.dbservervolume.id 
  instance_id = aws_instance.dbserver.id
}
