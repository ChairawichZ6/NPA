##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  access_key = "ASIAUYRZEE33Y4J74GVB"
  secret_key = "K8W6UrtNPgygHM6MSuZ7vDRTNsZfHH1fZuCKIHJL"
  token      = "FwoGZXIvYXdzEHUaDDSQ3dJRsjFWXF+QCiLIAd5CT2wo2rgsMU9QvfG9T+1i684py1io/OenXfuXryUCElt/HfGuPZIA/U+U4/vSn2jBRAnSjDja9xLL7huGJItciWRYgFZAfG3+NEUvXSGhdQP0kql570YJI5JijYaFx+Z9HgV1A9xbVq4ztbATZlMaPurCz5q7GeMMzoN66tF8VPW2Dxdk1n3zVJJbr9rpIyBKxRMh1eOqEFnnPQUCt7K5Boqd2/dlTeOABt2IaWsbe5R+ZRcSS18ThzlhfiBopxOYTcnKaxeAKLnKiaEGMi1NzNWhES7GVHbN+QJCpa3kpihh7h2WV+0DwG8e2dudrB14rOXmMDCJKxGl6Zw="
  region     = "us-east-1"
}

##################################################################################
# DATA
##################################################################################

data "aws_ami" "aws-linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


##################################################################################
# RESOURCES
##################################################################################

#This uses the default VPC.  It WILL NOT delete it on destroy.
resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "sg1" {
  name        = "npaWk11_demo"
  description = "Allow all"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "testweb" {
  ami                    = data.aws_ami.aws-linux.id
  instance_type          = "t2.micro"
  key_name               = "vockey"
  vpc_security_group_ids = [aws_security_group.sg1.id]

}

##################################################################################
# OUTPUT
##################################################################################

output "aws_instance_public_dns" {
  value = aws_instance.testweb.public_dns
}