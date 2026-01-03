create database OnlineBookstore;

-- OnlineBookstore;

drop table if exists books;

create table books
(
	Book_ID serial primary key,
	Title varchar(100),
	Author varchar(100),
	Genre varchar(100),
	Published_Year int,
	Price numeric(10, 2),
	stock int
);

drop table if exists customers;

create table customers
(
	Customer_ID serial primary key,
	Name varchar(100),
	Email varchar(100),
	Phone varchar(15),
	City varchar(50),
	Country varchar(150)
);

drop table if exists Orders;

create table Orders
(
	Order_ID serial primary key,
	Customer_ID int references Customers(Customer_ID),
	Book_ID int references Books(Book_ID),
	Order_Date date,
	Quantity int,
	Total_Amount numeric(10, 2)
);

select * from books;

select * from customers;

select * from Orders;

copy books(Book_ID, Title, Author, Genre, Published_Year, Price, stock)
from 'C:\Users\Admin\Desktop\SQL Project_Online Book Store\Books.csv'
csv header;

copy customers(Customer_ID, Name, Email, Phone, City, Country)
from 'C:\Users\Admin\Desktop\SQL Project_Online Book Store\Customers.csv'
csv header;

copy Orders(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount)
from 'C:\Users\Admin\Desktop\SQL Project_Online Book Store\Orders.csv'
csv header;


--Queries--


--1) 
select * from books
where genre = 'Fiction';

--2)
select * from books
where published_year > 1950;

--3)
select * from customers
where country = 'Canada';

--4)
select * from orders
where order_date between '2023-11-01' and '2023-11-30';

--5)
select sum(stock) from books;

--6)
select * from books
order by price desc
limit 1;

--7)
select c.Name,c.Email, c.Phone, c.City, c.Country, o.Quantity
from customers as c
join Orders as o
on c.Customer_ID = o.Customer_ID
where o.quantity > 1;

--8)
select * from Orders
where Total_Amount > 20;

--9)
select distinct(genre) from books;

--10)
select * from books
order by stock
limit 1;

--11)
select sum(total_amount) as Revenue
from orders;

--12)
select b.genre, sum(o.quantity) as total_quantity
from books as b
join orders as o
on b.book_id = o.book_id
group by b.genre;

--13)
select avg(price) as avg_price
from books 
where genre = 'Fantasy';

--14)
select c.customer_id, c.Name, c.Email, c.phone, c.city, c.country, count(c.customer_id) as total_order
from customers as c
join orders as o
on c.customer_id = o.customer_id
group by c.customer_id
having count(c.customer_id) >= 2;

--15)
select b.book_id, b.title, count(o.book_id) as total_count_sold
from books as b
join orders as o 
on b.book_id = o.book_id
group by b.book_id
order by total_count_sold desc
limit 1;


--16)
select * from books
where genre = 'Fantasy'
order by price desc
limit 3;

--17)
select b.author, sum(o.quantity) as total_quantity
from books as b
join orders as o
on b.book_id = o.book_id
group by b.author;

--18)
select c.city, o.total_amount
from customers as c
join orders as o
on c.customer_id = o.customer_id
where o.total_amount > 30;

--19)
select c.name, sum(o.total_amount) as total_spent
from customers as c
join orders as o
on c.customer_id = o.customer_id
group by c.name
order by total_spent desc;

--20)
select b.title, coalesce(sum(o.quantity), 0) as total_order_quantity, 
b.stock - coalesce(sum(o.quantity), 0) as remaining_quantity
from books as b
left join orders as o
on b.book_id = o.book_id
group by b.book_id;



