{% snapshot snapshot__customers %}

{{
    config(
      target_schema='default',
      unique_key='customer_id',

      strategy="check",
      check_cols=["email"]
    )
}}

select * from {{ ref('sem__customers') }}

{% endsnapshot %}