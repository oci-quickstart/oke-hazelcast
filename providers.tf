provider "oci" {
  region               = var.region
}

provider "oci" {
  region           = lookup(data.oci_identity_regions.home-region.regions[0], "name")
  alias            = "home"
}
