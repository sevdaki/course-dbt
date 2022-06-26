{{ config(materialized='table') }}

with page_views as (
    select
        event_id,
        session_id,
        user_id,
        page_url,
        created_at,
        order_id,
        product_id
    from {{ ref('stg_events') }}
    where event_type = 'page_view'
)

select *
from page_views

