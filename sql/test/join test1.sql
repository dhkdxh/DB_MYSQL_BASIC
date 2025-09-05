use bookmarkedb;

select * from book;
select * from orders;

-- join test
-- 1
select name, book.bookname, book.price, str_to_date(orders.orderdatae, '%Y-%m-%d') as 날짜
from book,customer,orders
where customer.custid = orders.custid and book.bookid = orders.bookid
order by name;

select c.name, b.bookname, o.saleprice, o.orderdatae
from orders o
	join customer c on o.custid = c. custid
    join book b on b.bookid = o.bookid
order by c.name;

-- 2 
select book.publisher, book.bookname, customer.name, orders.orderdatae
from book, customer, orders
where customer.custid = orders.custid and book.bookid = orders.bookid and book.publisher like '대한미디어';

select c.name, b.bookname, o.saleprice, o.orderdatae
from orders o
	join customer c on c.custid = o.custid
    join book b on b.bookid = o.bookid
where b.publisher like '대한미디어';

-- 3
select orders.custid, customer.name, sum(saleprice) as '총 주문 금액'
from customer, orders
where customer.custid = orders.custid
group by customer.custid
order by sum(saleprice) desc;

-- 4
select customer.name, count(orderid)
from customer, orders
where customer.custid = orders.custid
group by customer.custid
having count(orderid)>=2;

-- 5
select customer.name
from customer left outer join orders on customer.custid = orders.custid
where bookid is null;

-- 6
select orders.orderid,book.bookid, book.bookname
from book left outer join orders on book.bookid = orders.bookid
where orders.orderid is null;

-- 7
select book.bookname, customer.name, min(orders.orderdatae)
from book, customer, orders
where customer.custid = orders.custid and book.bookid = orders.bookid
group by customer.name;

