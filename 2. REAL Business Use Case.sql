-- Create Statement
CREATE TABLE tickets (
    ticket_id VARCHAR(10),
    create_date DATE,
    resolved_date DATE
);

CREATE TABLE holidays (
    holiday_date DATE,
    reason VARCHAR(100)
);

-- Delete Statement
DELETE FROM tickets;
DELETE FROM holidays;

-- Insert Statement
INSERT INTO tickets VALUES
(1,'2022-08-01','2022-08-03'),
(2,'2022-08-01','2022-08-12'),
(3,'2022-08-01','2022-08-16');

INSERT INTO holidays VALUES
('2022-08-11','Rakhi'),
('2022-08-15','Independence day');

-- Question: Write a sql to find business day between create date and resolved date by excluding weekends and public holidays

-- Method 1 - 
WITH c1 AS (
  SELECT 
    *, 
    DATEDIFF(day, create_date, resolved_date) AS actual_days, 
    2 * DATEDIFF(week, create_date, resolved_date) AS no_of_weekends 
  FROM 
    tickets
), 
c2 AS(
  SELECT 
    ticket_id, 
    COUNT(holiday_date) OVER (PARTITION BY ticket_id) AS no_of_holidays 
  FROM 
    tickets 
    LEFT JOIN holidays ON holiday_date BETWEEN create_date AND resolved_date
) 
SELECT 
  c1.ticket_id, 
  create_date, 
  resolved_date, 
  actual_days - no_of_weekends - no_of_holidays 
FROM 
  c1, 
  c2 
WHERE 
  c1.ticket_id = c2.ticket_id 
GROUP BY 
  c1.ticket_id, 
  create_date, 
  resolved_date;
