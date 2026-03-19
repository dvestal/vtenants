module "functionpackages" {
  source      = "../../../modules/objectstorage/v0.0.1"
  project     = var.project
  bucket_name = "${var.project}-pegasus-functionpackages"
}
