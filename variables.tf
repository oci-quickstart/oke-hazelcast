

variable "tenancy_ocid" {
}

variable "compartment_ocid" {
  description = "Compartment where Compute and Marketplace subscription resources will be created"
}

variable "user_ocid" {
}

variable "region" {
  # List of regions: https://docs.cloud.oracle.com/iaas/Content/General/Concepts/regions.htm#ServiceAvailabilityAcrossRegions
  description = "The oci region where resources will be created."
  type        = string
}
