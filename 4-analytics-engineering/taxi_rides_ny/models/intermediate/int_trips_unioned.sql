with green_trips_data as (
select * from {{ ref('stg_greentrip_data')}}
),
yellow_trips_data as (
select * from {{ ref('stg_yellowtrip_data')}}
),
trips_unioned as    (
select *,{{dbt_utils.generate_surrogate_key(['vendor_id','pickup_datetime','pickup_location_id','trip_type'])}} as surr_key from green_trips_data    
union all
select *,{{dbt_utils.generate_surrogate_key(['vendor_id','pickup_datetime','pickup_location_id','trip_type'])}} as surr_key from yellow_trips_data
)
select * from trips_unioned