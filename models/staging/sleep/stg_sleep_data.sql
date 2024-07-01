select
    start_time as sleep_start_datetime
    , start_time::DATE as sleep_start_date
    , start_time::TIME as sleep_start_time
    , end_time as end_sleep_datetime
    , end_time::DATE as end_sleep_date
    , end_time::TIME as end_sleep_time
    , ROUND(RTRIM(sleep_quality, '%') / 100, 2) as sleep_quality
    , ROUND(RTRIM(regularity, '%') / 100, 2) as sleep_regularity
    , mood as wake_up_mood
    , steps
    , alarm_mode
    , air_pressure
    , city
    , movements_per_hour
    , time_in_bed_s
    , ROUND(time_in_bed_s / 60, 2) as time_in_bed_min
    , ROUND(time_in_bed_s / 3600, 2) as time_in_bed_hr
    , time_asleep_s
    , ROUND(time_asleep_s / 60, 2) as time_asleep_min
    , ROUND(time_asleep_s / 3600, 2) as time_asleep_hr
    , time_before_sleep_s
    , ROUND(time_before_sleep_s / 60, 2) as time_before_sleep_min
    , ROUND(time_before_sleep_s / 3600, 2) as time_before_sleep_hr
    , wake_window_start as wakeup_start_datetime
    , wake_window_start::DATE as wakeup_start_date
    , wake_window_start::TIME as wakeup_start_time
    , wake_window_end as wakeup_end_datetime
    , wake_window_end::DATE as wakeup_end_date
    , wake_window_end::TIME as wakeup_end_time
    , snore as did_snore
    , snore_time as snore_time_s
    , ROUND(snore_time / 60, 2) as snore_time_min
    , weather_temp
    , weather
from
    {{ source('sleep', 'sleep_data') }}