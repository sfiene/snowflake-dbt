select 
    start_time as activity_start_datetime
    , start_time::DATE as activity_start_date
    , start_time::TIME as activity_start_time
    , end_time as activity_end_datetime
    , end_time::DATE as activity_end_date
    , end_time::TIME as activity_end_time
    , data_source
    , activity_type
    , steps
    , calories
    , duration_s
    , round(duration_s / 60, 2) as duration_min
    , distance_m
    , round(distance_m * 0.0006213712, 2) as distance_mi
from
    {{ source('activity', 'activity_sessions') }}