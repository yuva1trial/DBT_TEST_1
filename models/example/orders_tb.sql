
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

with source_data as (

select * from {{ source('ecommerce_db', 'ORDERS') }}
-- WHERE ORDER_DATE >= CURRENT_DATE -- or use a variable/date window
--   AND (STATUS IS NULL OR ORDER_ID IS NULL)

)

select *
from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
