{% macro default__generate_base_model(source_name, table_name, leading_commas, case_sensitive_cols, materialized) %}

{%- set source_relation = source(source_name, table_name) -%}

{%- set columns = adapter.get_columns_in_relation(source_relation) -%}
{% set column_names = columns | map(attribute='name') %}
{% set base_model_sql %}

{%- if materialized is not none -%}
    {{ "{{ config(materialized='" ~ materialized ~ "') }}" }}
{%- endif %}

with source as (

    select * from {% raw %}{{ source({% endraw %}'{{ source_name }}', '{{ table_name }}'{% raw %}) }}{% endraw %}

),

renamed as (

    select
        {%- if leading_commas -%}
        {%- for column in column_names %}
        {{ ", " if not loop.first }}
        {% if target.type == "bigquery" %}
            `{{ column }}`
        {% elif not case_sensitive_cols %}
            {{ column | lower }}
        {% else %}
            "{{ column }}"
        {% endif %}
        {%- endfor %}
        {%- else -%}
        {%- for column in column_names %}
        {% if target.type == "bigquery" %}
            `{{ column }}`
        {% elif not case_sensitive_cols %}
            {{ column | lower }}
        {% else %}
            "{{ column }}"
        {% endif %}
        {{ "," if not loop.last }}
        {%- endfor %}
        {%- endif %}

    from source

)

select * from renamed
{% endset %}

{% if execute %}

{{ print(base_model_sql) }}
{% do return(base_model_sql) %}

{% endif %}
{% endmacro %}
