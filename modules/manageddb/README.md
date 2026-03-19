# manageddb

A Terraform module that provisions a Cloud SQL PostgreSQL instance with opinionated production defaults, including automated backups, point-in-time recovery, a regular maintenance window, and connection logging.

## Usage

```hcl
module "my_db" {
  source = "git::https://github.com/dvestal/vplatform.git//modules/manageddb/v0.0.1?ref=<tag>"

  project           = "my-gcp-project"
  instance_name     = "my-postgres"
  database_name     = "myapp"
  database_password = var.db_password
}
```

## Versions

| Version | Summary |
|---------|---------|
| [v0.0.1](./v0.0.1/) | Initial implementation — PostgreSQL instance with backups, PITR, maintenance window, and connection logging |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `project` | GCP project id | `string` | — | yes |
| `instance_name` | Name of the Cloud SQL instance | `string` | — | yes |
| `database_name` | Name of the default database to create inside the instance | `string` | — | yes |
| `database_password` | Password for the default database user | `string` | — | yes |
| `region` | GCP region for the Cloud SQL instance | `string` | `"us-central1"` | no |
| `database_version` | PostgreSQL version (e.g. `POSTGRES_15`, `POSTGRES_14`) | `string` | `"POSTGRES_15"` | no |
| `tier` | Machine tier (e.g. `db-f1-micro`, `db-custom-2-7680`) | `string` | `"db-f1-micro"` | no |
| `availability_type` | `REGIONAL` (high availability) or `ZONAL` | `string` | `"ZONAL"` | no |
| `disk_size` | Disk size in GB | `number` | `10` | no |
| `ipv4_enabled` | Assign a public IPv4 address to the instance | `bool` | `false` | no |
| `private_network` | VPC network self-link for private IP access | `string` | `null` | no |
| `database_user` | Username for the default database user | `string` | `"app"` | no |
| `deletion_protection` | Prevent Terraform from deleting the instance | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| `instance_name` | Cloud SQL instance name |
| `instance_connection_name` | Connection name in `project:region:instance` format (for Cloud SQL Auth Proxy) |
| `private_ip_address` | Private IP address of the instance |
| `public_ip_address` | Public IP address of the instance (if `ipv4_enabled = true`) |
| `database_name` | Name of the default database |
| `database_user` | Default database username |

## Changelog

### v0.0.1
- Initial implementation
- Creates a Cloud SQL PostgreSQL instance (`POSTGRES_15` by default) with SSD storage
- Automated daily backups enabled with point-in-time recovery (PITR)
- Maintenance window set to Sunday at 04:00 on the stable update track
- `log_connections` database flag enabled for auditing
- Creates a default database and user inside the instance
- Applies a `managed_by = "terraform"` user label to the instance
