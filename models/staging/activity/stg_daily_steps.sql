select
    step_date
    , data_source
    , steps
    , calories
    , distance_m
    , round(distance_m * 0.0006213712, 2) as distance_mi
    , active_time_s
    , active_time_s / 60 as active_time_min
from
    {{ source('activity', 'daily_steps')}}