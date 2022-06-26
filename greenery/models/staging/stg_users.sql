{{ config(materialized='table') }}

with user_data as (
    select
        user_id,
        first_name,
        last_name,
        email,
        phone_number,
        created_at,
        updated_at,
        address_id
    from {{ source('tutorial', 'users') }}
)

select *
from user_data

where user_id is not null
