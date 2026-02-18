// File: test/single_table_test.go
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

// TestSingleTable tests creating a single table via the module
func TestSingleTable(t *testing.T) {
	t.Parallel()

	retrySleep := 5 * time.Second
	unique := strings.ToUpper(random.UniqueId())
	dbName := fmt.Sprintf("TT_DB_%s", unique)
	tableName := fmt.Sprintf("TT_TABLE_%s", unique)

	tfDir := "../examples/single-table"

	// Create test database first
	db := openSnowflake(t)
	createTestDatabase(t, db, dbName)
	defer func() {
		dropTestDatabase(t, db, dbName)
		_ = db.Close()
	}()

	tableConfigs := map[string]interface{}{
		"test_table": map[string]interface{}{
			"database":                    dbName,
			"schema":                      "PUBLIC",
			"name":                        tableName,
			"table_type":                  "PERMANENT",
			"drop_before_create":          false,
			"comment":                     "Terratest single table test",
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
					"name":     "NAME",
					"type":     "VARCHAR(255)",
					"nullable": true,
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

	// Wait for Snowflake to propagate the table
	time.Sleep(retrySleep)

	// Use the database context for the query
	_, err := db.Exec(fmt.Sprintf("USE DATABASE %s", dbName))
	require.NoError(t, err, "Failed to use database")

	exists := tableExists(t, db, dbName, "PUBLIC", tableName)
	require.True(t, exists, "Expected table %q to exist in Snowflake", tableName)

	props := fetchTableProps(t, db, dbName, "PUBLIC", tableName)
	require.Equal(t, tableName, props.Name)
	require.Contains(t, props.Comment, "Terratest single table test")
}
