variable lb_sg_name {}
variable ag_sg_name {}
variable lb_sg_description {}
variable ag_sg_description {}
variable vpc_id {}
variable application_port {}
variable "protocol_name" {}

resource "aws_security_group" "lb_sg" {
    name = var.lb_sg_name
    description = "${var.lb_sg_description} - ${var.lb_sg_name}"
    vpc_id = var.vpc_id

    ingress {
        description = "Ingress Rule - ${var.protocol_name}"
        from_port = var.application_port
        to_port = var.application_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        description = "Egress Rule - ${var.protocol_name}"
        from_port = var.application_port
        to_port = var.application_port
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "ag_sg" {
    name = var.ag_sg_name
    description = "${var.ag_sg_description} - ${var.ag_sg_name}"
    vpc_id = var.vpc_id

    ingress {
        description = "Ingress Rule - ${var.protocol_name}"
        from_port = var.application_port
        to_port = var.application_port
        protocol = "tcp"
        # security_groups = [aws_security_group.lb_sg.id]
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "Ingress Rule - SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Modify to increase securty for instances in your autoscaling group
    egress {
        description = "Egress Rules -  Allow machine to make external connections to all"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

output "lb_sg_id" {
    value = aws_security_group.lb_sg.id
}

output "ag_sg_id"{
    value = aws_security_group.ag_sg.id
}