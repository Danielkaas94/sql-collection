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






-- SQL Basics: Simple SUM
/*
For this challenge you need to create a simple SUM statement that will sum all the ages.

Kata: https://www.codewars.com/kata/58110da0009b4f7ef80000ad
*/
SELECT SUM(age) AS age_sum FROM people;






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
	
	
	
	
	
	
-- Easy SQL: Convert to Hexadecimal
/*
Your task is to sort the information in the provided table 'companies' by number of employees (high to low).

Kata: https://www.codewars.com/kata/593ed37c93350098d600001d
*/
SELECT * FROM companies
ORDER BY employees DESC







-- Easy SQL: LowerCase
/*
Given a demographics table. 
You need to return the same table where all letters are lowercase in the race column.

Kata: https://www.codewars.com/kata/594800ba6fb152624300006d
*/
SELECT id, name, birthday, LOWER(race) AS race
FROM demographics 


-- Easy SQL: LowerCase2
SELECT *, lower(race) AS race
FROM demographics



-- Easy SQL: Rounding Decimals
/*
Return a table with two columns (number1, number2) where the values in number1 have been rounded down and the values in number2 have been rounded up.

Kata: https://www.codewars.com/kata/594a6133704e4daf5d00003d
*/
SELECT FLOOR(number1) AS number1, 
       CEILING(number2) AS number2 
	   
FROM decimals;



-- SQL Basics: Simple DISTINCT
/*
	For this challenge you need to create a simple DISTINCT statement, you want to find all the unique ages.
*/
SELECT 
  DISTINCT(age) 

FROM 
  people



 -- Grasshopper - Check for factor
/*
	This function should test if the factor is a factor of base.
	Return true if it is a factor or false if it is not.
*/
SELECT
  id,

CASE 
  WHEN base % factor = 0 
    THEN 
      TRUE 
    ELSE 
      FALSE 
END AS res
  
FROM kata


-- Function 2 - squaring an argument
--# write your SQL statement here: 
-- you are given a table 'square' with column 'n'
-- return a table with:
--   this column and your result in a column named 'res'
SELECT 
  n, 
  (n*n) AS res
  
FROM SQUARE

-- Alternative #1
SELECT n,
       CAST(POWER(n, 2)as int) as res
FROM square
-- Alternative #2
SELECT
  n,
  POWER(n, 2)::integer AS res
FROM square
-- Alternative #3
select n, cast(n^2 as integer) as res from square
-- Alternative #4
select n, cast(pow(n,2) as Int) as res
from square
