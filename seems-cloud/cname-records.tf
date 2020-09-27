resource "google_dns_record_set" "cname-www-seems-cloud" {
  name = "www.seems.cloud."
  managed_zone = google_dns_managed_zone.public-seems-cloud.name
  type = "CNAME"
  ttl = 300

  rrdatas = [
    "ghs.googlehosted.com."]

  depends_on = [
    google_dns_managed_zone.public-seems-cloud]
}