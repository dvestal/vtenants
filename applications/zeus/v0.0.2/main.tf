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

# Stub source archive — satisfies GCP's requirement that a function has source
# on initial creation. The lifecycle ignore_changes in the cloudfunction module
# ensures Terraform never overwrites what CI/CD deploys after the first apply.
data "archive_file" "processor_stub" {
  type        = "zip"
  output_path = "${path.module}/processor_stub.zip"

  source {
    content  = "def handler(request):\n    return 'ok'\n"
    filename = "main.py"
  }
}

resource "google_storage_bucket_object" "processor_stub" {
  name   = "processor_stub.zip"
  bucket = module.processingfacility.bucket_name
  source = data.archive_file.processor_stub.output_path
}

module "processor" {
  source = "../../../modules/cloudfunction/v0.0.1"

  project               = var.project
  function_name         = "${var.project}-zeus-processor"
  service_account_email = google_service_account.processor.email
  source_archive_bucket = module.processingfacility.bucket_name
  source_archive_object = google_storage_bucket_object.processor_stub.name
}
