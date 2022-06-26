
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
        order_status
    from {{ ref('fact_orders') }}
)

, user_data as (
    select 
        user_id,
        first_name,
        last_name,
        email,
        phone_number,
        created_at,
        updated_at,
        address_id
    from {{ ref('dim_users') }}
)
select o.order_id,
        o.promo_id,
        o.address_id,
        o.created_at as order_created_at,
        o.order_cost,
        o.shipping_cost,
        o.order_total,
        o.tracking_id,
        o.shipping_service,
        o.estimated_delivery_at,
        o.delivered_at,
        o.order_status,
        o.user_id,
        u.first_name,
        u.last_name,
        u.email,
        u.phone_number
from order_data o
left join user_data u on o.user_id = u.user_id

