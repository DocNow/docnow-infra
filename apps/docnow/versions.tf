terraform {
  required_version = "~> 0.12"
  required_providers {
    local      = "~> 1.2"
    aws        = "~>2.13"
    kubernetes = "~>1.8"
    null       = "~> 2.1"
    template   = "~> 2.1"
  }
}
