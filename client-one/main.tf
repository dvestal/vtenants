module "poseidon" {
  source = "git::https://github.com/dvestal/vplatform-apps.git//poseidon?ref=v0.0.1"

  project  = var.project
  location = var.location
}
