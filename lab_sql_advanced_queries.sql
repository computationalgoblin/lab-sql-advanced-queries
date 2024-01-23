-- List each pair of actors that have worked together.
select distinct concat(a1.first_name," ",  a1.last_name) as "actor 1", concat(a2.first_name, " ", a2.last_name) as "actor 2"
from film_actor fa1 join actor a1 on a1.actor_id = fa1.actor_id 
join film_actor fa2 on fa1.actor_id <> fa2.actor_id and fa1.film_id = fa2.film_id 
join actor a2 on a2.actor_id = fa2.film_id and a1.actor_id <> a2.actor_id;

-- For each film, list actor that has acted in more films.
select f.title, a.first_name, a.last_name, count(fa.film_id) as film_count 
from film_actor fa
join actor a
on fa.actor_id = a.actor_id
join film f
on fa.film_id = f.film_id
group by f.film_id, a.actor_id
having count(fa.film_id) = (select count(film_id) as max_count_film
from film_actor
where film_id = f.film_id
group by film_id
order by max_count_film desc
limit 1
)
order by f.film_id, film_count;