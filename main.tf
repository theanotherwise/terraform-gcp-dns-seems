provider "google" {
  credentials = ".credentials.json"
  project = "core-300122"
  region = var.region
}

terraform {
  backend "local" {
    path = ".states/terraform.tfstate"
  }
}

resource "random_id" "id" {
  byte_length = 8
}
