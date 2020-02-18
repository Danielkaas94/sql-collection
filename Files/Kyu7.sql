-- 7 Kyu - Best-Selling Books (SQL for Beginners #5)
/*
You work at a book store. It's the end of the month, and you need to find out the 5 bestselling books at your store.

Use a select statement to list names, authors, and number of copies sold of the 5 books which were sold most.

Kata: https://www.codewars.com/kata/best-selling-books-sql-for-beginners-number-5/train/sql
*/
SELECT *

FROM
  books
  
ORDER BY copies_sold DESC
  
LIMIT 5



-- 7 Kyu - SQL Basics: Raise to the Power
/*
Return a table with one column (result) which is the output of number1 raised to the power of number2.

Kata: https://www.codewars.com/kata/sql-basics-raise-to-the-power/train/sql
*/
SELECT 
  POWER(number1, number2) AS result

FROM
  decimals
  
  

-- 7 Kyu - SQL Basics: Repeat and Reverse
/*
	Where the name is the original string repeated three times (do not add any spaces),
	and the characteristics are the original strings in reverse (e.g. 'abc, def, ghi' becomes 'ihg ,fed ,cba').
*/
SELECT
  REPEAT(name,3) AS name,
  REVERSE(characteristics) AS characteristics

FROM
  monsters
  


-- 7 Kyu - Easy SQL: Counting and Grouping
/*
	You need to return a table that shows a count of each race represented,
	ordered by the count in descending order.
*/
SELECT 
  race, 
  Count(race)

FROM 
  demographics

GROUP BY 
  race
  
ORDER BY 
  count desc



-- 7 Kyu - GROCERY STORE: Logistic Optimisation
/*
	You have to find out how many products each of the Producer have.

	Order the result by unique_products (DESC)
	then by producer (ASC) in case there are duplicate amounts.
*/
SELECT
  COUNT(name) AS unique_products,
  producer

FROM
  products
  
GROUP BY
  producer
  
ORDER BY
  unique_products DESC,
  producer ASC
  
  
 
 -- 7 Kyu - Hello SQL World!
 /*
	Hello SQL!
	Return a table with a single column named Greeting with the phrase 'hello world!'
 */
 SELECT 'hello world!' AS "Greeting"