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
    from {{ ref('stg_users') }}
)
, address_data as (
    select 
        address_id,
        address,
        zipcode,
        state,
        country
    from {{ ref('stg_addresses') }}
)

select u.user_id,
        u.first_name,
        u.last_name,
        u.email,
        u.phone_number,
        u.address_id,
        a.address,
        a.zipcode,
        a.state,
        a.country,
        u.created_at,
        u.updated_at
from user_data u
left join address_data a ON u.address_id = a.address_id