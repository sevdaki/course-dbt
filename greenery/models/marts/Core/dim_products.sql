{{ config(materialized='table') }}

with product_data as (
    select
        product_id,
        name,
        price
    from {{ ref('stg_products') }}
)

select *
from product_data