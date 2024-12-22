WITH
top_aircrafts AS (
  SELECT
    aircraft_code,
    model,
    range
  FROM {{ ref('base_aircrafts__source') }}
  ORDER BY range
  LIMIT 10
)

SELECT * FROM top_aircrafts