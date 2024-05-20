variable cidr {
  type        = string
  description = "description"
}

variable common_resource_name {
  type        = string
  default= "terraform-day2"
  description = "description"
}

variable machine_type {
  type        = string
  description = "description"
}

variable region {
  type        = string
  description = "description"
}

variable machine_details {
  type        = object({
name=string,
type=string,
ami=string,
public_ip=bool
  })
  description = "description"
}


variable subnets {
  type        = list(object({
    name=string,
    cidr=string,
    type=string,
    availability_zone =string

  }))

  description = "description"
}

variable create_key_file {
  type        = bool
  description = "description"
}

variable key_name {
  type        = string
  description = "description"
}

variable "sender_email" {
  description = "The email address to send emails from"
  type        = string
  default = "lina.elduhemy@gmail.com"
}

variable "recipient_email" {
  description = "The email address to send emails to"
  type        = string
  default = "lina.elduhemy@gmail.com"
}