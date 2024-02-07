
-- Script:
CREATE TABLE airbnb_searches (
  user_id INT, 
  date_searched DATE, 
  filter_room_types VARCHAR(200)
);

DELETE FROM airbnb_searches;

INSERT INTO airbnb_searches VALUES
(1,'2022-01-01','entire home,private room')
,(2,'2022-01-02','entire home,shared room')
,(3,'2022-01-02','private room,shared room')
,(4,'2022-01-03','private room')
;

/* Question : 
Find the room types that are searched most no of times.
Output the room type alongside the number of searches for it.
If the filter for room types has more than one room types, conside each unique room type as separate row.
Sort the result based on the number of searches in descending order.
*/
SELECT 
  value as room_type, 
  COUNT(1) AS no_of_searches 
FROM 
  airbnb_searches CROSS APPLY string_split(filter_room_types, ',') 
GROUP BY 
  value 
ORDER BY 
  no_of_searches DESC;