use bookmarkedb;

select *
from book
where bookname like '_구%';

-- 3-10
select * from book
where (price>=20000) and bookname like '%축구%';

-- 3-11
select * from book
where publisher in ('굿스포츠' , '대한미디어');

-- 3-12 order by 는 default로 bookid ASC(ascending)가 숨어져있는 것임(기본 정렬)
-- 내림차순은 DESC임
select * from book order by bookid DESC;

select * from book
order by bookname ASC; -- 정렬 시 알파벳 우선

-- 3-13
select * from book
order by price ASC, bookname ASC; -- 뒤에 그냥 조건 추가하면 됨

-- 3-14
select * from book
order by price DESC, publisher ASC;



