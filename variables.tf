
variable "ami" {
  type = string
  default = "ami-03f4878755434977f"
}

variable "az" {
  type = string
  default = "ap-south-1a"
}

variable "dbsize" {
  type = number
  default = 10
}

variable "dbport" {
  type = string
  default = "3306"
}

variable "typeofinstance" {
  type = string
  default = "t2.small"
}

variable "keyname" {
  type = string
  default = "basilmac"
}
