/*

Problem: https://www.hackerrank.com/challenges/print-prime-numbers/

*/

declare @counter INT;
set @counter = 1;
create table tbl (num INT);

while
    (@counter <= 1000)
begin
    insert into tbl (num)
    values (@counter)
    set @counter = @counter + 1
end;

select string_agg(num,'&') within group (order by num)
from tbl
where
    num NOT IN
        (select tb1.num
        from tbl tb1 join tbl tb2 on 1=1 and tb1.num!=tb2.num and tb1.num > tb2.num and tb2.num>1
        where tb1.num % tb2.num = 0)
    and
    num > 1;