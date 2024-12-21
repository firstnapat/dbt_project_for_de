WITH
flights_base AS (
    SELECT
        flight_id,
        flight_no,
        scheduled_departure,
        scheduled_arrival,
        departure_airport,
        arrival_airport,
        status,
        aircraft_code,
        actual_departure,
        actual_arrival
    FROM
        {{ ref('base_flights__source') }}
),

convert_timestamp_to_date AS (
    SELECT
        flight_id,
        flight_no,
        scheduled_departure,
        scheduled_arrival,
        departure_airport,
        arrival_airport,
        status,
        aircraft_code,
        actual_departure,
        actual_arrival,
        DATE(scheduled_departure) AS scheduled_departure_date,
        DATE(scheduled_arrival) AS scheduled_arrival_date,
        DATE(actual_departure) AS actual_departure_date,
        DATE(actual_arrival) AS actual_arrival_date
    FROM
        flights_base
)

SELECT * FROM convert_timestamp_to_date