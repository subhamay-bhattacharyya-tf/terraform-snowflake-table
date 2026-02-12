# Changelog

All notable changes to this project will be documented in this file.

## 1.0.0 (2026-02-12)

### ⚠ BREAKING CHANGES

* Module restructured from modules/snowflake-table to root level. Provider source changed from Snowflake-Labs/snowflake to snowflakedb/snowflake.

- Implement snowflake_table resource with dynamic columns and primary key support
- Add input validation for table name, database, schema, columns, and data retention
- Add examples for single-table and multiple-tables configurations
- Update CI workflow with semantic-release plugins and correct paths

### Features

* **examples:** add Snowflake provider config and variables to examples ([b98e5f9](https://github.com/subhamay-bhattacharyya-tf/terraform-snowflake-table/commit/b98e5f908983e8817712ac117cecdcf57dca03e8))
* refactor module to Snowflake table with map-based configuration ([047be75](https://github.com/subhamay-bhattacharyya-tf/terraform-snowflake-table/commit/047be7511ab5135e3bedbed632faa35f5a60b14a))

### Bug Fixes

* **examples:** update Snowflake authenticator to use SNOWFLAKE_JWT ([f6cfdc6](https://github.com/subhamay-bhattacharyya-tf/terraform-snowflake-table/commit/f6cfdc6efd2fec189ac9bc84fc42b7dc6eef451d))

## [unreleased]

### 🚀 Features

- [**breaking**] Refactor module to Snowflake table with map-based configuration
- *(examples)* Add Snowflake provider config and variables to examples

### 🐛 Bug Fixes

- *(examples)* Update Snowflake authenticator to use SNOWFLAKE_JWT

### 🚜 Refactor

- *(main)* Replace lookup functions with direct map access
- *(examples)* Replace ternary operators with coalesce function

### 📚 Documentation

- Update CHANGELOG.md [skip ci]
- Update CHANGELOG.md [skip ci]
- Update CHANGELOG.md [skip ci]
- Update CHANGELOG.md [skip ci]
- Update CHANGELOG.md [skip ci]
- Update CHANGELOG.md [skip ci]
- *(examples)* Update provider reference and refactor configuration
- Update CHANGELOG.md [skip ci]
- Update CHANGELOG.md [skip ci]

### 🧪 Testing

- Add explicit nil values and alignment to table config tests
- *(snowflake)* Add database context setup in table tests

### ⚙️ Miscellaneous Tasks

- *(examples)* Update module source to local path reference
- Update snowflake provider version constraint to ~> 0.99.0
