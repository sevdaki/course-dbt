{{ config(materialized='table') }}

with order_data as (
    select
        order_id,
        user_id,
        promo_id,
        address_id,
        created_at,
        order_cost,
        shipping_cost,
        order_total,
        tracking_id,
        shipping_service,
        estimated_delivery_at,
        delivered_at,
        status
    from {{ source('tutorial', 'orders') }}
)

select *
from order_data

where order_id is not null
