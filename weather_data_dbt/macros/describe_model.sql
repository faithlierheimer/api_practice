{% macro can_sum(field) %}
  {{return(field.dtype.lower() in ('integer', 'bigint', 'double precision', 'float', 'real', 'numeric', 'decimal'))}}
{% endmacro %}

{% macro can_percentile(field) %}
  {{return(field.dtype.lower() in ('integer', 'bigint', 'double precision', 'float', 'real', 'numeric', 'decimal', 'date', 'timestamp', 'timestamptz'))}}
{% endmacro %}

{% macro describe_model(model) %}
  {# Calculates descriptive statistics for each field in model. Model should be a
      ref() to a dbt model (views work fine) #}

  {%- if not execute -%}
      {{ return('') }}
  {% endif %}

  {%- if model.name -%}
      {%- set schema_name, table_name = model.schema, model.name -%}
  {%- else -%}
      {%- set schema_name, table_name = (model | string).split(".") -%}
  {%- endif -%}

  {%- set fields = adapter.get_columns_in_table(schema_name, table_name) -%}

  with stats as (

  {% for field in fields %}
    select
      '{{schema_name}}.{{table_name}}' as relation,
      '{{field.column}}' as field,
      '{{field.dtype}}' as dtype,
      count({{field.column}}) as count_all,
      {% if can_sum(field) -%}
        sum({{field.column}})::float
      {%- else -%}
      null::float
      {%- endif %} as sum_all,
      {% if can_sum(field) -%}
        avg({{field.column}})::float
      {%- else -%}
      null::float
      {%- endif %} as mean,
      {% if can_sum(field) -%}
        stddev({{field.column}})::float
      {%- else -%}
      null::float
      {%- endif %} as stddev,
      min({{field.column}})::varchar(100) as min,
      {% if can_percentile(field) -%}
        PERCENTILE_CONT ( 0.25 )
        WITHIN GROUP (ORDER BY {{field.column}})::varchar(100)
      {%- else -%}
      null::varchar(100)
      {%- endif %} as percentile_25,
      {% if can_percentile(field) -%}
        PERCENTILE_CONT ( 0.5 )
        WITHIN GROUP (ORDER BY {{field.column}})::varchar(100)
      {%- else -%}
      null::varchar(100)
      {%- endif %} as median,
      {% if can_percentile(field) -%}
        PERCENTILE_CONT ( 0.75 )
        WITHIN GROUP (ORDER BY {{field.column}})::varchar(100)
      {%- else -%}
      null::varchar(100)
      {%- endif %} as percentile_75,
      max({{field.column}})::varchar(100) as max

    from
      {{schema_name}}.{{table_name}}

    {% if not loop.last %}
    UNION ALL
    {% endif %}

  {% endfor %}

  ),

  distinct_counts as (
   -- {# REDSHIFT DOESN'T ALLOW COUNT DISTINCT AND PERCENTILE_CONT IN THE SAME QUERY #}
    {% for field in fields %}
      select
        '{{field.column}}' as field,
        count(distinct {{field.column}}) as count_distinct

      from
        {{schema_name}}.{{table_name}}

      {% if not loop.last %}
      UNION ALL
      {% endif %}

    {% endfor %}
  )

  select
    stats.*,
    distinct_counts.count_distinct

  from
    stats
    join distinct_counts on stats.field = distinct_counts.field

{% endmacro %}

