# pegasus

A Terraform application module that provisions shared infrastructure used across multiple applications. Currently it manages the GCS bucket from which Cloud Function source packages are uploaded and served.

## Usage

```hcl
module "pegasus" {
  source  = "../../applications/pegasus/v0.0.1"
  project = "my-gcp-project"
}
```

## Versions

| Version | Summary |
|---------|---------|
| [v0.0.1](./v0.0.1/) | Initial implementation — `functionpackages` bucket for Cloud Function source uploads |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `project` | GCP project id | `string` | — | yes |

## Outputs

| Name | Description |
|------|-------------|
| `functionpackages_bucket_name` | Name of the GCS bucket used for Cloud Function source zip uploads |
| `functionpackages_bucket_url` | GCS URL of the Cloud Function packages bucket |

## Changelog

### v0.0.1
- Initial implementation
- Provisions a `functionpackages` GCS bucket via the `objectstorage` module for storing Cloud Function source zips shared across applications
