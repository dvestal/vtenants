# cloudfunction

A Terraform module that provisions a Google Cloud Function (1st gen) with opinionated defaults for production use.

## Usage

```hcl
module "my_function" {
  source = "git::https://github.com/dvestal/vplatform.git//modules/cloudfunction/v0.0.1?ref=<tag>"

  project               = "my-gcp-project"
  function_name         = "my-function"
  source_archive_bucket = "my-gcp-project-deploy"
  source_archive_object = "functions/my-function.zip"
}
```

## Versions

| Version | Summary |
|---------|---------|
| [v0.0.1](./v0.0.1/) | Initial implementation — Cloud Function with HTTP trigger, configurable runtime, memory, and timeout |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `project` | GCP project id | `string` | — | yes |
| `function_name` | Name of the Cloud Function to create | `string` | — | yes |
| `source_archive_bucket` | GCS bucket that contains the function source zip | `string` | — | yes |
| `source_archive_object` | GCS object (zip) name containing function source | `string` | — | yes |
| `region` | GCP region for the Cloud Function | `string` | `"us-central1"` | no |
| `runtime` | Function runtime (e.g. `python39`, `nodejs18`) | `string` | `"python39"` | no |
| `entry_point` | Function entry point | `string` | `"handler"` | no |
| `available_memory_mb` | Memory for the function in MB | `number` | `256` | no |
| `timeout` | Function timeout in seconds | `number` | `60` | no |

## Outputs

| Name | Description |
|------|-------------|
| `function_name` | Cloud Function name |
| `https_trigger_url` | HTTPS trigger URL for the Cloud Function |
| `function_id` | Cloud Function resource id |

## Changelog

### v0.0.1
- Initial implementation
- Creates a `google_cloudfunctions_function` (1st gen) resource with a configurable runtime, entry point, memory, and timeout
- Source archive is referenced from a GCS bucket; `source_archive_bucket` and `source_archive_object` are excluded from lifecycle drift detection to allow out-of-band code deployments without triggering a Terraform diff
- Applies a `managed_by = "terraform"` label to the function
