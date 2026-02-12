# Multiple Tables Example

This example demonstrates how to create multiple Snowflake tables using the terraform-snowflake-table module.

## Usage

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
