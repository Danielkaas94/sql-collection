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





-- 8 Kyu - SQL Basics: Simple WHERE and ORDER BY
/*
For this challenge you need to create a simple SELECT statement that will return all columns from the people table WHERE their age is over 50

You should return all people fields where their age is over 50 and order by the age descending

Kata: https://www.codewars.com/kata/5809508cc47d327c12000084
*/
SELECT *

FROM 
  people

WHERE 
  age > 50 

ORDER BY age DESC







-- 8 Kyu - SQL Basics: Simple MIN / MAX
/*
For this challenge you need to create a simple MIN / MAX statement that will return the Minimum and Maximum ages out of all the people.

Kata: https://www.codewars.com/kata/sql-basics-simple-min-slash-max/sql
*/
SELECT MIN(age) AS age_min, 
       MAX(age) AS age_max
  FROM people







-- 8 Kyu - Easy SQL: Convert to Hexadecimal
/*
To hexYou have access to a table of monsters.

Your task is to turn the numeric columns (arms, legs) into equivalent hexadecimal values.

Kata: https://www.codewars.com/kata/easy-sql-convert-to-hexadecimal/train/sql
*/
-- PostgreSQL 9.6
SELECT to_hex(legs) AS legs, 
       to_hex(arms) AS arms
    FROM monsters