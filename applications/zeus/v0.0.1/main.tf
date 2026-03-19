module "publicdocuments" {
  source = "../../../modules/objectstorage/v0.0.1"

  project     = var.project
  bucket_name = "${var.project}-zeus-publicdocuments"
}

module "processingfacility" {
  source = "../../../modules/objectstorage/v0.0.1"

  project     = var.project
  bucket_name = "${var.project}-zeus-processingfacility"
}

module "privateassets" {
  source = "../../../modules/objectstorage/v0.0.1"

  project     = var.project
  bucket_name = "${var.project}-zeus-privateassets"
}
