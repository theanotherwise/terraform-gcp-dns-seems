provider "google" {
  credentials = ".credentials.json"
  project = "molten-infusion-277321"
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