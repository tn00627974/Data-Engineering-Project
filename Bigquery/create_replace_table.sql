--創建或替換表
CREATE OR REPLACE TABLE `abiding-ascent-408115.uberdataset.analytics` AS(
SELECT 
f.VendorID,
dt.tpep_pickup_datetime,
dt.tpep_dropoff_datetime,
pcd.passenger_count,
trip.trip_distance,
rate.rate_code_name,
pid.pickup_latitude,
pid.pickup_longitude,
dld.dropoff_latitude,
dld.dropoff_longitude,
pay.payment_type_name,
f.fare_amount,
f.extra,
f.mta_tax,
f.tip_amount,
f.tolls_amount,
f.improvement_surcharge,

FROM
`abiding-ascent-408115.uberdataset.fact_table` f
JOIN `abiding-ascent-408115.uberdataset.datetime_dim` dt ON dt.datetime_id = f.datetime_id
JOIN `abiding-ascent-408115.uberdataset.passenger_count_dim` pcd ON pcd.passenger_count_id = f.passenger_count_id
JOIN `abiding-ascent-408115.uberdataset.rate_code_dim` rate ON rate.rate_code_id = f.rate_code_id
JOIN `abiding-ascent-408115.uberdataset.payment_type_dim` pay ON pay.payment_type_id = f.payment_type_id
JOIN `abiding-ascent-408115.uberdataset.trip_distance_dim` trip ON trip.trip_distance_id = f.trip_distance_id
JOIN `abiding-ascent-408115.uberdataset.pickup_location_dim` pid ON pid.pickup_location_id = f.pickup_location_id
JOIN `abiding-ascent-408115.uberdataset.dropoff_location_dim` dld ON dld.dropoff_location_id = f.dropoff_location_id)












