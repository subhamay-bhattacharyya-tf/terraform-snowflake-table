# Single Table Example

This example demonstrates how to create a single Snowflake table using the terraform-snowflake-table module.

## Usage

Create a `terraform.tfvars` file:

```hcl
table_configs = {
  "users_table" = {
    database           = "MY_DATABASE"
    schema             = "PUBLIC"
    name               = "USERS"
    table_type         = "PERMANENT"
    drop_before_create = false
    comment            = "User information table"
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
```

## Running the Example

```bash
terraform init
terraform plan
terraform apply
```

## Outputs

| Name | Description |
|------|-------------|
| table_names | The names of the created tables |
| table_fully_qualified_names | The fully qualified names of the tables |
