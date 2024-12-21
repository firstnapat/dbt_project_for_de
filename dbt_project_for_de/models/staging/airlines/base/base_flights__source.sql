WITH
source_table AS (
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
        {{ source('ieie', 'flights') }}
)

SELECT * FROM source_table
