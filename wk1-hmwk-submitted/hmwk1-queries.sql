-- Q3: How many taxi trips were there on Jaunaru 15?
select count(*) from yellow_taxi_data where date(tpep_pickup_datetime) = '2021-01-15';


-- Q4: Find the largest tip for each day.  Which day was the largest tip in January?
select date(tpep_pickup_datetime), max(tip_amount) as tip
  from yellow_taxi_data
 group by date(tpep_pickup_datetime)
 order by tip desc;
 
-- Q5: What was the most popular destination for passengers picked up in Central Park on January 14th?
select zdo."Zone", 
       count(1) as num_dropoffs
  from yellow_taxi_data y
  left join zones zpu on y."PULocationID" = zpu."LocationID"
  left join zones zdo on y."DOLocationID" = zdo."LocationID"
 where date(tpep_pickup_datetime) = '2021-01-14'
   and y."PULocationID" = 43
  group by zdo."Zone"
  order by num_dropoffs desc;

-- Q6: What is the pickup-dropoff pair with the largest avergate price for a ride (calculated based
--     on total_amount)?
select concat(zpu."Zone", ' / ', zdo."Zone") as "pickup_dropoff",
       avg("total_amount") as "avg_ride_price"
  from yellow_taxi_data y
  left join zones zpu on y."PULocationID" = zpu."LocationID"
  left join zones zdo on y."DOLocationID" = zdo."LocationID"
  group by "pickup_dropoff"
  order by "avg_ride_price" desc;
