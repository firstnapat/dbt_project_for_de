WITH
source_table AS (
    SELECT
        aircraft_code,
        model,
        range
    FROM
        {{ source('ieie', 'aircrafts_data') }}
)

SELECT * FROM source_table
