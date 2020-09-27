resource "google_dns_record_set" "a-seems-cloud" {
  name = "seems.cloud."
  managed_zone = google_dns_managed_zone.public-seems-cloud.name
  type = "A"
  ttl = 300

  rrdatas = [
    "216.239.32.21",
    "216.239.34.21",
    "216.239.36.21",
    "216.239.38.21"]

  depends_on = [
    google_dns_managed_zone.public-seems-cloud]
}

resource "google_dns_record_set" "aaaa-seems-cloud" {
  name = "seems.cloud."
  managed_zone = google_dns_managed_zone.public-seems-cloud.name
  type = "AAAA"
  ttl = 300

  rrdatas = [
    "2001:4860:4802:32::15",
    "2001:4860:4802:34::15",
    "2001:4860:4802:36::15",
    "2001:4860:4802:38::15"]

  depends_on = [
    google_dns_managed_zone.public-seems-cloud]
}