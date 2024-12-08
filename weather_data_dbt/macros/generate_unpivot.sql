{% macro generate_unpivot(start_year, start_month, end_year, end_month) %}
    {% set months = generate_month_range(start_year, start_month, end_year, end_month) %}
    {% set sql_lines = [] %}

    {% for month in months %}
        {% set column_name = 'm_' ~ month | replace('-', '_') %}
        {% do sql_lines.append(
            "select region_id, size_rank, region_name, region_type, state_name, '" ~ month ~ "' as month, " ~ column_name ~ " as value from renamed"
        ) %}
    {% endfor %}

    {{ return(sql_lines | join(" union all\n")) }}
{% endmacro %}
