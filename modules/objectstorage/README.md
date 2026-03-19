# objectstorage

A Terraform module that provisions a Google Cloud Storage (GCS) bucket with opinionated defaults for production use.

## Usage

```hcl
module "my_bucket" {
  source      = "git::https://github.com/dvestal/vplatform.git//modules/objectstorage/v0.0.3?ref=<tag>"
  project     = "my-gcp-project"
  bucket_name = "my-gcp-project-my-bucket"
}
```

## Versions

| Version | Summary |
|---------|---------|
| [v0.0.1](./v0.0.1/) | Initial implementation — basic bucket with labels |
| [v0.0.2](./v0.0.2/) | Security hardening — versioning, uniform access, public access prevention |
| [v0.0.3](./v0.0.3/) | Cost controls — lifecycle rules for storage class tiering and version expiry |

## Changelog

### v0.0.3
- Added `lifecycle_rule` to transition live objects to Nearline storage after 30 days
- Added `lifecycle_rule` to delete noncurrent (archived) object versions after a configurable retention window
- Added `noncurrent_version_retention_days` variable (default: 90 days)

### v0.0.2
- Added object versioning
- Enabled `uniform_bucket_level_access` to disable per-object ACLs
- Set `public_access_prevention = "enforced"` to prevent accidental public exposure

### v0.0.1
- Initial implementation
- Creates a GCS bucket with `managed_by = "terraform"` label
