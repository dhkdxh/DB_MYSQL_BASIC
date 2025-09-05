create table customers(
	customer_id integer primary key,
    full_name varchar(40),
    email varchar(50),
    phone varchar(50),
    created_at varchar(50)
);

create table products(
	product_id integer primary key,
    name varchar(40),
    company varchar(40),
    price integer,
    stock_qty integer,
    created_at varchar(50)
);

create table orders(
	order_id integer primary key, 
    customer_id integer,
    product_id integer,
    order_date date,
    saleprice integer,
    foreign key (customer_id) references customers(customer_id),
    foreign key (product_id) references products(product_id)
);

drop table customers;

insert into customers values(3,'Park Jisoo', 'jisoo.park@daum.net', '010-3333-4444', now());
select * from customers;
commit;

insert into products values(5,'Notebook A5', 'Stationery',   2500, 500, now());
select * from products;
commit;

insert into orders values(2, 2,5,STR_TO_DATE( '2025-09-01','%Y-%m-%d'), 2000);
select * from orders;
commit;
