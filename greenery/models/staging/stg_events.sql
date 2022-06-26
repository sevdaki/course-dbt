{{ config(materialized='table') }}

with events_data as (
    select
        event_id,
        session_id,
        user_id,
        page_url,
        created_at,
        event_type,
        order_id,
        product_id
    from {{ source('tutorial', 'events') }}
)

select *
from events_data

where event_id is not null
