{% macro generate_month_range(start_year, start_month, end_year, end_month) %}
    {% set start_date = start_year * 12 + start_month - 1 %}
    {% set end_date = end_year * 12 + end_month - 1 %}
    {% set months = [] %}

    {% for date in range(start_date, end_date + 1) %}
        {% set year = (date // 12) %}
        {% set month = (date % 12) + 1 %}
        {% set month_str = year ~ '-' ~ ('%02d' % month) %}
        {% do months.append(month_str) %}
    {% endfor %}

    {{ return(months) }}
{% endmacro %}
