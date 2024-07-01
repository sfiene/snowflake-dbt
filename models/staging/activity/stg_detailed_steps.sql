select 
    start_time as start_datetime
    , start_time::DATE as start_date
    , start_time::TIME as start_time
    , end_time as end_datetime
    , end_time::DATE as end_date
    , end_time::TIME as end_time
    , data_source
    , steps
    , calories
    , distance_m
    , round(distance_m * 0.0006213712, 2) as distance_mi
    , active_time_s
    , active_time_s / 60 as active_time_min
from 
    {{ source('activity', 'detailed_steps') }}