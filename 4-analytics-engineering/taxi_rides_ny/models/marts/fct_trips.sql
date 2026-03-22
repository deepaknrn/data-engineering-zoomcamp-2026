/* 
  To Do:
  - One row per trip (doesn't matter if yellow or green)
  - Add a primary key (trip_id) to the table.It has to be unique
  - Find all the duplicates ,understand why they happen and fix them
  - Find a way to enrich the column payment type 
*/

select * from {{ref('int_trips_unioned')}}