# -----------------------------------------------------------------------------
# Multiple Tables Example
# -----------------------------------------------------------------------------

module "tables" {
  source = "../../"

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
