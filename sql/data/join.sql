use bookmarkedb;

desc book;
desc customer;

-- 고객은 주문을 통해 책을 구매할 수 있음
desc orders;

-- 고객의 이름과 고객이 주문한 책에 관한 데이터를 구하시오
select *
from customer, orders, book
where customer.custid = orders.custid and orders.bookid = book.bookid
order by customer.custid ASC;

-- 박지성 고객이 주문한 도서의 총 구매액을 알고 싶음(join)
select count(*) from customer, orders; -- 50 row
select count(*) from  customer; -- 5 row
select count(*) from  orders; -- 10 row

-- 고객과 고객에 관한 데이터를 모두 출력
select *
from customer, orders
where customer.custid = orders.custid
order by customer.custid ASC;

-- 고객의 이름과 고객이 주문한 도서의 판매가격을 출력하기
select name, saleprice
from customer,orders
where customer.custid = orders.custid
order by customer.custid ASC;

select * from orders;

-- 고객 별로 주문한 모든 도서의 총 판매액을 구하고, 고객 별로 정렬하시오
select name, sum(saleprice) as 총판매액
from customer, orders
where customer.custid = orders.custid
group by customer.name
order by customer.name;

-- 고객의 이름과 고객이 주문한 도서의 이름을 조회사시오
select name, bookname
from customer, book, orders
where customer.custid = orders.custid and book.bookid = orders.bookid
order by customer.name ASC;

-- 가격이 20000인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오
select c.name, b.bookname, b.price
from customer c, book b, orders o
where c.custid = o.custid and b.bookid = o.bookid and b.price=20000;

-- 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 조회 (외부 조인) 
select * from customer;
select custid, bookid from orders group by custid, bookid;

select customer.name, orders.saleprice
from customer left outer join orders on customer.custid = orders.custid;