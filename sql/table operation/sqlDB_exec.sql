-- 1-5
select * from orders;
select * from book;

select * from customer;

select c.name as '이름', count(distinct b.publisher) as '출판사 수'
from orders o
	join book b on o.bookid = b.bookid
    join customer c on o.custid = c.custid
group by c.name
having c.name = '박지성';

-- 1-6
select b.bookname as '도서이름', b.price as 가격, b.price-o.saleprice as '가격 차이'
from orders o
	join book b on o.bookid = b.bookid
    join customer c on o.custid = c.custid
where c.name = '박지성';

-- 1-7
select bookname as '도서이름'
from book
where bookid not in (
	select bookid from orders where custid = 1);
    
-- 2-8
select name
from customer
where custid not in (
	select custid from orders
);

-- 2-9
select sum(saleprice) as '총 주문 금액' , avg(saleprice) as '평균 금액'
from orders;

-- 2-10
select c.name as '이름', sum(o.saleprice) as '구매액'
from orders o
	join customer c on o.custid = c.custid
group by c.name;

-- 2-11
select c.name as '이름', b.bookname as '도서 이름'
from orders o
	join customer c on o.custid = c.custid
    join book b on b.bookid = o.bookid;
    
-- 2-12
select *
from orders o
	join book b on o.bookid = b.bookid
where (b.price - o.saleprice) = (select max(b1.price - o1.saleprice) from orders o1 join book b1 on o1.bookid = b1.bookid);
    
-- 2-13
select c.name as '고객 이름'
from orders o
	join customer c on o.custid = c.custid
    join book b on b.bookid = o.bookid
group by c.name
having avg(o.saleprice) > (select avg(newo.saleprice) from orders newo);