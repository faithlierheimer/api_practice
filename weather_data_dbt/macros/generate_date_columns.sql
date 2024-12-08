{% macro generate_date_columns() %}
    {% set start_year = 2018 %}
    {% set start_month = 3 %}
    {% set end_year = 2024 %}
    {% set end_month = 10 %}

    {% set start_date = start_year * 12 + start_month - 1 %}
    {% set end_date = end_year * 12 + end_month - 1 %}

    {% set date_columns = [] %}

    {% for date in range(start_date, end_date + 1) %}
        {% set year = (date // 12) %}
        {% set month = (date % 12) + 1 %}
        {% set month_str = year ~ '-' ~ ('%02d' % month) %}
        
        {% set last_day_of_month = "LAST_DAY(DATE('" ~ year ~ '-' ~ ('%02d' % month) ~ "-01'))" %}
        
        {% set column_name = 'm_' ~ month_str | replace('-', '_') %}

        -- Construct the SQL expression with actual last day of the month
        {% set column_expr = last_day_of_month ~ " AS " ~ column_name %}
        {% do date_columns.append(column_expr) %}
    {% endfor %}

    {{ return(date_columns) }}
{% endmacro %}
