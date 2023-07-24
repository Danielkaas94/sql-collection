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


 -- 7 Kyu - SQL Basics - Position
/*
	In each row, the characteristic column has a single comma. Your job is to find it using position().
	The comma column will contain the position of the comma within the characteristics string. Order the results by comma.
*/
SELECT
	id,
	name,
	position(',' IN characteristics) AS comma
  
FROM 
	monsters
  
ORDER BY 
	comma
	
	

 -- 7 Kyu - SQL Basics: Simple JOIN with COUNT
/*
	Create a simple SELECT statement that will return all columns from the people table, 
	and join to the toys table so that you can return the COUNT of the toys.
	You should return all people fields as well as the toy count as "toy_count".
*/
SELECT 
  people.*,
  Count(toys.*) AS toy_count

FROM 
  people
  
LEFT OUTER JOIN 
  toys ON toys.people_id = people.id
  
GROUP BY 
  people.id
  
  
  
  /*
  🔥💗🧡💛💚💙💜🤍🔥
  Write your SQL statement here: 
  you are given a table 'disemvowel' with column 'str', 
  return a table with column 'str' 
  and your result in a column named 'res'.
  🔥💗🧡💛💚💙💜🤍🔥
*/

SELECT
  str,
  translate(str, 'xaeiouAEIOU', 'x') AS res

FROM Disemvowel

/* Results
  This website is for losers LOL!                                 =>	Ths wbst s fr lsrs LL!
  No offense but, Your writing is among the worst I've ever read  =>	N ffns bt, Yr wrtng s mng th wrst 'v vr rd
  What are you, a communist?                                      =>	Wht r y, cmmnst?
*/

-- Alternative #1
select str, regexp_replace(str, '[aeiou]', '', 'ig') res
from disemvowel
-- Alternative #2
select str, regexp_replace(str,'[e|a|i|u|o]','','ig' ) as res from disemvowel
-- Alternative #3
SELECT str, REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(str, 'a', ''), 'e', ''), 'i', ''), 'o', ''), 'u', ''), 'A', ''), 'E', ''), 'I', ''), 'O', ''), 'U', '') AS res
FROM disemvowel;


 -- 7 Kyu - SQL: Padding Encryption
/*
	Problem is the table looks so unbalanced - the sha256 column contains much longer strings. 
    You need to balance things up. Add '1' to the end of the md5 addresses as many times as you need 
    to to make them the same length as those in the sha256 column. 
    Add '0' to the beginning of the sha1 values to achieve the same result.
*/

SELECT 
  CONCAT(md5, '11111111111111111111111111111111') AS md5,
  CONCAT('000000000000000000000000', sha1) AS sha1,
  sha256
FROM encryption

select RPAD(md5, length(sha256), '1') md5,
       LPAD(sha1, length(sha256), '0') sha1,
       sha256
  from encryption

SELECT 
  CONCAT(md5, REPEAT('1', (LENGTH(sha256) - LENGTH(md5)))) as md5,
  CONCAT(REPEAT('0', (LENGTH(sha256) - LENGTH(sha1))), sha1) as sha1,
  sha256
FROM encryption


SELECT md5||REPEAT('1', 32) AS md5,
       REPEAT('0', 24)||sha1 AS sha1,
       sha256
FROM encryption

select
  md5 || repeat('1', sha256_length - md5_length) as md5,
  repeat('0', sha256_length - sha1_length) || sha1 as sha1,
  sha256
from
(
  select *, length(md5) as md5_length, length(sha1) as sha1_length, length(sha256) as sha256_length
  from encryption
) as encryption_with_lengths;



 -- 7 Kyu - Filtering Films by Special Features in PostgreSQL: Part 3
/*
    Write a PostgreSQL query that selects film_id, the title and special_features columns from the film table in the DVD rental database, 
    and returns films that have either "Deleted Scenes" or "Behind the Scenes" as a special feature, 
    but not both - meaning that if there are "Deleted Scenes", there should not be "Behind the Scenes" and vice versa. 
    The query should also exclude films that have "Commentaries" as a special feature.
*/
-- Aku sayang kamu! ❤️🧡💛💚💙💜🤍
SELECT 
    film_id,
    title,
    special_features

FROM film

WHERE 
(
    'Deleted Scenes' = ANY (special_features)
    AND NOT 'Behind the Scenes' = ANY (special_features)
    AND NOT 'Commentaries' = ANY (special_features)
)
OR
(
    'Behind the Scenes' = ANY (special_features)
    AND NOT 'Deleted Scenes' = ANY (special_features)
    AND NOT 'Commentaries' = ANY (special_features)
)
ORDER BY title, film_id



SELECT film_id, title, special_features
  FROM film
  WHERE ('Deleted Scenes' = ANY(special_features)) != ('Behind the Scenes' = ANY(special_features))
    AND NOT 'Commentaries' = ANY(special_features)
  ORDER BY title, film_id



SELECT film_id, title, special_features
FROM film
WHERE CARDINALITY(ARRAY(SELECT * FROM UNNEST(special_features) 
                        WHERE UNNEST = ANY(ARRAY['Deleted Scenes', 'Behind the Scenes'])
                       ) 
                 ) = 1 
      AND NOT ('Commentaries' = ANY(special_features))
ORDER BY title, film_id



Select film_id, title, special_features
FROM film
WHERE (
  ('Behind the Scenes' = ANY (special_features) AND NOT ('Deleted Scenes' = ANY (special_features))) OR 
  ('Deleted Scenes' = ANY (special_features) AND NOT ('Behind the Scenes' = ANY (special_features)))
)
   AND NOT ('Commentaries' = ANY (special_features))
ORDER BY title, film_id ASC;



SELECT film_id, title, special_features
FROM film
WHERE special_features && ARRAY['Deleted Scenes', 'Behind the Scenes']
  AND NOT special_features @> ARRAY['Deleted Scenes', 'Behind the Scenes']
  AND NOT special_features @> ARRAY['Commentaries']
ORDER BY title, film_id



select film_id, title, special_features from film 
where (special_features::text like '%Deleted Scenes%' and special_features::text not like '%Behind the Scenes%'
and special_features::text not like '%Commentaries%') 
or
(special_features::text like '%Behind the Scenes%' and special_features::text not like '%Deleted Scenes%'
and special_features::text not like '%Commentaries%')
order by title, film_id
