## [unreleased]

### 🚀 Features

- *(grants)* [**breaking**] Add table grants support for role-based access control
## [2.0.0] - 2026-02-18

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
- Update CHANGELOG.md [skip ci]

### 🎨 Styling

- *(variables)* Align column object attribute formatting

### ⚙️ Miscellaneous Tasks

- *(examples)* Update snowflake provider to >= 1.0.0
- *(release)* Version 2.0.0 [skip ci]
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
