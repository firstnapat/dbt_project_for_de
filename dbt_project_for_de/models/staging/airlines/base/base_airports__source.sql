WITH
source_table AS (
    SELECT
        airport_code,
        airport_name,
        city,
        coordinates,
        timezone
    FROM
        {{ source('ieie', 'airports_data') }}
)

SELECT * FROM source_table
