-- 5 Kyu - Count IP Addresses
/*
    Given a database of first and last IPv4 addresses, calculate the number of 
    addresses between them (including the first one, excluding the last one).
*/
-- Aku sayang kamu! ❤️🧡💛💚💙💜🤍
CREATE OR REPLACE FUNCTION IPToInt(ipAddress TEXT) RETURNS BIGINT AS $$
DECLARE
    OCTETS TEXT[];
    ipInt BIGINT;
BEGIN
    OCTETS := string_to_array(ipAddress, '.');
    ipInt := 0;

    FOR i IN 1..4 LOOP
        ipInt := ipInt << 8;
        ipInt := ipInt + CAST(OCTETS[i] AS BIGINT);
    END LOOP;

    RETURN ipInt;
END;
$$ LANGUAGE plpgsql;

SELECT 
  ID,
   (IPToInt(ip_addresses.last) - IPToInt(ip_addresses.first) ) AS ips_between

FROM ip_addresses;



SELECT id, last::inet - first::inet AS ips_between
FROM ip_addresses;



SELECT
DISTINCT id,
(d4+d3*256+d2*256*256+d1*256*256*256) as ips_between
FROM
(SELECT *,
cast(split_part(last,'.',1) as bigint) - cast(split_part(first,'.',1) as bigint) as d1,
cast(split_part(last,'.',2) as bigint) - cast(split_part(first,'.',2) as bigint) as d2,
cast(split_part(last,'.',3) as bigint) - cast(split_part(first,'.',3) as bigint) as d3,
cast(split_part(last,'.',4) as bigint) - cast(split_part(first,'.',4) as bigint) as d4
FROM ip_addresses) as ip;



SELECT id, inet (last) - inet (first) AS ips_between
FROM ip_addresses;



CREATE OR REPLACE FUNCTION ip_value(text) RETURNS bigint 
AS $$
DECLARE
  ip bigint[] := string_to_array($1, '.')::bigint[];
BEGIN
   RETURN (ip[1]*16777216 + ip[2]*65536 + ip[3]*256 + ip[4]);
END;
$$ LANGUAGE plpgsql;

SELECT id, ABS(ip_value(first) - ip_value(last)) AS ips_between
FROM ip_addresses



SELECT id, 
       case when first::inet > last::inet 
            then first::inet - last::inet 
         else last::inet - first::inet 
       end as ips_between

FROM ip_addresses;



SELECT id
        ,((SPLIT_PART(last, '.',  1)::bigint - SPLIT_PART(first, '.',  1)::int)*256^3
        + (SPLIT_PART(last, '.',  2)::int    - SPLIT_PART(first, '.',  2)::int)*256^2
        + (SPLIT_PART(last, '.',  3)::int    - SPLIT_PART(first, '.',  3)::int)*256^1
        + (SPLIT_PART(last, '.',  4)::int    - SPLIT_PART(first, '.',  4)::int)*256^0)::bigint AS ips_between
  FROM ip_addresses;



SELECT * 
FROM ip_addresses;

Select id, ((CAST(substring(last,'[^\.]*') AS BIGINT) - CAST(substring(first,'[^\.]*') AS BIGINT)) * 	16777216) +
           ((CAST(substring(substring(last,'[^\.]*\.[^\.]*'),'[^\.]*$') AS BIGINT) -  CAST(substring(substring(first,'[^\.]*\.[^\.]*'),'[^\.]*$') AS BIGINT)) * 65536 ) +
           ((CAST(substring(substring(last,'[^\.]*\.[^\.]*$'),'[^\.]*') AS BIGINT) -  CAST(substring(substring(first,'[^\.]*\.[^\.]*$'),'[^\.]*') AS BIGINT)) * 256) +
           ((CAST(substring(last,'[^\.]*$') AS BIGINT) - CAST(substring(first,'[^\.]*$') AS BIGINT)) * 	1) AS ips_between
FROM ip_addresses



select
  i.id,
  (
    0
    + (i.last_ip[1]::int - i.first_ip[1]::int) * 256^3
    + (i.last_ip[2]::int - i.first_ip[2]::int) * 256^2
    + (i.last_ip[3]::int - i.first_ip[3]::int) * 256
    + (i.last_ip[4]::int - i.first_ip[4]::int)
  )::int8 as ips_between
from
  (
    select
      l.id,
      string_to_array(l.first, '.') as first_ip,
      string_to_array(l.last,  '.') as last_ip
    from
      ip_addresses l
  ) i
;



CREATE FUNCTION Ip2Integer (text) RETURNS BIGINT
AS 
$$
    BEGIN
          RETURN (split_part($1, '.',1)::Bigint * 256^3) +
          (split_part($1, '.',2)::Bigint * 256^2) +
          (split_part($1, '.',3)::Bigint * 256) +
          (split_part($1, '.',4)::Bigint);
    END;
$$ LANGUAGE plpgsql;

SELECT id, (Ip2Integer(last) - Ip2Integer(first)) as ips_between  FROM ip_addresses;



