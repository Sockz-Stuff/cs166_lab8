/* Q1 */
SELECT COUNT(supplier)
FROM part_nyc
WHERE on_hand > 70;


/* Q2 */
select sum(p.total + q.total) as Total
from
(
select sum(on_hand) as total
from part_nyc
where color = 0
) p,
(
select sum(on_hand) as total
from part_sfo
where color = 0
) q
;

/* Q3 */
select distinct s.supplier_id, s.supplier_name 
from 
supplier s, 
(
select supplier, sum(on_hand) as total
from part_nyc
group by supplier
) x,
(
select supplier, sum(on_hand) as total
from part_sfo
group by supplier
) y
where s.supplier_id  = x.supplier and x.supplier = y.supplier and x.total > y.total 
order by s.supplier_id
;
/* Q4 *//*
select distinct p.supplier
from part_nyc p
where p.part_number not in (
select part_number
from part_sfo)
order by p.supplier
;*/

select distinct s.supplier_id, s.supplier_name
from supplier s, part_nyc p
where s.supplier_id=p.supplier and p.part_number in
(select p.part_number
from supplier s, part_nyc p
where s.supplier_id=p.supplier
except
select q.part_number
from supplier s, part_sfo q
where s.supplier_id=q.supplier)
order by s.supplier_id;

/*
select distinct s.supplier_name
from supplier s,part_nyc p, part_sfo q
where s.supplier_id=p.supplier and p.part_number not in(q.part_number)
;
*/

/* Q5 */
update part_nyc
set on_hand = on_hand - 10;

/* Q6 */
delete from part_nyc where on_hand < 30;

