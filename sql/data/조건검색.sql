use bookmarkedb; -- database를 선택해야함 무조건! mysql의 특징 ->검은색 칠해짐

select phone, name, address
from customer
where name='김연아';

-- booktable에서 도서 가격이 만원 이상인 도서의 책 제목과 출판사 명을 출력하세요.
desc book;
select bookname, publisher
from book
where price>=10000;

-- 모든 도서의 이름과 가격을 검색하시오
desc book;
select bookname, price
from book;

select bookid, bookname, publisher, price from book;
select * from book;

select distinct publisher from book; -- 중복 제거

-- 3-4
select * from book
where price<20000;

-- 3-5
select * from book
where price between 10000 and 20000;

-- 3-6
select * from book
where publisher in ('굿스포츠', '대한미디어');

select * from book
where publisher not in ('굿스포츠', '대한미디어');

-- 3-7
select bookname, publisher from book
where bookname like '축구의 역사';

-- 3-8
select bookname, publisher from book
where bookname like '%축구%';