-- 5 Kyu - Employees and managers: part 2
/*
    Given a database of first and last IPv4 addresses, calculate the number of 
    addresses between them (including the first one, excluding the last one).
*/
WITH RECURSIVE EmployeeHierarchy AS (
  -- Anchor part: Get employees and assign the top-level manager's information
  SELECT 
    id, 
    name, 
    manager_id, 
    CAST('' AS TEXT) AS management_chain, 
    id AS top_manager_id,
    name AS top_manager_name
  FROM employees
  WHERE manager_id IS NULL

  UNION ALL

  -- Recursive part: Join with employees table to get each employee's immediate manager
  SELECT 
    e.id, 
    e.name, 
    e.manager_id, 
    CASE 
      WHEN e.manager_id = e.id THEN ''  -- If an employee is their own manager (top-level)
      ELSE CONCAT(EH.management_chain, ' -> ') 
    END || EH.name || ' (' || e.manager_id || ')', 
    EH.top_manager_id,
    EH.top_manager_name
  FROM employees e
  INNER JOIN EmployeeHierarchy EH ON e.manager_id = EH.id
)

-- Select from the recursive CTE and order by id
SELECT id, name, 

  CASE 
    WHEN manager_id IS NULL THEN '' -- For top-level managers
    ELSE SUBSTRING(management_chain FROM 5) -- Remove the first '->' for others
  END AS management_chain


FROM EmployeeHierarchy
ORDER BY id;

/*
compare_with expected do
  spec do
    it "WITH RECURSIVE should be used and not as a part of the comment :-)" do
      recursive_count = $sql.scan(/^(?!.*(\/\*|--)).*WITH\s+RECURSIVE/i).count
      expect(recursive_count).to eq(1)
    end 
  end
end
*/



with recursive management(id, name, management_chain) as (
  select id, name, '' as management_chain
  from employees
  where manager_id is null
  union all
  select e.id, e.name, trim(' -> ' from m.management_chain || ' -> ' || m.name || ' (' || m.id || ')') as management_chain
  from employees e, management m
  where e.manager_id = m.id
)

select * from management order by id



with recursive employees_recursive (chain) as
(
select '' as chain
     , *
  from employees
 where manager_id is null
 union all 
 select case when chain = ''
             then ''
             else format('%s -> ', chain)
        end  
        || format('%s (%s)', er.name, er.id)
        as chain
      , e.*
   from employees e
  inner join employees_recursive er
     on e.manager_id = er.id
)
select r.id
     , r.name
     , r.chain as management_chain
  from employees_recursive r
 order by 1



 WITH RECURSIVE management AS (
  SELECT id, name,
    ARRAY[]::text[] AS management_chain
  FROM employees
  WHERE manager_id IS NULL
  UNION
  SELECT employees.id, employees.name,
    management_chain || format('%s (%s)', management.name, management.id) AS management_chain
  FROM management
  JOIN employees ON manager_id = management.id
)
SELECT id, name,
  array_to_string(management_chain, ' -> ') AS management_chain
FROM management
ORDER BY id



WITH RECURSIVE t AS 
(
  SELECT id
        ,name
        ,'' AS management_chain
    FROM Employees
  WHERE manager_id IS NULL
  UNION ALL
  SELECT e.id
        ,e.name
        ,t.management_chain || t.name || ' (' || t.id || ')' || ' -> '
    FROM Employees e INNER JOIN t ON t.id = e.manager_id
)
SELECT id
      ,name
      ,RTRIM(management_chain, ' -> ') AS management_chain
  FROM t
ORDER BY id ASC



WITH RECURSIVE r(id, name, manager_id, management_chain) AS (
    SELECT e.*, ARRAY[] :: TEXT[] AS management_chain FROM employees e WHERE e.manager_id IS NULL
    UNION ALL
    SELECT e.*, ARRAY_APPEND(r.management_chain, CONCAT(r.name, ' (', r.id, ')')) AS management_chain
    FROM employees e JOIN r ON r.id = e.manager_id
)
SELECT id, name, ARRAY_TO_STRING(management_chain, ' -> ') AS management_chain
FROM r ORDER BY id;



WITH RECURSIVE staff AS (
SELECT e.id, e.name, coalesce(m.name || ' (' || m.id::text || ')','') AS manager_name, m.id AS manager_id, 1 AS lvl
  FROM employees e
       LEFT JOIN employees m
              ON m.id = e.manager_id
 UNION
SELECT s.id, s.name, m.name || ' (' || m.id::text || ')' , m.id, s.lvl + 1
  FROM staff s
       INNER JOIN employees e
                  LEFT JOIN employees m
                         ON m.id = e.manager_id
               ON e.id = s.manager_id
 WHERE e.manager_id is not null)
 
SELECT e.id, e.name,
       string_agg(m.manager_name, ' -> ' ORDER BY m.lvl desc) AS management_chain
  FROM staff e
       LEFT JOIN staff m
              ON e.id = m.id
 WHERE e.lvl = 1
 GROUP BY e.id, e.name



 WITH RECURSIVE t1 AS (
  SELECT
    id,
    name,
    manager_id,
    ARRAY[]::TEXT[] AS arr
  FROM employees
  WHERE manager_id IS NULL
  
  UNION ALL
  
  SELECT
    e.id,
    e.name,
    e.manager_id,
    t1.arr || FORMAT('%s (%s)', t1.name, t1.id) AS arr
  FROM employees AS e
  INNER JOIN t1
    ON t1.id = e.manager_id
)

SELECT
    id,
    name,
    ARRAY_TO_STRING(arr, ' -> ') AS management_chain
FROM t1
ORDER BY id
