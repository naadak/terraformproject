variable "AWS_REGION" {
    description = "AWS region"
    default     = "us-west-2"
}
variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    default     = "10.0.0.0/16"
}
variable "cidr_block" {
    description = "Public CIDR"
    default     = "0.0.0.0/0"
}
variable "AMIs" {
  type = map(string)
  description = "Region specific AMI"
  default = {
    us-west-2 = "ami-0230bd60aa48260c6"
    }
}

variable "db_name" {
  default = "labdb"

}
variable "db_password" {
  default = "labdbpassword"

}
variable "db_user" {
  default = "labdbuser"
}