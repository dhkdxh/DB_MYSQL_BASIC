-- 대한민국에 거주하는 고객의 정보를 조회
select *  from customer;

select *
from customer
where address like '대한민국%';

-- 도서 주문을 한 고객의 이름을 출력
select name
from customer
where custid in (select custid from orders);


-- 대한민국에 거주한 고객들도 나오면서, 주문 이력이 있는 명단도 합쳐서 출력
select name
from customer
where address like '대한민국%'

union

select name
from customer
where custid in (select custid from orders);

-- oracle에서는 MINUS, INTERSECT  연산자 지원
-- mysql에서는 지원이 안됨 -> not in 이용한 query문 만들기

-- 대한민국에 거주하는 고객의 이름에서 도서를 주문한
-- 고객의 이름을 빼고 조회하기

select name
from customer
where address like '대한민국%' and name not in (
select name
from customer
where custid in (select custid from orders));

-- 대한민국에 거주하는 고객 중에서 도서를 주문한 고객의 이름을 나타내기
select name
from customer
where address like '대한민국%' and name in (
select name
from customer
where custid in (select custid from orders));

select * from orders;

-- 도서를 주문하지 않은 고객의 이름을 보이기
select name
from customer
where custid not in (
	select custid from orders);
    
select name, address
from customer cs
where exists(
	select * from orders o
    where cs.custid = o.custid
);
