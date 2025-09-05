use bookmarkedb;

CREATE TABLE people (

id INT AUTO_INCREMENT PRIMARY KEY,  -- 사람을 식별할 수 있는 id , 데이터 추가시 자동적으로 번호 증가 
name VARCHAR(64), -- 사람의 이름
age INT unsigned-- 사람의 나이 저장
);

CREATE TABLE card_company(

id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(64),
amount_of_payment INT,
payment_location VARCHAR(64),
paymentdate DATETIME,
people_id INT 
);


INSERT INTO people (id, name, age) VALUES(1,'김사원',24);

INSERT INTO people (NAME,age) VALUES('구대리',28);

INSERT INTO people (NAME,age) VALUES('허차장',42);

INSERT INTO people (NAME,age) VALUES('차부장',45);

INSERT INTO people (NAME,age) VALUES('홍임원',54);

insert into people values(null,'test', 55); -- id 생각해줘야하니 앞에 null 넣어주기
delete from people where id = 3;
commit;
select * from people;
-- 자료만 다 날리기
truncate table people;

desc card_company;

insert into card_company VALUES(1,'NH',30000,'배달서비스','2019-11-09 23:02',1);
-- 순서를 맞춰야지만 들어감

insert into card_company (name,amount_of_payment,payment_location,paymentdate,people_id) VALUES('shinhan',7700,'편의점','2019-11-09 10:10',1);
insert into card_company (name,amount_of_payment,payment_location,paymentdate,people_id) VALUES('KB',4500,'편의점','2019-11-09 15:21',1);
insert into card_company (name,amount_of_payment,payment_location,paymentdate,people_id) VALUES('KB',8550,'당구장','2019-11-09 19:35',1);
insert into card_company (name,amount_of_payment,payment_location,paymentdate,people_id) VALUES('shinhan',330000,'명품신발','2019-11-09 05:00',2);
insert into card_company (name,amount_of_payment,payment_location,paymentdate,people_id) VALUES('shinhan',4500000,'명품옷','2019-11-09 07:00',2);
insert into card_company (name,amount_of_payment,payment_location,paymentdate,people_id) VALUES('NH',400000,'돈 인출','2019-11-09 11:00',3);
insert into card_company (name,amount_of_payment,payment_location,paymentdate,people_id) VALUES('NH',1300000,'사성냉장고','2019-11-09 15:00',3);
insert into card_company (name,amount_of_payment,payment_location,paymentdate,people_id) VALUES('NH',10000000,'골프','2019-11-09 17:00',4);
insert into card_company (name,amount_of_payment,payment_location,paymentdate,people_id) VALUES('NH',15000000,'유흥','2019-11-09 03:00',4);
insert into card_company (name,amount_of_payment,payment_location,paymentdate,people_id) VALUES('NH',500,'문방구','2019-11-09 04:00',6);
commit;

select count(id) from card_company; -- count는 null을 제외하고 count하기 때문에 null이 들어갈 수 없는 속성을 count해주면 정확

##########################################################
-- join 연산 종류
-- 1. cross join -> 곱하기 연산과 똑같음 행*행
-- 2. inner join -> equi join -> where절에 =를 이용하여 지정하는 키가 속성값이 같은 row만 사용하겠다
-- 3. outer join -> left outer join, right outer join, full outer join
-- 4. self join

-- 1. 사람 정보 table의 구조와 데이터를 확인
select * from people;
-- 2. 카드 지출 내역 table의 구조와 데이터를 확인
select * from card_company;

-- people과 card_company를 join하여 자신의 카드 정보만 출력될 수 있도록 쿼리문
select *
from people p
	join card_company c on c.people_id = p.id
order by p.id;

select *
from people p, card_company c
where p.id = c.people_id;

-- 카드 사용 내역이 없는 사람의 정보를 포함하여 사용자들의 카드 정보 내역을 조회하시오
select *
from people p left outer join card_company c on p.id = c.people_id;


select *
from people p right outer join card_company c on p.id = c.people_id;


-- self join

CREATE table ugaga_tribes (
id INT AUTO_INCREMENT PRIMARY KEY ,
name VARCHAR(64),
classes_id INT
);

insert into ugaga_tribes VALUES(1,'족장_우가콜라',null);


insert into ugaga_tribes (name,classes_id) VALUES('부족장_우가펩시',1);
insert into ugaga_tribes (name,classes_id) VALUES('부하1_우가팔일오',2);
insert into ugaga_tribes (name,classes_id) VALUES('부하2_우가우간다',3);
insert into ugaga_tribes (name,classes_id) VALUES('부하3_우가막내',4);

select * from ugaga_tribes;
commit;

-- 부족의 조직관계, 즉 나의 직속상사의 정보를 출력하세요
select ut_a.id, ut_a.name as '부하', ut_b.name as '나의 상사'
from ugaga_tribes ut_a
	join ugaga_tribes ut_b on ut_a.classes_id = ut_b.id; 
    
-- 상관이 없는 부족원의 정보를 출력하시오
select  ut_a.id, ut_a.name as '부하', ut_b.name as '나의 상사'
from ugaga_tribes ut_a left outer join ugaga_tribes ut_b on ut_a.classes_id = ut_b.id;

