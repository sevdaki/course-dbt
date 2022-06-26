{{ config(materialized='table') }}

with promo_data as (
    select
        promo_id,
        discount,
        status
    from {{ source('tutorial', 'promos') }}
)

select *
from promo_data

where promo_id is not null
