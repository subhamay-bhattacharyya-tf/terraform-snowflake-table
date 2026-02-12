# -----------------------------------------------------------------------------
# Single Table Example
# -----------------------------------------------------------------------------

module "table" {
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
