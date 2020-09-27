resource "google_dns_managed_zone" "public-seems-cloud" {
  name = "public-seems-cloud"
  dns_name = "seems.cloud."

  visibility = "public"
}