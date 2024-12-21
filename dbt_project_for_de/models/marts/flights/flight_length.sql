WITH calculated_distances AS (
   SELECT
    flight_id,
    from_city,
    to_city,
    2 * 6371 * ASIN(SQRT(
        POWER(SIN(RADIANS((CAST(to_latitude AS DOUBLE PRECISION) - CAST(from_latitude AS DOUBLE PRECISION)) / 2)), 2) +
        COS(RADIANS(CAST(from_latitude AS DOUBLE PRECISION))) * COS(RADIANS(CAST(to_latitude AS DOUBLE PRECISION))) *
        POWER(SIN(RADIANS((CAST(to_longitude AS DOUBLE PRECISION) - CAST(from_longitude AS DOUBLE PRECISION)) / 2)), 2)
    )) AS distance_km
    FROM {{ ref('int_flights__joined_with_airports') }}
),
average_distances AS (
    SELECT
        from_city,
        to_city,
        AVG(distance_km) AS average_distance_km
    FROM calculated_distances
    GROUP BY from_city, to_city
)
SELECT *
FROM average_distances
ORDER BY average_distance_km DESC
