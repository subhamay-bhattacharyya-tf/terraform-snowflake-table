// File: test/multiple_tables_test.go
package test

import (
	"fmt"
	"os"
	"strings"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/require"
)

// TestMultipleTables tests creating multiple tables via the module
func TestMultipleTables(t *testing.T) {
	t.Parallel()

	retrySleep := 5 * time.Second
	unique := strings.ToUpper(random.UniqueId())

	dbName := fmt.Sprintf("TT_DB_%s", unique)
	usersTable := fmt.Sprintf("TT_USERS_%s", unique)
	ordersTable := fmt.Sprintf("TT_ORDERS_%s", unique)
	productsTable := fmt.Sprintf("TT_PRODUCTS_%s", unique)

	tfDir := "../examples/multiple-tables"

	// Create test database first
	db := openSnowflake(t)
	createTestDatabase(t, db, dbName)
	defer func() {
		dropTestDatabase(t, db, dbName)
		_ = db.Close()
	}()

	tableConfigs := map[string]interface{}{
		"users_table": map[string]interface{}{
			"database":                    dbName,
			"schema":                      "PUBLIC",
			"name":                        usersTable,
			"comment":                     "Terratest users table",
			"cluster_by":                  nil,
			"data_retention_time_in_days": 1,
			"change_tracking":             false,
			"columns": []interface{}{
				map[string]interface{}{
					"name":     "ID",
					"type":     "NUMBER(38,0)",
					"nullable": false,
					"default":  nil,
					"comment":  nil,
				},
				map[string]interface{}{
					"name":     "EMAIL",
					"type":     "VARCHAR(255)",
					"nullable": false,
					"default":  nil,
					"comment":  nil,
				},
				map[string]interface{}{
					"name":     "CREATED_AT",
					"type":     "TIMESTAMP_NTZ",
					"nullable": false,
					"default":  nil,
					"comment":  nil,
				},
			},
			"primary_key": map[string]interface{}{
				"name": nil,
				"keys": []string{"ID"},
			},
		},
		"orders_table": map[string]interface{}{
			"database":                    dbName,
			"schema":                      "PUBLIC",
			"name":                        ordersTable,
			"comment":                     "Terratest orders table",
			"cluster_by":                  nil,
			"data_retention_time_in_days": 1,
			"change_tracking":             false,
			"columns": []interface{}{
				map[string]interface{}{
					"name":     "ORDER_ID",
					"type":     "NUMBER(38,0)",
					"nullable": false,
					"default":  nil,
					"comment":  nil,
				},
				map[string]interface{}{
					"name":     "USER_ID",
					"type":     "NUMBER(38,0)",
					"nullable": false,
					"default":  nil,
					"comment":  nil,
				},
				map[string]interface{}{
					"name":     "AMOUNT",
					"type":     "NUMBER(10,2)",
					"nullable": false,
					"default":  nil,
					"comment":  nil,
				},
			},
			"primary_key": map[string]interface{}{
				"name": nil,
				"keys": []string{"ORDER_ID"},
			},
		},
		"products_table": map[string]interface{}{
			"database":                    dbName,
			"schema":                      "PUBLIC",
			"name":                        productsTable,
			"comment":                     "Terratest products table",
			"cluster_by":                  nil,
			"data_retention_time_in_days": 1,
			"change_tracking":             true,
			"columns": []interface{}{
				map[string]interface{}{
					"name":     "PRODUCT_ID",
					"type":     "NUMBER(38,0)",
					"nullable": false,
					"default":  nil,
					"comment":  nil,
				},
				map[string]interface{}{
					"name":     "NAME",
					"type":     "VARCHAR(500)",
					"nullable": false,
					"default":  nil,
					"comment":  nil,
				},
				map[string]interface{}{
					"name":     "PRICE",
					"type":     "NUMBER(10,2)",
					"nullable": false,
					"default":  nil,
					"comment":  nil,
				},
			},
			"primary_key": map[string]interface{}{
				"name": nil,
				"keys": []string{"PRODUCT_ID"},
			},
		},
	}

	tfOptions := &terraform.Options{
		TerraformDir: tfDir,
		NoColor:      true,
		Vars: map[string]interface{}{
			"table_configs":               tableConfigs,
			"snowflake_organization_name": os.Getenv("SNOWFLAKE_ORGANIZATION_NAME"),
			"snowflake_account_name":      os.Getenv("SNOWFLAKE_ACCOUNT_NAME"),
			"snowflake_user":              os.Getenv("SNOWFLAKE_USER"),
			"snowflake_role":              os.Getenv("SNOWFLAKE_ROLE"),
			"snowflake_private_key":       os.Getenv("SNOWFLAKE_PRIVATE_KEY"),
		},
	}

	defer terraform.Destroy(t, tfOptions)
	terraform.InitAndApply(t, tfOptions)

	// Wait for Snowflake to propagate the tables
	time.Sleep(retrySleep)

	// Use the database context for the query
	_, err := db.Exec(fmt.Sprintf("USE DATABASE %s", dbName))
	require.NoError(t, err, "Failed to use database")

	// Verify all three tables exist
	for _, tblName := range []string{usersTable, ordersTable, productsTable} {
		exists := tableExists(t, db, dbName, "PUBLIC", tblName)
		require.True(t, exists, "Expected table %q to exist in Snowflake", tblName)
	}

	// Verify properties of products table (has change_tracking enabled)
	props := fetchTableProps(t, db, dbName, "PUBLIC", productsTable)
	require.Equal(t, productsTable, props.Name)
	require.Contains(t, props.Comment, "Terratest products table")
}
