# objectstorage v0.0.1

Initial implementation of the objectstorage module. Creates a GCS bucket with a `managed_by = "terraform"` label.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `project` | GCP project id | `string` | — | yes |
| `bucket_name` | Name of the GCS bucket to create | `string` | — | yes |
| `location` | Bucket location (e.g. US, EU, us-central1) | `string` | `"US"` | no |
| `storage_class` | GCS storage class | `string` | `"STANDARD"` | no |

## Outputs

| Name | Description |
|------|-------------|
| `bucket_name` | GCS bucket name |
| `bucket_url` | GCS bucket URL (`gs://...`) |
| `bucket_self_link` | GCS bucket self link |

## Changelog

### v0.0.1
- Initial implementation
- Creates a GCS bucket with `managed_by = "terraform"` label
