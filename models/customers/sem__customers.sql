-- models/customers.sql

{{ config(
    materialized='incremental',
    unique_key='customer_id'

) }}

with new_data as (
    select
        customer_id,
        first_name,
        last_name,
        email,
        created_at,
        format_datetime(current_timestamp, 'yyyy-MM-dd HH:mm:ss') as run_date  -- İşlem tarihi
    from {{ ref('raw__customers') }}
    {% if is_incremental() %}
    where created_at > (select coalesce(max(created_at), timestamp '1970-01-01 00:00:00') from {{ this }})
    {% endif %}
)

select *
from new_data
