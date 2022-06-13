{{ config(materialized='table') }}

with product_data as (
    select
        product_id,
        name,
        price,
        inventory
    from {{ source('tutorial', 'products') }}
)

select *
from product_data

where product_id is not null
