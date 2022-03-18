data "oci_identity_tenancy" "tenancy" {
  tenancy_id = var.tenancy_ocid
}

data "oci_identity_regions" "home-region" {
  filter {
    name   = "key"
    values = [data.oci_identity_tenancy.tenancy.home_region_key]
  }
}

data "local_file" "mancenter_info" {
    filename = "${path.module}/mancenter.txt"
    depends_on = [helm_release.my-release]
}
