module "publicdocuments" {
  source      = "../../../modules/objectstorage/v0.0.1"
  project     = var.project
  bucket_name = "${var.project}-poseidon-publicdocuments"
}

module "privateassets" {
  source      = "../../../modules/objectstorage/v0.0.1"
  project     = var.project
  bucket_name = "${var.project}-poseidon-privateassets"
}
