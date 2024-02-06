-- Script:
create table hospital (
  emp_id int, 
  action varchar(10), 
  time datetime
);

insert into hospital values ('1', 'in', '2019-12-22 09:00:00');
insert into hospital values ('1', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:00:00');
insert into hospital values ('2', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:30:00');
insert into hospital values ('3', 'out', '2019-12-22 09:00:00');
insert into hospital values ('3', 'in', '2019-12-22 09:15:00');
insert into hospital values ('3', 'out', '2019-12-22 09:30:00');
insert into hospital values ('3', 'in', '2019-12-22 09:45:00');
insert into hospital values ('4', 'in', '2019-12-22 09:45:00');
insert into hospital values ('5', 'out', '2019-12-22 09:40:00');

SELECT * FROM hospital;

-- Question: Write a sql to find the total number of people present inside the hospital

-- Method 1: Having
WITH cte AS (
  SELECT 
    emp_id, 
    MAX(CASE WHEN action = 'in' THEN time END) AS intime, 
    MAX(CASE WHEN action = 'out' THEN time END) AS outtime 
  FROM 
    hospital 
  GROUP BY 
    emp_id
) 
SELECT 
  COUNT(emp_id) AS No_of_people_presents
FROM 
  cte 
WHERE 
  intime > outtime 
  OR outtime IS NULL;

-- Method 2: Joins
WITH intime AS(
  SELECT 
    emp_id, 
    MAX(time) AS latest_in_time 
  FROM 
    hospital 
  WHERE 
    action = 'in' 
  GROUP BY 
    emp_id
), 
outtime AS (
  SELECT 
    emp_id, 
    MAX(time) AS latest_out_time 
  FROM 
    hospital 
  WHERE 
    action = 'out' 
  GROUP BY 
    emp_id
) 
SELECT 
  COUNT(1) 
FROM 
  intime 
  LEFT JOIN outtime ON intime.emp_id = outtime.emp_id 
WHERE 
  latest_in_time > latest_out_time 
  OR latest_out_time IS NULL;

-- Method 3: 
WITH latest_time AS (
  SELECT 
    emp_id, 
    MAX(time) AS max_latest_time 
  FROM 
    hospital 
  GROUP BY 
    emp_id
), 
latest_in_time AS (
  SELECT 
    emp_id, 
    MAX(time) AS max_latest_in_time 
  FROM 
    hospital 
  WHERE 
    action = 'in' 
  GROUP BY 
    emp_id
) 
SELECT 
  COUNT(1)
FROM 
  latest_time lt 
  INNER JOIN latest_in_time lit ON lt.emp_id = lit.emp_id 
  AND max_latest_time = max_latest_in_time;
