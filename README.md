# vtenants — Versioned Terraform Modules & Multi-Tenancy Demo

This repository is a demonstration of two complementary practices in Terraform-based infrastructure management:

1. **Versioned, reusable modules** — infrastructure primitives and application blueprints that evolve independently and are pinned by version.
2. **Multi-tenancy** — a pattern in which each tenant (client) has its own isolated Terraform workspace that selects the specific module versions appropriate for that client.

All state is managed through **HCP Terraform** (HashiCorp Cloud Platform), which provides a centralised view of every tenant's workspace runs, a shared remote state backend, and plan/apply history across all environments.

---

## Repository Layout

```
.
├── bootstrap/        # Shared infrastructure that must exist before tenants are provisioned
├── modules/          # Low-level infrastructure primitives
├── applications/     # Higher-level application blueprints (compose modules)
└── tenants/          # Per-tenant Terraform root configurations
```

---

## Modules

Modules are the building blocks of this platform. Each module encapsulates a single GCP resource type with opinionated defaults. Multiple versions of a module can coexist in the repository, allowing tenants to upgrade at their own pace.

| Module | Description |
|---|---|
| `modules/objectstorage` | Provisions a Google Cloud Storage (GCS) bucket. Versions cover progressively stronger security and cost-control defaults. |
| `modules/cloudfunction` | Provisions a Google Cloud Function (1st gen). Manages runtime, entry point, memory, timeout, and source archive location. |
| `modules/manageddb` | Provisions a Cloud SQL PostgreSQL instance, database, and user. Includes automated backups, point-in-time recovery, a maintenance window, and connection logging by default. |

---

## Applications

Applications are higher-level Terraform modules that compose one or more primitive modules into a complete, deployable unit. They represent a product or workload, and are also versioned independently.

| Application | Description |
|---|---|
| `applications/pegasus` | Provisions shared infrastructure — currently the GCS bucket used for Cloud Function source package uploads across applications. |
| `applications/poseidon` | Provisions the storage buckets required by the Poseidon workload (public documents and private assets). |
| `applications/zeus` | Provisions the storage buckets required by the Zeus workload (public documents, a processing facility, and private assets). |

In a monorepo style environment, reference modules and applications via a local path, for example:

```hcl
module "poseidon" {
  source  = "../../../applications/poseidon/v0.0.2"
  project = data.google_project.current.project_id
}
```

In the future, when tenants are no longer collocated with the modules and applications (may have their own repo if teams grow and need further separation of concerns), they will reference applications—not individual modules—via a pinned Git source URL, for example:

```hcl
module "poseidon" {
  source  = "git::https://github.com/dvestal/vplatform.git//applications/poseidon?ref=v0.0.2"
  project = data.google_project.current.project_id
}
```

This means a tenant upgrade from one application version to the next is a one-line change.

---

## Tenants

Each directory under `tenants/` is a self-contained Terraform root configuration for a single client. It declares which application versions to deploy and connects to a dedicated **HCP Terraform workspace** for remote state and run management.

| Tenant | Workspace |
|---|---|
| `tenants/client-one` | `client-one` |
| `tenants/client-two` | `client-two` |
| `tenants/template` | Starting-point template for onboarding new clients |

All tenant workspaces belong to the `vestalconsulting` HCP Terraform organization, giving operators a single pane of glass for viewing plan and apply runs, locking state, and auditing changes across every client.

---

## CI: Module Validation

A GitHub Actions workflow (`.github/workflows/validate.yml`) runs `terraform validate` against every versioned module and application on every push to `main` and on pull requests.

```
┌─────────────────────────────────────────────────────┐
│  Git push / Pull Request                            │
└───────────────────┬─────────────────────────────────┘
                    │
                    ▼
┌─────────────────────────────────────────────────────┐
│  check-matrix job                                   │
│                                                     │
│  Scans modules/ and applications/ for any           │
│  directory containing a versions.tf file, and       │
│  tenants/ and bootstrap/ for any directory          │
│  containing a terraform.tf file, then verifies      │
│  that every discovered path appears in the          │
│  workflow's validate matrix.                        │
│                                                     │
│  → Fails fast if a new module version was added     │
│    to the repo but not registered in the matrix.    │
└───────────────────┬─────────────────────────────────┘
                    │  (must pass before validate runs)
                    ▼
┌─────────────────────────────────────────────────────┐
│  validate job  (matrix, one job per module version) │
│                                                     │
│  For each entry in the matrix:                      │
│    1. terraform init -backend=false                 │
│    2. terraform validate                            │
│                                                     │
│  Currently validated paths:                         │
│    • bootstrap                                      │
│    • modules/cloudfunction/v0.0.1                   │
│    • modules/manageddb/v0.0.1                       │
│    • modules/objectstorage/v0.0.1 – v0.0.3          │
│    • applications/pegasus/v0.0.1                    │
│    • applications/poseidon/v0.0.1 – v0.0.2          │
│    • applications/zeus/v0.0.1 – v0.0.3          │
│    • tenants/client-one, client-two, template       │
└─────────────────────────────────────────────────────┘
```

The `-backend=false` flag allows initialization to succeed in CI without access to real provider credentials or a live HCP Terraform workspace, while still resolving module sources and checking configuration syntax and type correctness.

Every new module version added to the repository must be registered in the workflow matrix—the `check-matrix` job enforces this automatically, making it impossible to silently skip validation for a new version.
