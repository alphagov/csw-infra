variable "region" {
  default = "eu-west-2"
}
variable "dns_zone_fqdn" {
  description = "Fully qualified parent domain name"
}

variable "env" {
  default = "test"
}
variable "sub_domain" {
  description = "Name of the desired DNS Record"
  default     = "test"
}
variable "api_gateway_url" {
  description = "The default URL created by APIGAteway"
}
