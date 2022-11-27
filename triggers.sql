drop sequence if exists part_number_val;
create sequence part_number_val start with 5000 increment by 1;


create or replace language plpgsql;

create or replace function myfunc()
returns "trigger" as
$BODY$
BEGIN

NEW.part_number = nextval('part_number_val');
return NEW;

END
$BODY$
language plpgsql volatile;

drop trigger if exists nyc_partinc on part_nyc;
/*drop trigger if exists sfo_partinc on part_sfo;*/

create trigger nyc_partinc
before insert 
on part_nyc
for each row
execute procedure myfunc();
/*
drop trigger if exists sfo_partinc on part_sfo;

create trigger part_sfoinc
before insert 
on part_sfo
for each row
execute procedure myfunc();*/
