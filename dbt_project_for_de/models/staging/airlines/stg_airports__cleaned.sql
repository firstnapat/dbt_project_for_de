WITH
airport_base AS (
    SELECT
        airport_code,
        airport_name,
        city,
        coordinates,
        timezone
    FROM
        {{ ref('base_airports__source') }}
),

convert_coordinates AS (
    SELECT
        airport_code,
        airport_name,
        city,
        coordinates,
        timezone
    FROM
        airport_base
)

SELECT * FROM convert_coordinates