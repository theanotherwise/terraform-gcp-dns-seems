resource "google_dns_record_set" "mx-seems-cloud" {
  name = "seems.cloud."
  managed_zone = google_dns_managed_zone.public-seems-cloud.name
  type = "MX"
  ttl = 3600

  rrdatas = [
    "1 aspmx.l.google.com.",
    "5 alt1.aspmx.l.google.com.",
    "5 alt2.aspmx.l.google.com.",
    "10 alt3.aspmx.l.google.com.",
    "10 alt4.aspmx.l.google.com."]

  depends_on = [
    google_dns_managed_zone.public-seems-cloud]
}