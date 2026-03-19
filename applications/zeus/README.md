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
|---------|---------|
| [v0.0.1](./v0.0.1/) | Initial implementation — `publicdocuments`, `processingfacility`, and `privateassets` buckets |
| [v0.0.2](./v0.0.2/) | Adds a `processor` Cloud Function for workload automation |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `project` | GCP project id | `string` | — | yes |
| `source_archive_bucket` | GCS bucket containing the processor Cloud Function source zip | `string` | — | yes (v0.0.2+) |
| `source_archive_object` | GCS object (zip) name containing the processor Cloud Function source | `string` | — | yes (v0.0.2+) |

## Changelog

### v0.0.2
- Adds a `processor` Cloud Function (`modules/cloudfunction/v0.0.1`) for workload automation
- Introduces `source_archive_bucket` and `source_archive_object` input variables for the function source

### v0.0.1
- Initial implementation
- Provisions `publicdocuments`, `processingfacility`, and `privateassets` GCS buckets via the `objectstorage` module
