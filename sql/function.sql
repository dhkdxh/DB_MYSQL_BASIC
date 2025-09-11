create database sqldb;

use sqldb;

CREATE TABLE usertbl -- 회원 테이블
( userID  	CHAR(8) NOT NULL PRIMARY KEY, -- 사용자 아이디(PK)
  name    	VARCHAR(10) NOT NULL, -- 이름
  birthYear   INT NOT NULL,  -- 출생년도
  addr	  	CHAR(2) NOT NULL, -- 지역(경기,서울,경남 식으로 2글자만입력)
  mobile1	CHAR(3), -- 휴대폰의 국번(011, 016, 017, 018, 019, 010 등)
  mobile2	CHAR(8), -- 휴대폰의 나머지 전화번호(하이픈제외)
  height    	SMALLINT,  -- 키
  mDate    	DATE  -- 회원 가입일
);
CREATE TABLE buytbl -- 회원 구매 테이블(Buy Table의 약자)
(  num 		INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- 순번(PK)
   userID  	CHAR(8) NOT NULL, -- 아이디(FK)
   prodName 	CHAR(6) NOT NULL, --  물품명
   groupName 	CHAR(4)  , -- 분류
   price     	INT  NOT NULL, -- 단가
   amount    	SMALLINT  NOT NULL, -- 수량
   FOREIGN KEY (userID) REFERENCES usertbl(userID)
);

INSERT INTO usertbl VALUES('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-8-8');
INSERT INTO usertbl VALUES('KBS', '김범수', 1979, '경남', '011', '2222222', 173, '2012-4-4');
INSERT INTO usertbl VALUES('KKH', '김경호', 1971, '전남', '019', '3333333', 177, '2007-7-7');
INSERT INTO usertbl VALUES('JYP', '조용필', 1950, '경기', '011', '4444444', 166, '2009-4-4');
INSERT INTO usertbl VALUES('SSK', '성시경', 1979, '서울', NULL  , NULL      , 186, '2013-12-12');
INSERT INTO usertbl VALUES('LJB', '임재범', 1963, '서울', '016', '6666666', 182, '2009-9-9');
INSERT INTO usertbl VALUES('YJS', '윤종신', 1969, '경남', NULL  , NULL      , 170, '2005-5-5');
INSERT INTO usertbl VALUES('EJW', '은지원', 1972, '경북', '011', '8888888', 174, '2014-3-3');
INSERT INTO usertbl VALUES('JKW', '조관우', 1965, '경기', '018', '9999999', 172, '2010-10-10');
INSERT INTO usertbl VALUES('BBK', '바비킴', 1973, '서울', '010', '0000000', 176, '2013-5-5');
INSERT INTO buytbl VALUES(NULL, 'KBS', '운동화', NULL   , 30,   2);
INSERT INTO buytbl VALUES(NULL, 'KBS', '노트북', '전자', 1000, 1);
INSERT INTO buytbl VALUES(NULL, 'JYP', '모니터', '전자', 200,  1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '모니터', '전자', 200,  5);
INSERT INTO buytbl VALUES(NULL, 'KBS', '청바지', '의류', 50,   3);
INSERT INTO buytbl VALUES(NULL, 'BBK', '메모리', '전자', 80,  10);
INSERT INTO buytbl VALUES(NULL, 'SSK', '책'    , '서적', 15,   5);
INSERT INTO buytbl VALUES(NULL, 'EJW', '책'    , '서적', 15,   2);
INSERT INTO buytbl VALUES(NULL, 'EJW', '청바지', '의류', 50,   1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2);
INSERT INTO buytbl VALUES(NULL, 'EJW', '책'    , '서적', 15,   1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2);

SELECT * FROM usertbl;
SELECT * FROM buytbl;

set @myVar1 = 5;
select @myVar1 as var1;

set @myVar2 = 3;
select @myVar2 as var2;

set @myVar3 = 4.25;
select round(@myVar3, 2) as var3;

set @myVar4 = '가수 이름==>';
select @myVar4 as var4;

select round(@myVar2+@myVar3, 2) as sum;

select * from usertbl;
select name from usertbl;

select @myVar4, name, height from usertbl where height > 180 order by height desc limit 1;

-- limit option은 원칙적으로 변수를 사용할 수 없음. Prepare와 Execute 문을 활용해서 변수에 적용할 수 있음
set @myVar1 = 3;
prepare myquery
    from 'select name, height from usertbl order by height limit ?';
Execute myquery using @myVar1;

-- 데이터 형식과 형변환 함수 cast(), convert()
select * from buytbl;

-- 소수점이 설득력 없을 때 있음 (요청사항이 개수이기 때문) ->  그때 double 형태를 signed integer로 바꾸는 것이 좋음
select cast(avg(amount) as signed integer) as average
from buytbl;
select convert(avg(amount), signed integer) as average
from buytbl; -- 반올림된 정수의 결과를 확인할 수 있음

-- 날짜의 적용
select cast(now() as date) as '오늘 날짜';
select cast(sysdate() as date) as '오늘 날짜';

-- buytbl에서 단가(price)와 수량을 곱한 값(amount)을 실제 입금 액으로  표시하는 쿼리 작성
select num,concat(cast(price as char(10)),'X',cast(amount as char(4))) as '단가 x 수량',amount*price as '구매액'
from buytbl
order by amount*price asc;

select '100'+'200'; -- 문자와 문자를 더하면 자동적으로 정수로 casting하여 출력/java에서는 그냥 붙여짐
select concat('100', '200'); -- 이렇게 해야 문자처럼 붙여짐
select concat(100,'200'); -- concat은 문자로 처리하는 함수이므로 varchar로 casting됨
select 1> '2mega'; -- 0이 됨 이는 비교연산자 이므로 그냥 2mega를 2로 처리하기 때문에 false가 되므로 0
select 3 > '2mega'; -- 1 이는 3과 2를 비교하는 것임
select 0 = 'mega2'; -- 이는 숫자로 변경해도 mega2는 0이 됨, 변경할 숫자가 없다고 판단됨

-- 제어 흐름 함수
select if(100>200, 'true', 'false');
select ifnull(null, 'null입니다'), ifnull('hi', 'null입니다');
select nullif(100,100), nullif('100', 100);
select case 100
    when 1 then '숫자 1'
    when 5 then '숫자 5'
    when 10 then '숫자 10'
    when 100 then '숫자 100'
    else '에라 모르겠다'
end as 'CASE 연습';

-- 문자열 함수
select ASCII(65), CHAR(65);
select bit_length('가나다') as bitlength,
       char_length('가나다') as charlength,
       length('가나다') as length;

select concat_ws('/', '2025', '09', '11');
select format(123456.123456, 4); -- 1000 단위로 콤마 찍어줌!
select bin(10), hex(10), oct(10);
select insert('hello world', 7, 5, 'name'), insert('abcdefghi', 3,2, '@@@@');
select left('abcdefghi', 3), right('abcdefghi', 3);
select lpad('this', 5, '***'), rpad('this', 5, '***');
select char_length(' this       ');
select char_length(trim(' th i s       '));

select repeat('*', 10);
select replace('This is hello world!', 'This', 'That');
select reverse('This');
select substring('This is my world', 6, 2); -- substr(), mid()와 동일한 함수
select substring_index('cafe.naver.com', '.', 2);
select substring_index('cafe.naver.com', '.', -2);

-- 수학 함수
select ceiling(4.5);
select ceiling(-5.67);
select floor(4.5);
select round(4.5);

select mod(5,2);
select pow(10,2);

