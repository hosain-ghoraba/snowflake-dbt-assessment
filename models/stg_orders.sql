select
    o.o_orderkey,
    o.o_custkey,
    c.c_name as customer_name,
    o.o_orderdate,
    extract(year from o.o_orderdate) as order_year,
    o.o_totalprice as total_price
from {{ source('tpch', 'orders') }} o
join {{ source('tpch', 'customer') }} c
    on o.o_custkey = c.c_custkey
