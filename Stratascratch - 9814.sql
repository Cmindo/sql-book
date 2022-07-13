/*

Problem: https://platform.stratascratch.com/coding/9814-counting-instances-in-text

*/

select
    word,
    count(word) as occur
from(
    select lower(unnest(string_to_array(contents, ' '))) as word
    from google_file_store) as tbl1
where word IN ('bull','bear')
group by word
order by count(word) desc