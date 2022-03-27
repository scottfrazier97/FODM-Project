use sakila;

select *,Category_count/Total_Movies_Rented
from
	(select customer_id,Genre,Category_count, sum(Category_count) over (partition by customer_id) as Total_Movies_Rented
	from
		(select customer_id, cust_cat.name as Genre,count(cust_cat.name) as Category_count
		from

			(select inventory_id,customer_id, title,all_film.name

			from

				(select rental.inventory_id,customer_id,film_id
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

		group by customer_id,cust_cat.name) as cat_count) as Total_Rented

;







