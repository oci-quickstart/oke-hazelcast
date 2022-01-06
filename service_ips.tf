# This data source and locals extract the public IP CIDRs of OCI services
# These are added to the NSGs of the OKE module to allow helm calls from the
# RMS host.

data "http" "oci_public_ip_ranges" {
  url = "https://docs.oracle.com/en-us/iaas/tools/public_ip_ranges.json"
}

locals {
    # get json
    public_ip_ranges = jsondecode(data.http.oci_public_ip_ranges.body)
    region = var.region #or hardcode eg "eu-stockholm-1"
    particular_region = [for region in local.public_ip_ranges.regions : region.cidrs if region.region == local.region]
    particular_region_all_cidrs_list = [ for cidrs in local.particular_region[0]: cidrs.cidr]
}
