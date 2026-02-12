# Terraform Snowflake Module - Table

![Release](https://github.com/subhamay-bhattacharyya-tf/terraform-snowflake-table/actions/workflows/ci.yaml/badge.svg)&nbsp;![Snowflake](https://img.shields.io/badge/Snowflake-29B5E8?logo=snowflake&logoColor=white)&nbsp;![Commit Activity](https://img.shields.io/github/commit-activity/t/subhamay-bhattacharyya-tf/terraform-snowflake-table)&nbsp;![Last Commit](https://img.shields.io/github/last-commit/subhamay-bhattacharyya-tf/terraform-snowflake-table)&nbsp;![Release Date](https://img.shields.io/github/release-date/subhamay-bhattacharyya-tf/terraform-snowflake-table)&nbsp;![Repo Size](https://img.shields.io/github/repo-size/subhamay-bhattacharyya-tf/terraform-snowflake-table)&nbsp;![File Count](https://img.shields.io/github/directory-file-count/subhamay-bhattacharyya-tf/terraform-snowflake-table)&nbsp;![Issues](https://img.shields.io/github/issues/subhamay-bhattacharyya-tf/terraform-snowflake-table)&nbsp;![Top Language](https://img.shields.io/github/languages/top/subhamay-bhattacharyya-tf/terraform-snowflake-table)&nbsp;![Custom Endpoint](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/bsubhamay/8b4843214cdca464f78333e13d49cc2b/raw/terraform-snowflake-table.json?)

A Terraform module for creating and managing Snowflake tables using a map of configuration objects. Supports creating single or multiple tables with a single module call.

## Features

- Map-based configuration for creating single or multiple tables
- Built-in input validation with descriptive error messages
- Support for column definitions with types, nullability, and defaults
- Primary key support
- Change tracking and data retention configuration
- Clustering key support
- Outputs keyed by table identifier for easy reference

## Usage

### Single Table

```hcl
module "table" {
  source = "github.com/subhamay-bhattacharyya-tf/terraform-snowflake-table"

  table_configs = {
    "users_table" = {
      database = "MY_DATABASE"
      schema   = "PUBLIC"
      name     = "USERS"
      comment  = "User information table"
      columns = [
        {
          name     = "ID"
          type     = "NUMBER(38,0)"
          nullable = false
        },
        {
          name     = "EMAIL"
          type     = "VARCHAR(255)"
          nullable = false
        },
        {
          name     = "CREATED_AT"
          type     = "TIMESTAMP_NTZ"
          nullable = false
        }
      ]
      primary_key = {
        keys = ["ID"]
      }
    }
  }
}
```

### Multiple Tables

```hcl
module "tables" {
  source = "github.com/subhamay-bhattacharyya-tf/terraform-snowflake-table"

  table_configs = {
    "users_table" = {
      database = "MY_DATABASE"
      schema   = "PUBLIC"
      name     = "USERS"
      comment  = "User information table"
      columns = [
        {
          name     = "ID"
          type     = "NUMBER(38,0)"
          nullable = false
        },
        {
          name     = "EMAIL"
          type     = "VARCHAR(255)"
          nullable = false
        }
      ]
      primary_key = {
        keys = ["ID"]
      }
    }
    "orders_table" = {
      database = "MY_DATABASE"
      schema   = "PUBLIC"
      name     = "ORDERS"
      comment  = "Customer orders table"
      columns = [
        {
          name     = "ORDER_ID"
          type     = "NUMBER(38,0)"
          nullable = false
        },
        {
          name     = "USER_ID"
          type     = "NUMBER(38,0)"
          nullable = false
        },
        {
          name     = "AMOUNT"
          type     = "NUMBER(10,2)"
          nullable = false
        }
      ]
      primary_key = {
        keys = ["ORDER_ID"]
      }
    }
  }
}
```

## Examples

- [Single Table](examples/single-table) - Create a single table
- [Multiple Tables](examples/multiple-tables) - Create multiple tables

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.3.0 |
| snowflake | >= 0.87.0 |

## Providers

| Name | Version |
|------|---------|
| snowflake | >= 0.87.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| table_configs | Map of configuration objects for Snowflake tables | `map(object)` | `{}` | no |

### table_configs Object Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| database | string | - | Database name (required) |
| schema | string | - | Schema name (required) |
| name | string | - | Table name (required) |
| comment | string | null | Description of the table |
| cluster_by | list(string) | null | Columns to cluster by |
| data_retention_time_in_days | number | 1 | Data retention period (0-90 days) |
| change_tracking | bool | false | Enable change tracking |
| columns | list(object) | - | Column definitions (required) |
| primary_key | object | null | Primary key definition |

### Column Object Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| name | string | - | Column name (required) |
| type | string | - | Snowflake data type (required) |
| nullable | bool | true | Allow NULL values |
| default | string | null | Default value |
| comment | string | null | Column description |

### Primary Key Object Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| name | string | null | Constraint name |
| keys | list(string) | - | Column names for primary key (required) |

## Outputs

| Name | Description |
|------|-------------|
| table_names | Map of table names keyed by identifier |
| table_fully_qualified_names | Map of fully qualified table names (database.schema.table) |
| table_databases | Map of databases containing the tables |
| table_schemas | Map of schemas containing the tables |
| tables | All table resources |

## Validation

The module validates inputs and provides descriptive error messages for:

- Empty table name
- Empty database name
- Empty schema name
- Table with no columns
- Invalid data_retention_time_in_days (must be 0-90)

## Testing

The module includes Terratest-based integration tests:

```bash
cd test
go mod tidy
go test -v -timeout 30m
```

Required environment variables for testing:
- `SNOWFLAKE_ORGANIZATION_NAME` - Snowflake organization name
- `SNOWFLAKE_ACCOUNT_NAME` - Snowflake account name
- `SNOWFLAKE_USER` - Snowflake username
- `SNOWFLAKE_ROLE` - Snowflake role (e.g., "SYSADMIN")
- `SNOWFLAKE_PRIVATE_KEY` - Snowflake private key for key-pair authentication

## CI/CD Configuration

The CI workflow runs on:
- Push to `main`, `feature/**`, and `bug/**` branches (when `*.tf`, `examples/**`, or `test/**` changes)
- Pull requests to `main` (when `*.tf`, `examples/**`, or `test/**` changes)
- Manual workflow dispatch

The workflow includes:
- Terraform validation and format checking
- Examples validation
- Terratest integration tests (output displayed in GitHub Step Summary)
- Changelog generation (non-main branches)
- Semantic release (main branch only)

The CI workflow uses the following GitHub organization variables:

| Variable | Description | Default |
|----------|-------------|---------|
| `TERRAFORM_VERSION` | Terraform version for CI jobs | `1.3.0` |
| `GO_VERSION` | Go version for Terratest | `1.21` |
| `SNOWFLAKE_ORGANIZATION_NAME` | Snowflake organization name | - |
| `SNOWFLAKE_ACCOUNT_NAME` | Snowflake account name | - |
| `SNOWFLAKE_USER` | Snowflake username | - |
| `SNOWFLAKE_ROLE` | Snowflake role (e.g., SYSADMIN) | - |

The following GitHub secrets are required for Terratest integration tests:

| Secret | Description | Required |
|--------|-------------|----------|
| `SNOWFLAKE_PRIVATE_KEY` | Snowflake private key for key-pair authentication | Yes |

## License

MIT License - See [LICENSE](LICENSE) for details.
