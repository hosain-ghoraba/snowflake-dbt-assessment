SELECT
    stg_orders.o_custkey,
    stg_orders.customer_name,
    SUM(l.l_extendedprice * (1 - l.l_discount)) AS total_revenue
FROM {{ ref('stg_orders') }} stg_orders
JOIN {{ source('tpch', 'lineitem') }} l
  ON stg_orders.o_orderkey = l.l_orderkey
GROUP BY stg_orders.o_custkey, stg_orders.customer_name
