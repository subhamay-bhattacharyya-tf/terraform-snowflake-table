# Changelog

All notable changes to this project will be documented in this file.

## [1.1.0](https://github.com/subhamay-bhattacharyya-tf/terraform-snowflake-table/compare/v1.0.0...v1.1.0) (2026-02-13)

### Features

* refactor to use snowflake_table_constraint for primary keys ([2ad0476](https://github.com/subhamay-bhattacharyya-tf/terraform-snowflake-table/commit/2ad04760f0bd4bd2a3bd05aef1dd2d662adb1f9a))

### Bug Fixes

* **snowflake:** use fully qualified table name for constraint table_id ([2a599cc](https://github.com/subhamay-bhattacharyya-tf/terraform-snowflake-table/commit/2a599ccffa45465c8c1e38bd0088e3e9c337073f))

## [unreleased]

### 🚀 Features

- Refactor to use snowflake_table_constraint for primary keys

### 🐛 Bug Fixes

- *(snowflake)* Use fully qualified table name for constraint table_id

### 📚 Documentation

- Update CHANGELOG.md [skip ci]
## [1.0.0] - 2026-02-12

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
- Update CHANGELOG.md [skip ci]

### 🧪 Testing

- Add explicit nil values and alignment to table config tests
- *(snowflake)* Add database context setup in table tests

### ⚙️ Miscellaneous Tasks

- *(examples)* Update module source to local path reference
- Update snowflake provider version constraint to ~> 0.99.0
- *(release)* Version 1.0.0 [skip ci]
