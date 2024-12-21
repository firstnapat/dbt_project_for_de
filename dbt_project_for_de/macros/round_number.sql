{% macro round_number(value, digit=2) %}
    (
        ROUND ({{ value }}, {{digit}})
    )
{% endmacro %}