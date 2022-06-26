{{ config(materialized='table') }}

with address_data as (
    select
        address_id,
        address,
        zipcode,
        state,
        country
    from {{ source('tutorial', 'addresses') }}
)

select *
from address_data

where address_id is not null
