## 📋 Project Overview

This project transforms [TPC-H sample data from Snowflake](https://docs.snowflake.com/en/user-guide/sample-data-tpch)
into business-ready analytics models:

- **`stg_orders`**: Staging layer for orders with customer enrichment
- **`customer_revenue`**: Aggregated customer revenue calculations
- **`nation_order_summary`**: Nation-level order and customer metrics

## 🚀 Quick Start

### Prerequisites

- Python 3
- Snowflake account with access to `SNOWFLAKE_SAMPLE_DATA.TPCH_SF1`

### Installation

1. **Clone the repository**

2. **Install dbt**

   ```bash
   pip install dbt-snowflake
   ```

   Note : You may want to run the above command in a python virtual environment to avoid installing the package system-wide

3. **Create environment file**

   Create a `.env` file in the project root with your Snowflake credentials:

   ```bash
   SNOWFLAKE_ACCOUNT=your-account.snowflakecomputing.com
   SNOWFLAKE_USER=your-username
   SNOWFLAKE_PASSWORD=your-password
   SNOWFLAKE_ROLE=desired-role
   SNOWFLAKE_WAREHOUSE=your-WH
   SNOWFLAKE_DATABASE=your-DB
   SNOWFLAKE_SCHEMA=TPCH_SF1
   ```

### Running the Project

1. **Load environment variables into bash**

   Linux/macOS

   ```bash
   export $(cat .env | xargs)
   ```

   Windows PowerShell

   ```bash
   Get-Content .env | ForEach-Object { Set-Item -Path Env:\$_ -Value $($_.Split('=')[1]) }
   ```

2. **Test your connection**

   ```bash
   dbt debug
   ```

3. **Run the complete project (models + tests)**

   ```bash
   dbt build
   ```

4. **Generate documentation**
   ```bash
   dbt docs generate
   dbt docs serve
   ```

## 📊 Models

### Staging (silver) Models

#### `stg_orders`

- **Purpose**: Enriches raw orders with customer names and extract order year
- **Key Columns**:
  - `o_orderkey`: Unique order identifier
  - `customer_name`: Customer name from master data
  - `order_year`: Year in which the order happened.
- **Tests**: Not null, unique constraints, referential integrity

### Mart (golden) Models

#### `customer_revenue`

- **Purpose**: Aggregated customer revenue with discount calculations
- **Business Logic**: `SUM(extended_price * (1 - discount))`
- **Key Columns**:
  - `total_revenue`: Total revenue per customer
  - `customer_name`: Customer name
- **Tests**: Not null, unique, referential integrity

#### `nation_order_summary`

- **Purpose**: Nation-level metrics for geographic analysis
- **Key Columns**:
  - `nation_name`: Nation identifier
  - `num_customers`: Distinct customer count per nation (only customers with at least one order)
  - `num_orders`: Total orders per nation
- **Tests**: Not null constraints

## 🎯 Exposures

The project defines downstream consumption:

- **Customer Revenue Dashboard**: Revenue metrics visualization
- **Nation Performance Report**: Geographic analysis reports
