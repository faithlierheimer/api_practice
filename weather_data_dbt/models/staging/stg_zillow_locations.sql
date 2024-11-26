with source as (

    select * from {{ source('housing', 'zillow-for-sale-inventory') }}

),

renamed as (

    select

        `RegionID` as region_id

        ,

        `SizeRank` as size_rank

        ,

        `RegionName` as region_name

        ,

        `RegionType` as region_type

        ,

        `StateName` as state_name

        ,

        `2018-03-31`

        ,

        `2018-04-30`

        ,

        `2018-05-31`

        ,

        `2018-06-30`

        ,

        `2018-07-31`

        ,

        `2018-08-31`

        ,

        `2018-09-30`

        ,

        `2018-10-31`

        ,

        `2018-11-30`

        ,

        `2018-12-31`

        ,

        `2019-01-31`

        ,

        `2019-02-28`

        ,

        `2019-03-31`

        ,

        `2019-04-30`

        ,

        `2019-05-31`

        ,

        `2019-06-30`

        ,

        `2019-07-31`

        ,

        `2019-08-31`

        ,

        `2019-09-30`

        ,

        `2019-10-31`

        ,

        `2019-11-30`

        ,

        `2019-12-31`

        ,

        `2020-01-31`

        ,

        `2020-02-29`

        ,

        `2020-03-31`

        ,

        `2020-04-30`

        ,

        `2020-05-31`

        ,

        `2020-06-30`

        ,

        `2020-07-31`

        ,

        `2020-08-31`

        ,

        `2020-09-30`

        ,

        `2020-10-31`

        ,

        `2020-11-30`

        ,

        `2020-12-31`

        ,

        `2021-01-31`

        ,

        `2021-02-28`

        ,

        `2021-03-31`

        ,

        `2021-04-30`

        ,

        `2021-05-31`

        ,

        `2021-06-30`

        ,

        `2021-07-31`

        ,

        `2021-08-31`

        ,

        `2021-09-30`

        ,

        `2021-10-31`

        ,

        `2021-11-30`

        ,

        `2021-12-31`

        ,

        `2022-01-31`

        ,

        `2022-02-28`

        ,

        `2022-03-31`

        ,

        `2022-04-30`

        ,

        `2022-05-31`

        ,

        `2022-06-30`

        ,

        `2022-07-31`

        ,

        `2022-08-31`

        ,

        `2022-09-30`

        ,

        `2022-10-31`

        ,

        `2022-11-30`

        ,

        `2022-12-31`

        ,

        `2023-01-31`

        ,

        `2023-02-28`

        ,

        `2023-03-31`

        ,

        `2023-04-30`

        ,

        `2023-05-31`

        ,

        `2023-06-30`

        ,

        `2023-07-31`

        ,

        `2023-08-31`

        ,

        `2023-09-30`

        ,

        `2023-10-31`

        ,

        `2023-11-30`

        ,

        `2023-12-31`

        ,

        `2024-01-31`

        ,

        `2024-02-29`

        ,

        `2024-03-31`

        ,

        `2024-04-30`

        ,

        `2024-05-31`

        ,

        `2024-06-30`

        ,

        `2024-07-31`

        ,

        `2024-08-31`

        ,

        `2024-09-30`

        ,

        `2024-10-31`



    from source

)

select * from renamed
