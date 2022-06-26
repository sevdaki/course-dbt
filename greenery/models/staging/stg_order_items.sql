{{ config(materialized='table') }}

with order_item_data as (
    select
        order_id,
        product_id,
        quantity
    from {{ source('tutorial', 'order_items') }}
)

select *
from order_item_data

where order_id is not null
