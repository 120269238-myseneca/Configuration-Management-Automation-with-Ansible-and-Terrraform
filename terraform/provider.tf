provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      course     = "ACS730ZAA.06581.2237"
      term       = "Fall 2023"
      assessment = "Assignment 3"
    }
  }
}
