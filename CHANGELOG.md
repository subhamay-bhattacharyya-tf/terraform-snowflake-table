# Changelog

All notable changes to this project will be documented in this file.

## [2.0.0](https://github.com/subhamay-bhattacharyya-tf/terraform-snowflake-table/compare/v1.1.0...v2.0.0) (2026-02-18)

### ⚠ BREAKING CHANGES

* Module now uses snowflake_unsafe_execute instead of snowflake_table resource for table creation.

- Add table_type support (PERMANENT, TRANSIENT, TEMPORARY)
- Add drop_before_create option to control CREATE OR REPLACE vs CREATE IF NOT EXISTS behavior
- Pin Snowflake provider to ~> 0.99.0
- Update examples and tests with new attributes

### Features

* implement table creation using snowflake_unsafe_execute with table type support ([01ef3b4](https://github.com/subhamay-bhattacharyya-tf/terraform-snowflake-table/commit/01ef3b4ee3d6b7fb65702fd1bb8a05c8c808aec0))
* refactor to single-module repository layout with improved outputs ([0b1b6a0](https://github.com/subhamay-bhattacharyya-tf/terraform-snowflake-table/commit/0b1b6a0eda7d0ae3aad36f6a05ab8a7c3c5158be))
* **schema:** add autoincrement support and table_type configuration ([6e30b7f](https://github.com/subhamay-bhattacharyya-tf/terraform-snowflake-table/commit/6e30b7f6748cd23eca6892608a373e282d0b78c3))

### Bug Fixes

* **snowflake:** replace snowflake_unsafe_execute with snowflake_execute ([bcd86c3](https://github.com/subhamay-bhattacharyya-tf/terraform-snowflake-table/commit/bcd86c3fa864c6bfd6cdb3e84f214c41fc1cd85c))

## [unreleased]

### 🚀 Features

- Refactor to single-module repository layout with improved outputs
- [**breaking**] Implement table creation using snowflake_unsafe_execute with table type support
- *(schema)* Add autoincrement support and table_type configuration

### 🐛 Bug Fixes

- *(snowflake)* Replace snowflake_unsafe_execute with snowflake_execute

### 📚 Documentation

- Update CHANGELOG.md [skip ci]
- *(examples)* Replace primary_key_constraints output with table_types
- Update CHANGELOG.md [skip ci]

### 🎨 Styling

- *(variables)* Align column object attribute formatting

### ⚙️ Miscellaneous Tasks

- *(examples)* Update snowflake provider to >= 1.0.0
## [1.1.0] - 2026-02-13

### 🚀 Features

- Refactor to use snowflake_table_constraint for primary keys

### 🐛 Bug Fixes

- *(snowflake)* Use fully qualified table name for constraint table_id

### 📚 Documentation

- Update CHANGELOG.md [skip ci]
- Update CHANGELOG.md [skip ci]

### ⚙️ Miscellaneous Tasks

- *(release)* Version 1.1.0 [skip ci]
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
