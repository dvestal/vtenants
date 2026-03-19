# poseidon

A Terraform application module that provisions the cloud storage infrastructure for the Poseidon workload.

## Usage

```hcl
module "poseidon" {
  source  = "git::https://github.com/dvestal/vplatform.git//applications/poseidon/v0.0.2?ref=<tag>"
  project = "my-gcp-project"
}
```

## Versions

| Version | Summary |
|---------|---------|
| [v0.0.1](./v0.0.1/) | Initial implementation — `publicdocuments` and `privateassets` buckets |
| [v0.0.2](./v0.0.2/) | Renamed `publicdocuments` → `ingest`; includes `moved` block for zero-downtime state migration |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `project` | GCP project id | `string` | — | yes |

## Changelog

### v0.0.2
- Renamed the `publicdocuments` storage bucket module to `ingest` to better reflect its purpose
- Added a `moved` block so existing tenants can upgrade without manually moving Terraform state

### v0.0.1
- Initial implementation
- Provisions `publicdocuments` and `privateassets` GCS buckets via the `objectstorage` module
