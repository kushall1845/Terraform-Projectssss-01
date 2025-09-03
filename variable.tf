
variable "vpc-01-cidr" {
        description = "value for vpc-01-cidr"
        type        = string
  
}

variable "vpc-01-name" {
        description = "value for vpc-01-name"
        type        = string


}

variable "instance_count" {

  description = "no of machines to be deployed"  
  type = number
  
}


variable "ami" {


  description = "ami of machines"
  type = string
  
}

variable "instance_type" {

  description = "it tells the type of instance"
  type = string
  
}


variable "key_name" {

  description = "it tells the name of pem key"
  type = string
  
}



