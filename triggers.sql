drop sequence if exists part_number_seq;
create sequence part_number_seq start with 5000 increment by 1;


create or replace language plpgsql;

create or replace function myfunc()
returns "trigger" as
$BODY$
BEGIN

NEW.part_number = part_number_seq;
return NEW;

END;
$BODY$
language plpgsql volatile;

drop trigger if exists nyc_part_inc on part_nyc;

create trigger nyc_part_inc
before insert 
on part_nyc
for each row
execute procedure myfunc();

drop trigger if exists sfo_part_inc on part_sfo

create trigger part_sfo_inc
before insert 
on part_sfo
for each row
execute myfunc();
