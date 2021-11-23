

variable "tenancy_ocid" {
}

variable "compartment_ocid" {
  description = "Compartment where Compute and Marketplace subscription resources will be created"
}

variable "user_ocid" {
}

variable "fingerprint" {
}

variable "private_key_path" {
}

variable "region" {
  # List of regions: https://docs.cloud.oracle.com/iaas/Content/General/Concepts/regions.htm#ServiceAvailabilityAcrossRegions
  description = "The oci region where resources will be created."
  type        = string
}

variable "ssh_public_key" {
  description = "SSH Public Key"
}

variable "ssh_private_key" {
  description = "SSH Public Key"
}
