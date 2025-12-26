variable "OS"{
    type = string
    default = "ami-068c0051b15cdb816"
    description = "This is my Linux AMI ID"

}

variable "size"{
    default = "t2.micro"
}

variable "name"{
    default = "Practice-Instance"
}

variable "bucketname" {
    type = string
    default = "nikterraformpractice709341"
}

variable "username" {
    default = "defaultuser"
}