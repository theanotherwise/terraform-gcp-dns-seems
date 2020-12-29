resource "google_dns_record_set" "aaaa-seems-legal" {
  name = "raszyn.seems.legal."
  managed_zone = google_dns_managed_zone.public-seems-legal.name
  type = "A"
  ttl = 300

  rrdatas = [
    "45.137.227.44"]

  depends_on = [
    google_dns_managed_zone.public-seems-legal]
}