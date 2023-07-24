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