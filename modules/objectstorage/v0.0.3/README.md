# objectstorage v0.0.3

Cost control release. Adds lifecycle rules to automatically tier infrequently accessed objects to cheaper storage classes and expire old object versions, preventing unbounded storage cost growth from versioning.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `project` | GCP project id | `string` | — | yes |
| `bucket_name` | Name of the GCS bucket to create | `string` | — | yes |
| `location` | Bucket location (e.g. US, EU, us-central1) | `string` | `"US"` | no |
| `storage_class` | GCS storage class | `string` | `"STANDARD"` | no |
| `noncurrent_version_retention_days` | Days to retain archived object versions before deletion | `number` | `90` | no |

## Outputs

| Name | Description |
|------|-------------|
| `bucket_name` | GCS bucket name |
| `bucket_url` | GCS bucket URL (`gs://...`) |
| `bucket_self_link` | GCS bucket self link |

## Changelog

### v0.0.3
- Added `lifecycle_rule` to transition live objects to Nearline storage after 30 days
- Added `lifecycle_rule` to delete noncurrent (archived) object versions after `noncurrent_version_retention_days` (default: 90)
- Added `noncurrent_version_retention_days` input variable

### v0.0.2
- Added object versioning — deleted or overwritten objects are retained and recoverable
- Enabled `uniform_bucket_level_access` — disables legacy per-object ACLs in favor of IAM-only access control
- Set `public_access_prevention = "enforced"` — prevents any IAM binding from making the bucket or its objects publicly accessible

### v0.0.1
- Initial implementation
- Creates a GCS bucket with `managed_by = "terraform"` label
