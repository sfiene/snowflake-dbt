/* Creating the schemas */

create or replace schema raw.detailed_steps;
create or replace schema raw.daily_steps;
create or replace schema raw.activity_sessions;
create or replace schema raw.sleep_data;
create or replace schema raw.step_activity;

/* Used the following command to load files from local folder using SnowSQL
PUT file://C:\xxxxx\xxxxx\Downloads\sleepdata.csv @load_from_local; */

/* List the files that were loaded into the stage */
list @raw.public.load_from_local;

/* Create the detailed_steps table, load data, and verify it is correct */

create or replace table raw.step_activity.detailed_steps 
( start_time TIMESTAMP,
  end_time TIMESTAMP,
  data_source VARCHAR(100),
  steps NUMBER(10,0),
  calories DECIMAL(10,2),
  distance_m NUMBER(10,0),
  active_time_s NUMBER(10,0)
);

copy into raw.step_activity.detailed_steps ( start_time, end_time, data_source, steps, calories, distance_m, active_time_s )
from @RAW.PUBLIC.LOAD_FROM_LOCAL/DetailedSteps.csv
file_format = (
    type = 'CSV'
    field_delimiter = ','
    skip_header = 1
    ); 

select * from raw.step_activity.detailed_steps;

/* end loading data into detailed_steps table */
/* Create the daily_steps table, load data, and verify it is correct */ 

create table raw.step_activity.daily_steps 
( step_date DATE,
  data_source VARCHAR(100),
  steps NUMBER(10,0),
  calories DECIMAL(10,2),
  distance_m NUMBER(10,0),
  active_time_s NUMBER(10,0)
);

copy into raw.step_activity.daily_steps ( step_date, data_source, steps, calories, distance_m, active_time_s )
from @RAW.PUBLIC.LOAD_FROM_LOCAL/DailySteps.csv
file_format = (
    type = 'CSV'
    field_delimiter = ','
    skip_header = 1
    ); 

select * from raw.step_activity.daily_steps;

/* end loading data into daily_steps table */
/* Create the activity_sessions table, load data, and verify it is correct */ 

create or replace table raw.step_activity.activity_sessions
( start_time TIMESTAMP,
  end_time TIMESTAMP,
  data_source VARCHAR(100),
  activity_type VARCHAR(100),
  steps NUMBER(10,0),
  calories DECIMAL(10,2),
  duration_s NUMBER(10,0),
  distance_m NUMBER(10,0),
  comments VARCHAR(100)
);

/* this data has activity_type column that contains data with additional commas, so I used the field_optionally_enclosed_by to properly parse the file */

copy into raw.step_activity.activity_sessions ( start_time, end_time, data_source, activity_type, steps, calories, duration_s, distance_m, comments )
from @RAW.PUBLIC.LOAD_FROM_LOCAL/ActivitySessions.csv
file_format = (
    type = 'CSV'
    field_optionally_enclosed_by = '"'
    field_delimiter = ','
    skip_header = 1
    ); 

select * from raw.step_activity.activity_sessions;

/* end loading data into activity_sessions table */
/* Create the sleep_data table, load data, and verify it is correct */ 

create or replace table raw.sleep_data.sleep_data 
( start_time TIMESTAMP,
  end_time TIMESTAMP,
  sleep_quality VARCHAR(10),
  regularity VARCHAR(10),
  mood VARCHAR(10),
  heart_rate NUMBER(10,0),
  steps NUMBER(10,0),
  alarm_mode VARCHAR(20),
  air_pressure DECIMAL(10,2),
  city VARCHAR(20),
  movements_per_hour DECIMAL(10,2),
  time_in_bed_s DECIMAL(10,2),
  time_asleep_s DECIMAL(10,2),
  time_before_sleep_s DECIMAL(10,2),
  wake_window_start TIMESTAMP,
  wake_window_end TIMESTAMP,
  snore BOOLEAN,
  snore_time DECIMAL(10,2),
  weather_temp DECIMAL(10,2),
  weather VARCHAR(50),
  sleep_notes VARCHAR(255)
);

copy into raw.sleep_data.sleep_data ( start_time, end_time, sleep_quality, regularity, mood, heart_rate, steps, alarm_mode, air_pressure, city, movements_per_hour, time_in_bed_s, time_asleep_s, time_before_sleep_s, wake_window_start, wake_window_end, snore, snore_time, weather_temp, weather, sleep_notes )
from @RAW.PUBLIC.LOAD_FROM_LOCAL/sleepdata.csv
file_format = (
    type = 'CSV'
    field_delimiter = ';'
    skip_header = 1
    ); 

select * from raw.sleep_data.sleep_data;
