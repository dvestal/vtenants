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

resource "google_service_account" "processor" {
  project      = var.project
  account_id   = "zeus-processor"
  display_name = "Zeus Processor Cloud Function"
}

resource "google_storage_bucket_iam_member" "processor_publicdocuments" {
  bucket = module.publicdocuments.bucket_name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.processor.email}"
}

resource "google_storage_bucket_iam_member" "processor_processingfacility" {
  bucket = module.processingfacility.bucket_name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.processor.email}"
}

resource "google_storage_bucket_iam_member" "processor_privateassets" {
  bucket = module.privateassets.bucket_name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.processor.email}"
}

module "processor" {
  source = "../../../modules/cloudfunction/v0.0.1"

  project               = var.project
  function_name         = "${var.project}-zeus-processor"
  service_account_email = google_service_account.processor.email
}
