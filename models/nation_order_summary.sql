select
    n.n_name as nation_name,
    count(distinct stg_orders.o_custkey) as num_customers,
    count(stg_orders.o_orderkey) as num_orders
from {{ ref('stg_orders') }} stg_orders
join {{ source('tpch', 'customer') }} c
    on stg_orders.o_custkey = c.c_custkey
join {{ source('tpch', 'nation') }} n
    on c.c_nationkey = n.n_nationkey
group by n.n_name
order by num_orders desc
