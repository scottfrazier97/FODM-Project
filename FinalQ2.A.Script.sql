select *
from	
    (select  *,row_number() over (partition by Genre  order by Genre, Total_Rentals desc) as Popularity
	from
	(select cust_cat.name as Genre,title,count(title) as Total_Rentals
			from

				(select inventory_id,title,all_film.name

				from

					(select rental.inventory_id,film_id
					from rental
					left join  inventory
					on rental.inventory_id = inventory.inventory_id) as cust_film

				left join

					(select film.film_id,title,film_cat.name
					from film
					left join

						(select category.category_id,category.name,film_id
						from category
						left join film_category
						on category.category_id= film_category.category_id) as film_cat

					on film.film_id=film_cat.film_id) as all_film

				on cust_film.film_id = all_film.film_id) as cust_cat
		group by title) as Rental_Totals) as Genre_Popularity
where Popularity <=5;

		