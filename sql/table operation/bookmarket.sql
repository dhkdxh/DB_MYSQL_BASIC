-- Book table 생성
create table book(
	bookid integer primary key, -- 중복이 안되는 값이라는 뜻(primary key)
    bookname varchar(40),
    publisher varchar(40),
    price integer
);

create table customer(
	custid integer primary key,
    name varchar(40),
    address varchar(50),
    phone varchar(20)
);

create table orders(
	orderid integer primary key,
    custid integer, -- pk
    bookid integer, -- pk
    saleprice integer,
    orderdatae date,
    -- reference key로 지정
    foreign key (custid) references customer(custid),
    foreign key (bookid) references book(bookid)
);