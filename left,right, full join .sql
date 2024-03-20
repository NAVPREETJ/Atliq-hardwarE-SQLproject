select
title
from movies m
left join languages l
on m.language_id=l.language_id where l.name="telugu";
select 
m.title,l.name
from movies m
join languages l
on m.language_id=l.language_id ;
select
l.name,
count(m.movie_id) as no_movies
from languages l
left join movies m
using (language_id)
group by language_id
order by no_movies desc;
