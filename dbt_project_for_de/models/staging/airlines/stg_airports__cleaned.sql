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
)

SELECT * FROM airport_base
