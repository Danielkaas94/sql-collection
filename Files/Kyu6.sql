-- 6 Kyu - SQL Basics: Simple EXISTS
/*
For this challenge you need to create a SELECT statement, 
this SELECT statement will use an EXISTS to check whether a department has had a sale with a price over 98.00 dollars.

Kata: https://www.codewars.com/kata/58113a64e10b53ec36000293/train/sql
*/
SELECT * 

FROM 
  Departments
  
WHERE EXISTS 
(
	SELECT *

	FROM 
	  sales 
	  
	WHERE 
	  department_id = Departments.id AND price > 98.00
)
