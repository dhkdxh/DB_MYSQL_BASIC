use bookmarkedb;

delimiter ##
create procedure createBoard(in title varchar(100), content text, writer varchar(50), date datetime)
begin
    insert into boardtable values (null, title, content, writer, date);
end ##
delimiter ;

delimiter ##
create procedure searchOne(in no int)
begin
    select * from boardtable where bno=no;
end ##
delimiter ;

delimiter ##
create procedure updateBoard(in title varchar(100), content text, writer varchar(50), no int)
begin
    update boardtable set btitle=title,bcontent=content,bwriter=writer where bno=no;
end ##
delimiter ;

delimiter ##
create procedure deleteBoard(in no int)
begin
    delete from boardtable where bno=no;
end ##
delimiter ;

delimiter ##
create procedure searchAll()
begin
    select * from boardtable;
end ##
delimiter ;
