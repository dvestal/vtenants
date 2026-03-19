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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `project` | GCP project id | `string` | — | yes |

## Changelog

### v0.0.1
- Initial implementation
- Provisions `publicdocuments`, `processingfacility`, and `privateassets` GCS buckets via the `objectstorage` module
