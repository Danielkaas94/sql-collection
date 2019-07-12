-- 8 Kyu - On the Canadian Border (SQL for Beginners #2)
/*
You are a border guard sitting on the Canadian border. You were given a list of travelers who have arrived at your gate today. You know that American, Mexican, and Canadian citizens don't need visas, so they can just continue their trips. You don't need to check their passports for visas! You only need to check the passports of citizens of all other countries!

Select names, and countries of origin of all the travelers, excluding anyone from Canada, Mexico, or The US.

Kata: https://www.codewars.com/kata/590ba881fe13cfdcc20001b4
*/
SELECT *

FROM 
  travelers

WHERE 
  country NOT LIKE 'Canada' AND
  country NOT LIKE 'USA' AND
  country NOT LIKE 'Mexico'
  
  
  
  
  
  
-- 8 Kyu - Keep Hydrated!
SELECT 
  id, hours, FLOOR(hours/2) as liters

FROM 
  cycling
  
-- 8 Kyu - Keep Hydrated2!
SELECT *, trunc(hours* 0.5)  AS liters FROM cycling