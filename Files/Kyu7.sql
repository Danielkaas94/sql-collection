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