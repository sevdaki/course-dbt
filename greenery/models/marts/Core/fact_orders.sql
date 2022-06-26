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
    from {{ ref('stg_orders') }}
)

, promos as (
   select
        promo_id,
        discount,
        status
    from {{ ref('stg_promos') }}
)

select 
        o.order_id,
        o.user_id,
        o.promo_id,
        p.discount,
        p.discount / o.order_cost as discount_percentage,
        p.status as promo_status,
        o.address_id,
        o.created_at,
        o.order_cost,
        o.shipping_cost,
        o.order_total,
        o.tracking_id,
        o.shipping_service,
        o.estimated_delivery_at,
        o.delivered_at,
        o.status as order_status
from order_data o
left join promos p ON o.promo_id = p.promo_id

