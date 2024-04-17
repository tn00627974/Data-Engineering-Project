-- 找出每個 VendorID 的平均行程距離（trip_distance）是多少？

SELECT ft.VendorID, AVG(td.trip_distance) AS avg_trip_distance
FROM `abiding-ascent-408115.uberdataset.fact_table` AS ft
JOIN `abiding-ascent-408115.uberdataset.trip_distance_dim` AS td
ON ft.VendorID = td.trip_distance_id
GROUP BY ft.VendorID;

-- 計算每個 VendorID 的總收入（total_amount）是多少？

SELECT vendorID,SUM(total_amount)as `總額` FROM `abiding-ascent-408115.uberdataset.fact_table` 
GROUP BY vendorID ;

-- 哪個時間段（datetime_id）的平均行程費用（total_amount）最高？列出平均行程費用最高的五個時間段。

SELECT dd.tpep_pickup_datetime, dd.tpep_dropoff_datetime, AVG(ft.total_amount) AS avg_total_amount
FROM `abiding-ascent-408115.uberdataset.fact_table` AS ft
JOIN `abiding-ascent-408115.uberdataset.datetime_dim` AS dd
ON ft.datetime_id = dd.datetime_id 
GROUP BY dd.tpep_pickup_datetime, dd.tpep_dropoff_datetime
ORDER BY avg_total_amount DESC;

-- 哪個付款方式（payment_type）最常被使用？列出使用次數最多的三種付款方式。
        1:"Credit card",
        2:"Cash",
        3:"No charge",
        4:"Dispute",
        5:"Unknown",

SELECT ptd.payment_type_name ,COUNT(*) AS COUNT FROM `abiding-ascent-408115.uberdataset.fact_table`as ft
JOIN `abiding-ascent-408115.uberdataset.payment_type_dim`as ptd
on ptd.payment_type_id = ft.payment_type_id 
GROUP BY ptd.payment_type_name
ORDER BY COUNT DESC   
limit 3 ;
