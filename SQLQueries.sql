                                                        -- Cleaning and Exploring Cyclist Data for the Q1 2019 --
											--Objective: Finding the difference between casual and member riding behaviours --

-- Looking at the Data

SELECT *
FROM [Portfolio Projects]..Q1CylistData


--Dropping null values --

SELECT * 
FROM [Portfolio Projects]..Q1CylistData
WHERE gender IS NULL OR birthyear IS NULL

DELETE FROM [Portfolio Projects]..Q1CylistData WHERE gender IS NULL OR birthyear IS NULL


-- Adding a new column to set tripduration in minutes

ALTER TABLE [Portfolio Projects]..Q1CylistData
ADD tripduration_mins float;

UPDATE [Portfolio Projects]..Q1CylistData
SET tripduration_mins = ROUND(tripduration/60, 2)

-- Adding a new column to see the age
ALTER TABLE [Portfolio Projects]..Q1CylistData
ADD age int;

UPDATE [Portfolio Projects]..Q1CylistData
SET age = (2019 - birthyear)

--Adding a new column to see weekdays

ALTER TABLE [Portfolio Projects]..Q1CylistData
ADD week_day int;

UPDATE [Portfolio Projects]..Q1CylistData
SET week_day = DATEPART(WEEKDAY, start_time)


--Exploring the Data

SELECT usertype, AVG(tripduration_mins) AS AverageTripDuration 
FROM [Portfolio Projects]..Q1CylistData
GROUP BY usertype
--Result: Member's average duration is 13.8 minutes per trip while casual riders ride for 37 mins per trip

SELECT usertype, AVG(age) as Age
FROM [Portfolio Projects]..Q1CylistData
GROUP BY usertype
--Result: Average age of member is 37 while avg age of casual riders is 29


SELECT usertype, from_station_name, COUNT(from_station_name) AS count_of_station
FROM [Portfolio Projects]..Q1CylistData
WHERE usertype = 'Customer'
GROUP BY usertype, from_station_name
ORDER BY count_of_station DESC
--Result Casual Riders take most of their trips from Lake Shore Dr & Monroe St and Streeter Dr & Grand Ave. 
--While members take most of their trips from Clinton St & Washington Blvd

SELECT usertype, to_station_name, COUNT(to_station_name) AS count_of_station
FROM [Portfolio Projects]..Q1CylistData
--WHERE usertype = 'Customer'
GROUP BY usertype, to_station_name
ORDER BY count_of_station DESC
--Result: Casual Riders usually end most of their trips at Streeter Dr & Grande Ave, Millenium Park and Lake Shore Dr & Monroe St
-- While members end most of their trips at Clinton St & Washington Blvd 


SELECT usertype, week_day, COUNT(DISTINCT week_day) as week_day
FROM [Portfolio Projects]..Q1CylistData
GROUP BY usertype, week_day

SELECT DISTINCT week_day, usertype, COUNT(usertype) as number_users
FROM [Portfolio Projects]..Q1CylistData
GROUP BY week_day, usertype
ORDER BY number_users DESC
--Result: Most members take bike trips on Friday followed by Saturday while most casual riders take bike trips on Sunday and Monday.
