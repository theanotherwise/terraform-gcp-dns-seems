resource "google_dns_record_set" "spf-seems-cloud" {
  name = "seems.cloud."
  managed_zone = google_dns_managed_zone.public-seems-cloud.name
  type = "SPF"
  ttl = 300

  rrdatas = [
    "\"v=spf1 include:_spf.google.com ~all\""]

  depends_on = [
    google_dns_managed_zone.public-seems-cloud]
}