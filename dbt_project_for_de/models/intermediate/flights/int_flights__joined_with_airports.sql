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
        city
        coordinates
    FROM {{ ref('stg_airports__cleaned') }}
),

joined_flights AS (
    SELECT 
        fl.flight_id, 
        fl.departure_airport,
        fl.arrival_airport,
        f.city AS from_city,
        f.coordinates AS from_coordinates,
        t.city AS to_city,
        t.coordinates AS to_coordinates
    FROM flights_cte AS fl
    LEFT JOIN airports_cte AS f
        ON fl.departure_airport = f.airport_code
    LEFT JOIN airports_cte AS t
        ON fl.arrival_airport = t.airport_code    
),

json_extract AS (
    SELECT 
        flight_id, 
        CAST(from_city, string)::jsonb ->> 'en') AS from_city,
        
    FROM joined_flights
)

SELECT * FROM json_extract