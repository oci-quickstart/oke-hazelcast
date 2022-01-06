
module "oke" {
  source  = "oracle-terraform-modules/oke/oci"
  version = "4.0.4"

  compartment_id                        =   var.compartment_ocid
  tenancy_id                            =   var.tenancy_ocid
  ssh_private_key                       =   tls_private_key.public_private_key_pair.private_key_pem
  ssh_public_key                        =   tls_private_key.public_private_key_pair.public_key_openssh
  label_prefix                          =   "hazelcast"
  region                                =   var.region
  home_region                           =   lookup(data.oci_identity_regions.home-region.regions[0], "name")
  create_bastion_host                   =   "true"
  create_operator                       =   "false"
  control_plane_allowed_cidrs           =   concat(["0.0.0.0/0"], local.particular_region_all_cidrs_list)
  providers = {
    oci.home = oci.home
  }
}

resource "tls_private_key" "public_private_key_pair" {
  algorithm = "RSA"
}
