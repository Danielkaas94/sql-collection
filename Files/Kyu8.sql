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
/*
Nathan loves cycling.

Because Nathan knows it is important to stay hydrated, he drinks 0.5 litres of water per hour of cycling.

You get given the time in hours and you need to return the number of litres Nathan will drink, rounded to the smallest value.

Kata: https://www.codewars.com/kata/582cb0224e56e068d800003c
*/
SELECT 
  id, hours, FLOOR(hours/2) as liters

FROM 
  cycling
  
  
-- 8 Kyu - Keep Hydrated2!
SELECT *, trunc(hours* 0.5)  AS liters FROM cycling
  
  
  
  
  
  
-- 8 Kyu - Adults only (SQL for Beginners #1)
/*
In your application, there is a section for adults only. You need to get a list of names and ages of users from the users table, who are 18 years old or older.

Kata: https://www.codewars.com/kata/590a95eede09f87472000213
*/
SELECT * 

FROM 
  users

WHERE 
  age >= 18
    
  
  
  
  
  
-- 8 Kyu - SQL Basics: Mod
/*
Return a table with one column (mod) which is the output of number1 modulus number2.

Kata: https://www.codewars.com/kata/590a95eede09f87472000213
*/
SELECT number1 % number2 as mod 

FROM decimals


-- 8 Kyu - SQL Basics: Mod2
SELECT MOD(number1, number2)
FROM decimals