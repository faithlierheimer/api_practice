with source as (
    select * from {{ ref('stg_zillow_locations') }}
),
renamed as (
    select
       region_id,
        size_rank,
        region_name,
         region_type,
        state_name,
        `2018-03-31` as m_2018_03,
        `2018-04-30` as m_2018_04,
        `2018-05-31` as m_2018_05,
        `2018-06-30` as m_2018_06,
        `2018-07-31` as m_2018_07,
        `2018-08-31` as m_2018_08,
        `2018-09-30` as m_2018_09,
        `2018-10-31` as m_2018_10,
        `2018-11-30` as m_2018_11,
        `2018-12-31` as m_2018_12,
        `2019-01-31` as m_2019_01,
        `2019-02-28` as m_2019_02,
        `2019-03-31` as m_2019_03,
        `2019-04-30` as m_2019_04,
        `2019-05-31` as m_2019_05,
        `2019-06-30` as m_2019_06,
        `2019-07-31` as m_2019_07,
        `2019-08-31` as m_2019_08,
        `2019-09-30` as m_2019_09,
        `2019-10-31` as m_2019_10,
        `2019-11-30` as m_2019_11,
        `2019-12-31` as m_2019_12,
        `2020-01-31` as m_2020_01,
        `2020-02-29` as m_2020_02,
        `2020-03-31` as m_2020_03,
        `2020-04-30` as m_2020_04,
        `2020-05-31` as m_2020_05,
        `2020-06-30` as m_2020_06,
        `2020-07-31` as m_2020_07,
        `2020-08-31` as m_2020_08,
        `2020-09-30` as m_2020_09,
        `2020-10-31` as m_2020_10,
        `2020-11-30` as m_2020_11,
        `2020-12-31` as m_2020_12,
        `2021-01-31` as m_2021_01,
        `2021-02-28` as m_2021_02,
        `2021-03-31` as m_2021_03,
        `2021-04-30` as m_2021_04,
        `2021-05-31` as m_2021_05,
        `2021-06-30` as m_2021_06,
        `2021-07-31` as m_2021_07,
        `2021-08-31` as m_2021_08,
        `2021-09-30` as m_2021_09,
        `2021-10-31` as m_2021_10,
        `2021-11-30` as m_2021_11,
        `2021-12-31` as m_2021_12,
        `2022-01-31` as m_2022_01,
        `2022-02-28` as m_2022_02,
        `2022-03-31` as m_2022_03,
        `2022-04-30` as m_2022_04,
        `2022-05-31` as m_2022_05,
        `2022-06-30` as m_2022_06,
        `2022-07-31` as m_2022_07,
        `2022-08-31` as m_2022_08,
        `2022-09-30` as m_2022_09,
        `2022-10-31` as m_2022_10,
        `2022-11-30` as m_2022_11,
        `2022-12-31` as m_2022_12,
        `2023-01-31` as m_2023_01,
        `2023-02-28` as m_2023_02,
        `2023-03-31` as m_2023_03,
        `2023-04-30` as m_2023_04,
        `2023-05-31` as m_2023_05,
        `2023-06-30` as m_2023_06,
        `2023-07-31` as m_2023_07,
        `2023-08-31` as m_2023_08,
        `2023-09-30` as m_2023_09,
        `2023-10-31` as m_2023_10,
        `2023-11-30` as m_2023_11,
        `2023-12-31` as m_2023_12,
        `2024-01-31` as m_2024_01,
        `2024-02-29` as m_2024_02,
        `2024-03-31` as m_2024_03,
        `2024-04-30` as m_2024_04,
        `2024-05-31` as m_2024_05,
        `2024-06-30` as m_2024_06,
        `2024-07-31` as m_2024_07,
        `2024-08-31` as m_2024_08,
        `2024-09-30` as m_2024_09,
        `2024-10-31` as m_2024_10
    from source
),
unpivoted as (
    select region_id, size_rank, region_name, region_type, state_name, "2018-03" as month, m_2018_03 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2018-04" as month, m_2018_04 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2018-05" as month, m_2018_05 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2018-06" as month, m_2018_06 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2018-07" as month, m_2018_07 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2018-08" as month, m_2018_08 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2018-09" as month, m_2018_09 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2018-10" as month, m_2018_10 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2018-11" as month, m_2018_11 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2018-12" as month, m_2018_12 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2019-01" as month, m_2019_01 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2019-02" as month, m_2019_02 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2019-03" as month, m_2019_03 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2019-04" as month, m_2019_04 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2019-05" as month, m_2019_05 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2019-06" as month, m_2019_06 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2019-07" as month, m_2019_07 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2019-08" as month, m_2019_08 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2019-09" as month, m_2019_09 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2019-10" as month, m_2019_10 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2019-11" as month, m_2019_11 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2019-12" as month, m_2019_12 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2020-01" as month, m_2020_01 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2020-02" as month, m_2020_02 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2020-03" as month, m_2020_03 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2020-04" as month, m_2020_04 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2020-05" as month, m_2020_05 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2020-06" as month, m_2020_06 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2020-07" as month, m_2020_07 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2020-08" as month, m_2020_08 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2020-09" as month, m_2020_09 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2020-10" as month, m_2020_10 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2020-11" as month, m_2020_11 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2020-12" as month, m_2020_12 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2021-01" as month, m_2021_01 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2021-02" as month, m_2021_02 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2021-03" as month, m_2021_03 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2021-04" as month, m_2021_04 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2021-05" as month, m_2021_05 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2021-06" as month, m_2021_06 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2021-07" as month, m_2021_07 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2021-08" as month, m_2021_08 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2021-09" as month, m_2021_09 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2021-10" as month, m_2021_10 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2021-11" as month, m_2021_11 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2021-12" as month, m_2021_12 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2022-01" as month, m_2022_01 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2022-02" as month, m_2022_02 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2022-03" as month, m_2022_03 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2022-04" as month, m_2022_04 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2022-05" as month, m_2022_05 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2022-06" as month, m_2022_06 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2022-07" as month, m_2022_07 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2022-08" as month, m_2022_08 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2022-09" as month, m_2022_09 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2022-10" as month, m_2022_10 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2022-11" as month, m_2022_11 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2022-12" as month, m_2022_12 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2023-01" as month, m_2023_01 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2023-02" as month, m_2023_02 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2023-03" as month, m_2023_03 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2023-04" as month, m_2023_04 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2023-05" as month, m_2023_05 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2023-06" as month, m_2023_06 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2023-07" as month, m_2023_07 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2023-08" as month, m_2023_08 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2023-09" as month, m_2023_09 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2023-10" as month, m_2023_10 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2023-11" as month, m_2023_11 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2023-12" as month, m_2023_12 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2024-01" as month, m_2024_01 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2024-02" as month, m_2024_02 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2024-03" as month, m_2024_03 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2024-04" as month, m_2024_04 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2024-05" as month, m_2024_05 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2024-06" as month, m_2024_06 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2024-07" as month, m_2024_07 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2024-08" as month, m_2024_08 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2024-09" as month, m_2024_09 as value from renamed union all
    select region_id, size_rank, region_name, region_type, state_name, "2024-10" as month, m_2024_10 as value from renamed
)

select * from unpivoted