
module "oke" {
  source  = "oracle-terraform-modules/oke/oci"
  version = "4.0.4"

  compartment_id                        =   var.compartment_ocid
  tenancy_id                            =   var.tenancy_ocid
  ssh_private_key                       =   var.ssh_private_key
  ssh_public_key                        =   var.ssh_public_key
  label_prefix                          =   "hazelcast"
  region                                =   var.region
  home_region                           =   lookup(data.oci_identity_regions.home-region.regions[0], "name")
  create_bastion_host                   =   "true"
  create_operator                       =   "false"
  control_plane_allowed_cidrs           =   ["0.0.0.0/0"]
  providers = {
    oci.home = oci.home
  }
}
