-- Script for Table Creation:
CREATE TABLE events (
    id INT,
    event VARCHAR(255),
    year INT,
    gold VARCHAR(255),
    silver VARCHAR(255),
    bronze VARCHAR(255)
);

-- Initial Table Delete
DELETE FROM events;

-- Insert Statements
INSERT INTO events VALUES (1,'100m',2016, 'Amthhew Mcgarray','donald','barbara');
INSERT INTO events VALUES (2,'200m',2016, 'Nichole','Alvaro Eaton','janet Smith');
INSERT INTO events VALUES (3,'500m',2016, 'Charles','Nichole','Susana');
INSERT INTO events VALUES (4,'100m',2016, 'Ronald','maria','paula');
INSERT INTO events VALUES (5,'200m',2016, 'Alfred','carol','Steven');
INSERT INTO events VALUES (6,'500m',2016, 'Nichole','Alfred','Brandon');
INSERT INTO events VALUES (7,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO events VALUES (8,'200m',2016, 'Thomas','Dawn','catherine');
INSERT INTO events VALUES (9,'500m',2016, 'Thomas','Dennis','paula');
INSERT INTO events VALUES (10,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO events VALUES (11,'200m',2016, 'jessica','Donald','Stefeney');
INSERT INTO events VALUES (12,'500m',2016,'Thomas','Steven','Catherine');

-- Question: Write a query to find no of gold medal per swimmer for swimmer who won only gold medals

-- Method 1 - Sub Query
SELECT 
  gold AS player_name, 
  COUNT(1) AS no_of_gold_medals 
FROM 
  events 
WHERE 
  gold NOT IN (
    SELECT silver 
    FROM events 
    UNION
    SELECT bronze 
    FROM events) 
GROUP BY 
  gold;
  
-- Method 2 - Having + CTE
WITH cte AS (
SELECT gold AS player_name, 'gold' AS medal_type FROM events
UNION ALL
SELECT silver, 'silver' AS medal_type FROM events
UNION ALL
SELECT bronze, 'bronze' AS medal_type FROM events)
SELECT player_name, COUNT(1) AS no_of_gold_medals
FROM cte
GROUP BY player_name
HAVING COUNT(DISTINCT medal_type) =  1 AND MAX(medal_type) = 'gold';

