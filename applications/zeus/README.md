# zeus

A Terraform application module that provisions the cloud storage infrastructure for the Zeus workload.

## Usage

```hcl
module "zeus" {
  source  = "git::https://github.com/dvestal/vplatform.git//applications/zeus/v0.0.1?ref=<tag>"
  project = "my-gcp-project"
}
```

## Versions

| Version | Summary |
|---------|------|
| [v0.0.1](./v0.0.1/) | Initial implementation — `publicdocuments`, `processingfacility`, and `privateassets` buckets |
| [v0.0.2](./v0.0.2/) | Adds a `processor` Cloud Function for workload automation |
| [v0.0.3](./v0.0.3/) | Moves Cloud Function stub upload to the shared `pegasus` bucket |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `project` | GCP project id | `string` | — | yes |
| `source_archive_bucket` | GCS bucket containing the processor Cloud Function source zip | `string` | — | yes (v0.0.2 only) |
| `source_archive_object` | GCS object (zip) name containing the processor Cloud Function source | `string` | — | yes (v0.0.2 only) |
| `functionpackages_bucket_name` | Name of the shared GCS bucket from `pegasus` for Cloud Function source uploads | `string` | — | yes (v0.0.3+) |

## Changelog

### v0.0.3
- Moves the Cloud Function stub zip upload from the `processingfacility` bucket to the shared `pegasus` `functionpackages` bucket
- Requires a new `functionpackages_bucket_name` input variable (sourced from the `pegasus` module output)
- Stub object namespaced as `zeus/processor_stub.zip` within the shared bucket to avoid collisions

### v0.0.2
- Adds a `processor` Cloud Function (`modules/cloudfunction/v0.0.1`) for workload automation
- Creates a dedicated `zeus-processor` service account for the function to run as
- Grants the service account `roles/storage.objectAdmin` on all three zeus buckets
- Introduces `source_archive_bucket` and `source_archive_object` input variables for the function source

### v0.0.1
- Initial implementation
- Provisions `publicdocuments`, `processingfacility`, and `privateassets` GCS buckets via the `objectstorage` module
