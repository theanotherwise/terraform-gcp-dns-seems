resource "google_dns_managed_zone" "public-seems-legal" {
  name = "public-seems-legal"
  dns_name = "seems.legal."

  visibility = "public"
}