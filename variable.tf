
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



variable "mydb_identifier" {
  description = "The name of the RDS instance"
  type        = string
  default     = "mydb-instance"
  
}


variable "mydb_engine" {
  description = "The database engine to use"
  type        = string
  default     = "mysql"
  
}


variable "mydb_instance_class" {
  description = "The instance class of the RDS instance"
  type        = string
  default     = "db.t3.micro"

}


  variable "mydb_allocated_storage" {
  description = "The allocated storage in GB"    
    type        = number
    default     = 20
    }

    variable "mydb_username" {    
    description = "The master username for the database"
    type        = string
    default     = "dbadmin"
    }

 variable "mydb_password" {    
    description = "The master password for the database"
    type        = string
    default     = "kushal123"
    }

    variable "mydb_skip_final_snapshot" {    
    description = "Whether to skip the final snapshot"  
    type        = bool
    default     = true
    }


