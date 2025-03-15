{{ dbt_utils.union_relations(
    relations=[ref('stg_streaming_2012_2019'), ref('stg_streaming_2019_2020'),ref('stg_streaming_2020_2022'),ref('stg_streaming_2022_2024')]
) }}