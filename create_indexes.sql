drop index if exists index1;
drop index if exists index2;
/*drop index if exists index3;*/
create index index1
on part_nyc (supplier, on_hand, part_number)
;

create index index2
on part_sfo (supplier, on_hand, part_number)
;
/*
create index index3
on supplier(supplier_name,supplier_id)
;*/
