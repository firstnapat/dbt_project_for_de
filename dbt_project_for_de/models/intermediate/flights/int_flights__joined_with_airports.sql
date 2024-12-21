{{
  config(
    materialized = "view",
  )
}}

WITH
flights_cte AS (
    SELECT
        flight_id,
        departure_airport,
        arrival_airport
    FROM {{ ref('stg_flights__cleaned') }}
),
airports_cte AS (
    SELECT
        airport_code,
        city,
        coordinates,
        CAST(split_part(regexp_replace(coordinates, '[\(\)]', '', 'g'), ',', 1) AS numeric) AS latitude,
        CAST(split_part(regexp_replace(coordinates, '[\(\)]', '', 'g'), ',', 2) AS numeric) AS longitude
    FROM {{ ref('stg_airports__cleaned') }}
),

joined_flights AS (
    SELECT 
        fl.flight_id, 
        fl.departure_airport,
        fl.arrival_airport,
        f.city AS from_city,
        f.coordinates AS from_coordinates,
        {{ round_number('f.latitude') }} AS from_latitude,
        {{ round_number('f.longitude') }} AS from_longitude,
        t.city AS to_city,
        t.coordinates AS to_coordinates,
        {{ round_number('t.latitude') }} AS to_latitude,
        {{ round_number('t.longitude') }} AS to_longitude
    FROM flights_cte AS fl
    LEFT JOIN airports_cte AS f
        ON fl.departure_airport = f.airport_code
    LEFT JOIN airports_cte AS t
        ON fl.arrival_airport = t.airport_code    
),

json_extract AS (
    SELECT 
        *
    FROM joined_flights
)

SELECT * FROM joined_flights